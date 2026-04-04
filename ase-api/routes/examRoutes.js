const express = require('express');
const router = express.Router();
const { generateExam } = require('../controllers/examController');

// The base path '/api/exams' will be defined in the main index.js, 
// so we only need the end of the URL here.
router.get('/:examCode/generate', generateExam);

module.exports = router;