const express = require('express');
const router = express.Router();
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

// GET /api/admin/stats
router.get('/stats', async (req, res) => {
  try {
    // Aggregate high-level stats
    const totalUsers = await prisma.user.count();
    const totalExams = await prisma.examResult.count();
    const avgScoreAgg = await prisma.examResult.aggregate({
      _avg: { score_percentage: true }
    });

    // Fetch the 10 most recent exams taken on the platform
    const recentExams = await prisma.examResult.findMany({
      take: 10,
      orderBy: { created_at: 'desc' },
      include: {
        user: { select: { username: true, displayName: true } }
      }
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

module.exports = router;
