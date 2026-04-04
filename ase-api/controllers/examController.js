const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const generateExam = async (req, res) => {
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
};

module.exports = {
  generateExam
};