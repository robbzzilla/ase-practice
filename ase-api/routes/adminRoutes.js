const express = require('express');
const router = express.Router();
const { PrismaClient } = require('@prisma/client');
const { GoogleGenerativeAI } = require('@google/generative-ai');

const prisma = new PrismaClient();

// 1. GET /api/admin/stats
router.get('/stats', async (req, res) => {
  try {
    const totalUsers = await prisma.user.count();
    const totalExams = await prisma.examResult.count();
    const avgScoreAgg = await prisma.examResult.aggregate({ _avg: { score_percentage: true } });

    const recentExams = await prisma.examResult.findMany({
      take: 10,
      orderBy: { created_at: 'desc' },
      include: { user: { select: { username: true, displayName: true } } }
    });

    res.json({
      success: true,
      stats: {
        totalUsers,
        totalExams,
        averageScore: avgScoreAgg._avg.score_percentage ? Math.round(avgScoreAgg._avg.score_percentage) : 0,
        recentExams
      }
    });
  } catch (err) {
    console.error("Admin stats error:", err);
    res.status(500).json({ error: 'Failed to fetch admin stats' });
  }
});

// 2. GET /api/admin/question-counts
router.get('/question-counts', async (req, res) => {
  try {
    const counts = await prisma.$queryRaw`
      SELECT e.code, COUNT(q.id) as count
      FROM exams e
      LEFT JOIN questions q ON e.id = q.exam_id
      GROUP BY e.code
      ORDER BY e.code
    `;
    const formatted = counts.map(c => ({ code: c.code, count: Number(c.count) }));
    res.json({ success: true, counts: formatted });
  } catch (err) {
    console.error("Count error:", err);
    res.status(500).json({ error: 'Failed to fetch counts' });
  }
});

// 3. POST /api/admin/questions (Manual Insert)
router.post('/questions', async (req, res) => {
  const { examCode, topic, difficulty, stemText, explanationText, choices } = req.body;
  
  try {
    const exam = await prisma.$queryRaw`SELECT id FROM exams WHERE code = ${examCode}`;
    if (!exam || exam.length === 0) return res.status(404).json({error: 'Exam not found'});
    const examId = exam[0].id;

    const newQuestion = await prisma.$queryRaw`
      INSERT INTO questions (exam_id, topic, difficulty_level, stem_text, explanation_text, active_flag)
      VALUES (${examId}, ${topic}, ${difficulty || 'Medium'}, ${stemText}, ${explanationText}, TRUE)
      RETURNING id
    `;
    const questionId = newQuestion[0].id;

    for (let choice of choices) {
      await prisma.$queryRaw`
        INSERT INTO question_choices (question_id, choice_text, is_correct)
        VALUES (${questionId}, ${choice.text}, ${choice.isCorrect})
      `;
    }

    res.json({ success: true, message: 'Question added successfully' });
  } catch (err) {
    console.error("Insert error:", err);
    res.status(500).json({ error: 'Failed to add question' });
  }
});

// 4. POST /api/admin/generate-ai (NEW: Gemini AI Generation)
router.post('/generate-ai', async (req, res) => {
  const { examCode, topic, count } = req.body;

  if (!process.env.GEMINI_API_KEY) {
    return res.status(500).json({ error: 'GEMINI_API_KEY is missing from server environment variables.' });
  }

  try {
    // Initialize Gemini
    const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
    
    // Use Gemini 1.5 Flash and force it to return JSON
    const model = genAI.getGenerativeModel({ 
      model: "gemini-1.5-flash",
      generationConfig: { responseMimeType: "application/json" }
    });

    const prompt = `
      You are an expert automotive instructor writing questions for the ASE ${examCode} certification exam.
      Generate ${count || 3} multiple-choice questions focusing on the topic: "${topic || 'General'}".
      
      You MUST return your response as a valid JSON object containing a single array called "questions".
      Each object in the "questions" array must have the following exact structure:
      {
        "stemText": "The actual question text",
        "explanationText": "A detailed explanation of why the correct answer is right and the others are wrong",
        "choices": [
          { "text": "Choice A", "isCorrect": false },
          { "text": "Choice B", "isCorrect": true },
          { "text": "Choice C", "isCorrect": false },
          { "text": "Choice D", "isCorrect": false }
        ]
      }
      Ensure exactly one choice is true.
    `;

    const result = await model.generateContent(prompt);
    const responseText = result.response.text();
    
    // Parse the JSON returned by Gemini
    const parsedData = JSON.parse(responseText);
    
    res.json({ success: true, questions: parsedData.questions });
  } catch (err) {
    console.error("Gemini Generation error:", err);
    res.status(500).json({ error: 'Failed to generate questions with Gemini AI' });
  }
});

module.exports = router;
