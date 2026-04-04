const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

// Fetch the top 10 highest scores globally
const getLeaderboard = async (req, res) => {
  try {
    const topScores = await prisma.examResult.findMany({
      where: { mode: 'Exam' }, // Only count official exams
      take: 10,
      orderBy: { score_percentage: 'desc' },
      include: { user: true } // Pulls in the username/email
    });
    res.json({ success: true, leaderboard: topScores });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Failed to fetch leaderboard' });
  }
};

// Fetch a specific user's entire test history for the progress chart
const getUserHistory = async (req, res) => {
  const { email } = req.params;
  try {
    const user = await prisma.user.findUnique({ where: { username: email } });
    if (!user) return res.json({ success: true, history: [] });

    const history = await prisma.examResult.findMany({
      where: { user_id: user.id, mode: 'Exam' },
      orderBy: { created_at: 'asc' } // Oldest to newest for the line chart
    });
    res.json({ success: true, history });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Failed to fetch history' });
  }
};

module.exports = { getLeaderboard, getUserHistory };