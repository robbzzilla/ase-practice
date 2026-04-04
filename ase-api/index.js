const express = require('express');
const cors = require('cors');
const { PrismaClient } = require('@prisma/client');

const app = express();
const prisma = new PrismaClient(); // Initialize Prisma

const adminRoutes = require('./routes/adminRoutes'); // Add to the top with other requires

// Add this below app.use('/api/exams', examRoutes);
app.use('/api/admin', adminRoutes);

const gamifyRoutes = require('./routes/gamifyRoutes'); // Add to the top

// Add this below your other app.use() statements
app.use('/api/gamify', gamifyRoutes);

app.use(cors());
app.use(express.json());

app.get('/api/exams/:examCode/generate', async (req, res) => {
  const { examCode } = req.params;
  const { topic } = req.query;
  const questionLimit = 20;

  try {
    // 1. Find the exam ID
    const exam = await prisma.exams.findUnique({
      where: { code: examCode }
    });

    if (!exam) {
      return res.status(404).json({ error: 'Exam not found' });
    }

    // 2. Fetch questions AND their choices all at once using Prisma relations
    let questions = await prisma.questions.findMany({
      where: {
        exam_id: exam.id,
        active_flag: true,
        ...(topic ? { topic: topic } : {}) // Only filter by topic if it exists in the URL
      },
      include: {
        question_choices: true // Magically joins the choices table!
      }
    });

    // 3. Shuffle the questions in JavaScript and pick the top 20
    questions = questions.sort(() => 0.5 - Math.random()).slice(0, questionLimit);

    // 4. Shuffle the multiple choices for each question so the correct answer moves around
    questions.forEach(q => {
      q.choices = q.question_choices.sort(() => 0.5 - Math.random());
      delete q.question_choices; // Clean up the object name for the frontend
    });

    res.json({ success: true, questions });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Database error' });
  }
});

const PORT = process.env.PORT || 8080;
// --- NEW: Save a Score ---
app.post('/api/scores', async (req, res) => {
  const { username, examCode, percentage, mode, topicData } = req.body;

  try {
    // 1. Find or create the user (Dummy auth for now)
    const user = await prisma.user.upsert({
      where: { username: username || 'Guest' },
      update: {},
      create: { username: username || 'Guest' },
    });

    // 2. Save the exam result to the database
    const result = await prisma.examResult.create({
      data: {
        user_id: user.id,
        exam_code: examCode,
        score_percentage: percentage,
        mode: mode,
        topic_data: topicData // Saves the category breakdown as JSON
      }
    });

    res.json({ success: true, result });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to save score' });
  }
});

// --- NEW: Get All Scores for a User ---
app.get('/api/scores/:username', async (req, res) => {
  const { username } = req.params;

  try {
    const user = await prisma.user.findUnique({
      where: { username },
      include: { results: true } // Fetch all their test results
    });

    if (!user) return res.json({ success: true, results: [] });

    res.json({ success: true, results: user.results });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch scores' });
  }
});

app.listen(PORT, () => console.log(`API running on port ${PORT}`));