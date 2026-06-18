const express = require('express');
const cors = require('cors');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 5000;

// Enable CORS and parse JSON request bodies
app.use(cors());
app.use(express.json());

// Import routes
const bikesRouter = require('./routes/bikes');
const aiRouter = require('./routes/ai');

// Mount API routes
app.use('/api/bikes', bikesRouter);
app.use('/api/ai', aiRouter);

// Serve static frontend assets from the root directory
// Since server.js is located in server/, ".." refers to the project root containing index.html, css/, and js/
app.use(express.static(path.join(__dirname, '..')));

// Fallback to index.html for undefined routes (supporting routing)
app.get('*', (req, res, next) => {
  // If it looks like an API call, return 404 instead of serving HTML
  if (req.url.startsWith('/api')) {
    return res.status(404).json({ error: 'Endpoint not found' });
  }
  res.sendFile(path.join(__dirname, '..', 'index.html'));
});

// Start the server
app.listen(PORT, () => {
  console.log(`===================================================`);
  console.log(`🏍️ BikeAI Backend Running on http://localhost:${PORT}`);
  console.log(`===================================================`);
});
