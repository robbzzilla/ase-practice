const express = require('express');
const router = express.Router();
const { Pool } = require('pg');

// Use the single DATABASE_URL instead of individual variables
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

router.get('/:examCode/generate', async (req, res) => {
  const { examCode } = req.params;
  const { topic } = req.query;

  try {
    let queryText = `
      SELECT q.id, q.stem_text, q.explanation_text, q.topic 
      FROM questions q
      JOIN exams e ON q.exam_id = e.id
      WHERE e.code = $1 AND q.active_flag = TRUE
    `;
    const queryParams = [examCode];

    if (topic) {
      queryText += ` AND q.topic = $2`;
      queryParams.push(topic);
    }

    // Randomize the questions
    queryText += ` ORDER BY RANDOM() LIMIT 25`;

    const qResult = await pool.query(queryText, queryParams);
    const questions = qResult.rows;

    // Fetch choices for each question
    for (let q of questions) {
      const cResult = await pool.query(
        `SELECT id, choice_text, is_correct FROM question_choices WHERE question_id = $1 ORDER BY RANDOM()`,
        [q.id]
      );
      q.choices = cResult.rows;
    }

    res.json({ success: true, questions });
  } catch (err) {
    console.error("Error generating exam:", err);
    res.status(500).json({ error: 'Database error' });
  }
});

module.exports = router;