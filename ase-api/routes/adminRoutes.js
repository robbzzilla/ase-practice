const express = require('express');
const router = express.Router();
const { addQuestion } = require('../controllers/adminController');

// This will handle POST requests to /api/admin/questions
router.post('/questions', addQuestion);

module.exports = router;