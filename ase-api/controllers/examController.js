const pool = require('../db'); // Import the database connection

const generateExam = async (req, res) => {
  const { examCode } = req.params;
  const { topic } = req.query;
  const questionLimit = 20;

  try {
    let qResult;
    
    if (topic) {
      qResult = await pool.query(
        `SELECT q.id, q.stem_text, q.explanation_text, q.topic 
         FROM questions q JOIN exams e ON q.exam_id = e.id
         WHERE e.code = $1 AND q.topic = $2 AND q.active_flag = TRUE
         ORDER BY RANDOM()
         LIMIT $3`, [examCode, topic, questionLimit]
      );
    } else {
      qResult = await pool.query(
        `SELECT q.id, q.stem_text, q.explanation_text, q.topic 
         FROM questions q JOIN exams e ON q.exam_id = e.id
         WHERE e.code = $1 AND q.active_flag = TRUE
         ORDER BY RANDOM()
         LIMIT $2`, [examCode, questionLimit]
      );
    }
    
    const questions = qResult.rows;
    for (let q of questions) {
      const cResult = await pool.query(
        `SELECT id, choice_text, is_correct FROM question_choices WHERE question_id = $1 ORDER BY RANDOM()`, [q.id]
      );
      q.choices = cResult.rows;
    }
    res.json({ success: true, questions });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Database error' });
  }
};

// Export the function so the router can use it
module.exports = {
  generateExam
};