const express = require('express');
const router = express.Router();
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

router.get('/:examCode/generate', async (req, res) => {
  const { examCode } = req.params;
  const { topic } = req.query;

  try {
    let rawQuestions;

    if (topic) {
      rawQuestions = await prisma.$queryRaw`
        SELECT q.id, q.stem_text, q.explanation_text, q.topic 
        FROM questions q
        JOIN exams e ON q.exam_id = e.id
        WHERE e.code = ${examCode} AND q.active_flag = TRUE AND q.topic = ${topic}
        ORDER BY RANDOM() LIMIT 25
      `;
    } else {
      rawQuestions = await prisma.$queryRaw`
        SELECT q.id, q.stem_text, q.explanation_text, q.topic 
        FROM questions q
        JOIN exams e ON q.exam_id = e.id
        WHERE e.code = ${examCode} AND q.active_flag = TRUE
        ORDER BY RANDOM() LIMIT 25
      `;
    }

    const formattedQuestions = [];

    // Fetch choices and build a new object so Prisma doesn't strip the data
    for (let q of rawQuestions) {
      const choices = await prisma.$queryRaw`
        SELECT id, choice_text, is_correct 
        FROM question_choices 
        WHERE question_id = ${q.id} 
        ORDER BY RANDOM()
      `;
      
      formattedQuestions.push({
        ...q,
        choices: choices
      });
    }

    res.json({ success: true, questions: formattedQuestions });
  } catch (err) {
    console.error("Error generating exam:", err);
    res.status(500).json({ error: 'Database error' });
  }
});

module.exports = router;
