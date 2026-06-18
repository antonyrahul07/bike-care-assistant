const express = require('express');
const router = express.Router();
const path = require('path');
const fs = require('fs');

// Import the rule-based AI engine from the js/ folder
const { recommendBikes, diagnoseIssues, generateChatResponse } = require('../../js/ai-engine');

const dbPath = path.join(__dirname, '..', 'data', 'bikes-db.json');

// Helper to read database
function getBikesFromDB() {
  try {
    const data = fs.readFileSync(dbPath, 'utf8');
    return JSON.parse(data);
  } catch (error) {
    console.error('Error reading bikes database:', error);
    return [];
  }
}

// POST /api/ai/recommend - Scoring based bike advisor
router.post('/recommend', (req, res) => {
  const { budget, usage, daily_km, preference } = req.body;
  const bikes = getBikesFromDB();

  if (bikes.length === 0) {
    return res.status(500).json({ error: 'Bike database is empty or not loaded.' });
  }

  const recommendations = recommendBikes(bikes, { budget, usage, daily_km, preference });
  res.json(recommendations);
});

// POST /api/ai/diagnose - Troubleshooting engine
router.post('/diagnose', (req, res) => {
  const { bike_id, symptoms } = req.body;
  const bikes = getBikesFromDB();

  if (!bike_id) {
    return res.status(400).json({ error: 'bike_id is required for diagnostics.' });
  }

  if (!symptoms || (Array.isArray(symptoms) && symptoms.length === 0)) {
    return res.status(400).json({ error: 'symptoms are required for diagnostics.' });
  }

  const bike = bikes.find(b => b.id === bike_id.toLowerCase());
  if (!bike) {
    return res.status(404).json({ error: `Bike with ID ${bike_id} not found.` });
  }

  const matches = diagnoseIssues(bike, symptoms);
  res.json({
    bike: { id: bike.id, name: bike.name },
    diagnoses: matches
  });
});

// POST /api/ai/chat - Intent-based chat responder
router.post('/chat', (req, res) => {
  const { message, bike_id } = req.body;
  const bikes = getBikesFromDB();

  if (!message) {
    return res.status(400).json({ error: 'Message field is required.' });
  }

  const result = generateChatResponse(message, bike_id, bikes);
  res.json(result);
});

module.exports = router;
