const express = require('express');
const router = express.Router();
const { getLeaderboard, getUserHistory } = require('../controllers/gamifyController');

router.get('/leaderboard', getLeaderboard);
router.get('/history/:email', getUserHistory);

module.exports = router;