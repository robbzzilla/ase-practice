const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const addQuestion = async (req, res) => {
  const { examCode, stemText, explanationText, topic, choices } = req.body;

  try {
    // 1. Find the internal ID for the requested Exam (e.g., 'A1')
    const exam = await prisma.exams.findUnique({
      where: { code: examCode }
    });

    if (!exam) {
      return res.status(404).json({ error: 'Exam not found' });
    }

    // 2. Create the question AND its choices in one Prisma transaction
    const newQuestion = await prisma.questions.create({
      data: {
        exam_id: exam.id,
        stem_text: stemText,
        explanation_text: explanationText,
        topic: topic,
        active_flag: true,
        question_choices: {
          create: choices.map(c => ({
            choice_text: c.text,
            is_correct: c.isCorrect
          }))
        }
      }
    });

    res.json({ success: true, question: newQuestion });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Failed to add question' });
  }
};

module.exports = { addQuestion };