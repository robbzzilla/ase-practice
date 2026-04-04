const express = require('express');
const cors = require('cors');
const { PrismaClient } = require('@prisma/client');

const examRoutes = require('./routes/examRoutes');
const adminRoutes = require('./routes/adminRoutes');
const gamifyRoutes = require('./routes/gamifyRoutes');

const app = express();
const prisma = new PrismaClient();

app.use(cors());
app.use(express.json());

// Mount Routes
app.use('/api/exams', examRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/gamify', gamifyRoutes);

// NEW: Add a score saving route directly here (or move it to a scoreRoutes.js file)
app.post('/api/scores', async (req, res) => {
  const { username, examCode, percentage, mode, topicData } = req.body;
  try {
    const user = await prisma.user.upsert({
      where: { username: username || 'Guest' },
      update: {},
      create: { username: username || 'Guest' },
    });
    const result = await prisma.examResult.create({
      data: {
        user_id: user.id,
        exam_code: examCode,
        score_percentage: percentage,
        mode: mode,
        topic_data: topicData
      }
    });
    res.json({ success: true, result });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to save score' });
  }
});

app.get('/api/scores/:username', async (req, res) => {
  const { username } = req.params;
  try {
    const user = await prisma.user.findUnique({
      where: { username },
      include: { results: true }
    });
    if (!user) return res.json({ success: true, results: [] });
    res.json({ success: true, results: user.results });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch scores' });
  }
});

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => console.log(`API running on port ${PORT}`));