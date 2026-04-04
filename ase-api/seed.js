const { Pool } = require('pg');

const pool = new Pool({
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || '_[2:+nvM_E7;K4Ur',
  database: process.env.DB_NAME || 'postgres',
  host: process.env.DB_HOST || '127.0.0.1',
});

const exams = ['A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8'];
const QUESTIONS_PER_EXAM = 100;

async function seedDatabase() {
  try {
    console.log('Clearing old data...');
    await pool.query('TRUNCATE TABLE question_choices, questions CASCADE');

    for (const examCode of exams) {
      console.log(`Generating ${QUESTIONS_PER_EXAM} questions for ${examCode}...`);
      
      // Get the exam ID
      const examRes = await pool.query('SELECT id FROM exams WHERE code = $1', [examCode]);
      const examId = examRes.rows[0].id;

      for (let i = 1; i <= QUESTIONS_PER_EXAM; i++) {
        // Insert Question
        const qRes = await pool.query(
          `INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
           VALUES ($1, $2, $3, $4, TRUE) RETURNING id`,
          [
            examId, 
            `Sample Question ${i} for ${examCode}: Technician A says X. Technician B says Y. Who is right?`, 
            `Explanation for question ${i}: This is why the correct answer is right.`, 
            `Topic ${Math.ceil(Math.random() * 5)}`
          ]
        );
        const questionId = qRes.rows[0].id;

        // Insert Choices
        await pool.query(
          `INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
           ($1, 'Technician A only', FALSE),
           ($1, 'Technician B only', FALSE),
           ($1, 'Both Technician A and B', TRUE),
           ($1, 'Neither Technician A nor B', FALSE)`,
          [questionId]
        );
      }
    }
    console.log('Database successfully seeded with 800 questions!');
  } catch (err) {
    console.error('Error seeding database:', err);
  } finally {
    await pool.end();
  }
}

seedDatabase();