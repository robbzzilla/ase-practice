const express = require('express');
const router = express.Router();
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

// 1. GET /api/admin/stats (Existing stats)
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

// 2. GET /api/admin/question-counts (New: See how many questions per exam)
router.get('/question-counts', async (req, res) => {
  try {
    const counts = await prisma.$queryRaw`
      SELECT e.code, COUNT(q.id) as count
      FROM exams e
      LEFT JOIN questions q ON e.id = q.exam_id
      GROUP BY e.code
      ORDER BY e.code
    `;
    // Convert BigInt to Number for JSON serialization
    const formatted = counts.map(c => ({ code: c.code, count: Number(c.count) }));
    res.json({ success: true, counts: formatted });
  } catch (err) {
    console.error("Count error:", err);
    res.status(500).json({ error: 'Failed to fetch counts' });
  }
});

// 3. POST /api/admin/questions (New: Insert a question from the UI)
router.post('/questions', async (req, res) => {
  const { examCode, topic, difficulty, stemText, explanationText, choices } = req.body;
  
  try {
    // Find the exam ID
    const exam = await prisma.$queryRaw`SELECT id FROM exams WHERE code = ${examCode}`;
    if (!exam || exam.length === 0) return res.status(404).json({error: 'Exam not found'});
    const examId = exam[0].id;

    // Insert the question
    const newQuestion = await prisma.$queryRaw`
      INSERT INTO questions (exam_id, topic, difficulty_level, stem_text, explanation_text, active_flag)
      VALUES (${examId}, ${topic}, ${difficulty || 'Medium'}, ${stemText}, ${explanationText}, TRUE)
      RETURNING id
    `;
    const questionId = newQuestion[0].id;

    // Insert the 4 choices
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

module.exports = router;
