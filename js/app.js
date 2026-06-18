/**
 * BikeAI - Explorer Page Controller (js/app.js)
 */

document.addEventListener('DOMContentLoaded', () => {
  const searchInput = document.getElementById('bikeSearchInput');
  const filterButtons = document.querySelectorAll('.filter-btn');
  const cardsGrid = document.getElementById('bikeCardsGrid');
  
  let allBikes = [];
  let activeFilter = 'all';
  let searchQuery = '';
  let debounceTimeout = null;

  // Premium Brand Gradient Map for Visual Excellence
  const brandGradients = {
    'honda': 'linear-gradient(135deg, #e84118 0%, #1a1a24 100%)',
    'royal enfield': 'linear-gradient(135deg, #2f3640 0%, #13131a 100%)',
    'ktm': 'linear-gradient(135deg, #e67e22 0%, #1a1a24 100%)',
    'bajaj': 'linear-gradient(135deg, #0984e3 0%, #13131a 100%)',
    'tvs': 'linear-gradient(135deg, #00b894 0%, #1a1a24 100%)',
    'yamaha': 'linear-gradient(135deg, #6c5ce7 0%, #13131a 100%)',
    'suzuki': 'linear-gradient(135deg, #00cec9 0%, #1a1a24 100%)',
    'hero': 'linear-gradient(135deg, #fdcb6e 0%, #13131a 100%)'
  };

  // Fetch the initial bike list from the API
  async function fetchBikes() {
    try {
      // Connect to the local server port 5000 (standard endpoint)
      const response = await fetch('/api/bikes');
      if (!response.ok) {
        throw new Error('Failed to load bike database.');
      }
      allBikes = await response.json();
      renderBikesGrid();
    } catch (error) {
      console.error('Error fetching bike catalog:', error);
      cardsGrid.innerHTML = `
        <div style="grid-column: 1 / -1; text-align: center; padding: 3rem; color: var(--danger);">
          ⚠️ Failed to load bike catalog. Please ensure the backend server is running.
        </div>
      `;
    }
  }

  // Render cards grid based on filters and search queries
  function renderBikesGrid() {
    // Clear display
    cardsGrid.innerHTML = '';

    const filteredBikes = allBikes.filter(bike => {
      const matchesType = activeFilter === 'all' || bike.type === activeFilter;
      const matchesSearch = 
        bike.name.toLowerCase().includes(searchQuery) ||
        bike.brand.toLowerCase().includes(searchQuery) ||
        bike.type.toLowerCase().includes(searchQuery);
      
      return matchesType && matchesSearch;
    });

    if (filteredBikes.length === 0) {
      cardsGrid.innerHTML = `
        <div style="grid-column: 1 / -1; text-align: center; padding: 3rem; color: var(--text-secondary);">
          🔍 No bikes match your search or filter criteria.
        </div>
      `;
      return;
    }

    filteredBikes.forEach((bike, index) => {
      const brandKey = bike.brand.toLowerCase();
      const cardBg = brandGradients[brandKey] || 'linear-gradient(135deg, #6c63ff 0%, #1a1a24 100%)';
      
      const card = document.createElement('div');
      card.className = 'bike-card loaded';
      card.id = `card-${bike.id}`;
      // Stagger animations based on index
      card.style.animationDelay = `${index * 0.05}s`;

      card.innerHTML = `
        <div class="bike-card-image-stub" style="position:relative;">
  
  <img src="${bike.image}" 
       style="width:100%; height:180px; object-fit:cover; border-radius:12px;"
       onerror="this.src='https://via.placeholder.com/400x250?text=No+Image'">

  <span class="bike-badge" style="position:absolute; top:10px; right:10px;">
    ${bike.type}
  </span>

</div>
        <div class="bike-card-info">
          <span class="bike-card-brand">${bike.brand}</span>
          <h3>${bike.name}</h3>
          <div class="bike-card-price">₹${bike.price_inr.toLocaleString('en-IN')}</div>
          
          <div class="bike-card-specs">
            <div class="bike-card-spec-item">
              <span class="bike-card-spec-label">Engine</span>
              <span class="bike-card-spec-value">${bike.engine_cc} cc</span>
            </div>
            <div class="bike-card-spec-item">
              <span class="bike-card-spec-label">Mileage</span>
              <span class="bike-card-spec-value">${bike.mileage_kmpl} kmpl</span>
            </div>
            <div class="bike-card-spec-item">
              <span class="bike-card-spec-label">Power</span>
              <span class="bike-card-spec-value">${bike.power_bhp} BHP</span>
            </div>
          </div>
          
          <a href="bike-detail.html?id=${bike.id}" class="btn" id="btnView-${bike.id}">
            View Details ➔
          </a>
        </div>
      `;

      cardsGrid.appendChild(card);
    });
  }

  // Debouncing Search Input
  searchInput.addEventListener('input', (e) => {
    clearTimeout(debounceTimeout);
    debounceTimeout = setTimeout(() => {
      searchQuery = e.target.value.trim().toLowerCase();
      renderBikesGrid();
    }, 300);
  });

  // Filter Buttons Click Management
  filterButtons.forEach(btn => {
    btn.addEventListener('click', (e) => {
      filterButtons.forEach(b => b.classList.remove('active'));
      e.target.classList.add('active');
      activeFilter = e.target.dataset.type;
      renderBikesGrid();
    });
  });

  // Run initial fetch
  fetchBikes();
});
