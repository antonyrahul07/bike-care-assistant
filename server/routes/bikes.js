const express = require('express');
const router = express.Router();
const path = require('path');
const fs = require('fs');

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

// GET /api/bikes - Return basic details for all bikes
router.get('/', (req, res) => {
  const bikes = getBikesFromDB();
  const summaryList = bikes.map(bike => ({
    id: bike.id,
    name: bike.name,
    brand: bike.brand,
    type: bike.type,
    price_inr: bike.price_inr,
    mileage_kmpl: bike.mileage_kmpl,
    engine_cc: bike.engine_cc,
    power_bhp: bike.power_bhp
  }));
  res.json(summaryList);
});

// GET /api/bikes/type/:type - Filter by type (commuter|sports|cruiser)
router.get('/type/:type', (req, res) => {
  const type = req.params.type.toLowerCase();
  const bikes = getBikesFromDB();
  const filtered = bikes
    .filter(bike => bike.type === type)
    .map(bike => ({
      id: bike.id,
      name: bike.name,
      brand: bike.brand,
      type: bike.type,
      price_inr: bike.price_inr,
      mileage_kmpl: bike.mileage_kmpl,
      engine_cc: bike.engine_cc,
      power_bhp: bike.power_bhp
    }));
  res.json(filtered);
});

// GET /api/bikes/:id - Return full details for a single bike
router.get('/:id', (req, res) => {
  const id = req.params.id.toLowerCase();
  const bikes = getBikesFromDB();
  const bike = bikes.find(b => b.id === id);

  if (!bike) {
    return res.status(404).json({ error: `Bike with ID ${id} not found.` });
  }
  res.json(bike);
});

module.exports = router;
