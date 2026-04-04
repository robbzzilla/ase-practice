const express = require('express');
const router = express.Router();
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

// 1. GET /api/gamify/leaderboard
router.get('/leaderboard', async (req, res) => {
  try {
    const allResults = await prisma.examResult.findMany({
      where: { mode: 'Exam' },
      orderBy: { score_percentage: 'desc' },
      include: {
        user: { 
          select: { 
            username: true,
            displayName: true, // <-- ADDED
            shopName: true,    // <-- ADDED
            isPublic: true     // <-- ADDED
          } 
        }
      }
    });

    const seen = new Set();
    const leaderboard = [];

    for (const result of allResults) {
      const uniqueKey = `${result.user.username}-${result.exam_code}`;
      if (!seen.has(uniqueKey)) {
        seen.add(uniqueKey);
        leaderboard.push(result);
      }
    }

    res.json({ success: true, leaderboard: leaderboard.slice(0, 100) });
  } catch (err) {
    console.error("Leaderboard fetch error:", err);
    res.status(500).json({ error: 'Failed to fetch leaderboard' });
  }
});

// 2. GET /api/gamify/history/:username (NEW ROUTE FOR PROFILE PAGE)
router.get('/history/:username', async (req, res) => {
  const { username } = req.params;
  
  try {
    // Find the user and include all their exam results, newest first
    const user = await prisma.user.findUnique({
      where: { username: username },
      include: {
        results: {
          orderBy: { id: 'desc' } // Orders by newest attempts first
        }
      }
    });

    // If user doesn't exist yet, return an empty history array
    if (!user) {
      return res.json({ success: true, history: [] });
    }

    // Return the user's results
    res.json({ success: true, history: user.results });

  } catch (err) {
    console.error("History fetch error:", err);
    res.status(500).json({ error: 'Failed to fetch user history' });
  }
});

// GET /api/gamify/profile/:username - Fetch user profile
router.get('/profile/:username', async (req, res) => {
  try {
    const user = await prisma.user.findUnique({
      where: { username: req.params.username },
      select: { displayName: true, shopName: true, isPublic: true }
    });
    res.json({ success: true, profile: user || {} });
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch profile' });
  }
});

// PUT /api/gamify/profile/:username - Update user profile
router.put('/profile/:username', async (req, res) => {
  const { displayName, shopName, isPublic } = req.body;
  try {
    // Use upsert: Update the user if they exist, create them if they don't!
    const updatedUser = await prisma.user.upsert({
      where: { username: req.params.username },
      update: { displayName, shopName, isPublic },
      create: { 
        username: req.params.username,
        displayName, 
        shopName, 
        isPublic 
      }
    });
    res.json({ success: true, profile: updatedUser });
  } catch (err) {
    console.error("Profile save error:", err);
    res.status(500).json({ error: 'Failed to update profile' });
  }
});

module.exports = router;