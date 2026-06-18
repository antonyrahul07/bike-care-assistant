/**
 * Throttle AI - Bike Profile Detail Page Controller
 */

document.addEventListener('DOMContentLoaded', () => {

  const loadingDiv = document.getElementById('detailLoading');
  const errorDiv = document.getElementById('detailError');
  const profileDiv = document.getElementById('detailProfile');

  const nameEl = document.getElementById('bikeDetailName');
  const brandEl = document.getElementById('bikeDetailBrand');
  const typeEl = document.getElementById('bikeDetailType');
  const priceEl = document.getElementById('bikeDetailPrice');

  const specEngine = document.getElementById('specEngine');
  const specPower = document.getElementById('specPower');
  const specTorque = document.getElementById('specTorque');
  const specWeight = document.getElementById('specWeight');
  const specMileage = document.getElementById('specMileage');

  const featuresContainer = document.getElementById('featuresContainer');
  const prosContainer = document.getElementById('prosContainer');
  const consContainer = document.getElementById('consContainer');
  const issuesAccordion = document.getElementById('issuesAccordion');

  const stickyBanner = document.getElementById('stickyAiBanner');
  const stickyBikeName = document.getElementById('stickyBikeName');
  const stickyAiBtn = document.getElementById('stickyAiBtn');

  // 🆕 IMAGE ELEMENT
  const bikeImage = document.getElementById('bikeImage');

  const urlParams = new URLSearchParams(window.location.search);
  const bikeId = urlParams.get('id');

  if (!bikeId) {
    showError();
    return;
  }

  async function fetchBikeDetails() {
    try {
      const response = await fetch(`/api/bikes/${bikeId}`);
      if (!response.ok) throw new Error('Bike not found');

      const bike = await response.json();
      renderProfile(bike);

    } catch (error) {
      console.error(error);
      showError();
    }
  }

  function showError() {
    loadingDiv.style.display = 'none';
    profileDiv.style.display = 'none';
    errorDiv.style.display = 'block';
  }

  function renderProfile(bike) {

    // 🔥 IMAGE FIX
    if (bike.image) {
      bikeImage.src = bike.image;
    } else {
      bikeImage.src = "https://via.placeholder.com/400x250?text=No+Image";
    }

    // TEXT
    nameEl.textContent = bike.name;
    brandEl.textContent = bike.brand.toUpperCase();
    typeEl.textContent = bike.type.toUpperCase();
    priceEl.textContent = `₹${bike.price_inr.toLocaleString('en-IN')}`;

    // SPECS
    specEngine.textContent = `${bike.engine_cc} cc`;
    specPower.textContent = `${bike.power_bhp} BHP`;
    specTorque.textContent = `${bike.torque_nm} Nm`;
    specWeight.textContent = `${bike.weight_kg} kg`;
    specMileage.textContent = `${bike.mileage_kmpl} kmpl`;

    // FEATURES
    featuresContainer.innerHTML = '';
    bike.features.forEach(f => {
      const div = document.createElement('div');
      div.textContent = f;
      featuresContainer.appendChild(div);
    });

    // PROS
    prosContainer.innerHTML = '';
    bike.pros.forEach(p => {
      const li = document.createElement('li');
      li.textContent = p;
      prosContainer.appendChild(li);
    });

    // CONS
    consContainer.innerHTML = '';
    bike.cons.forEach(c => {
      const li = document.createElement('li');
      li.textContent = c;
      consContainer.appendChild(li);
    });

    // ISSUES
    issuesAccordion.innerHTML = '';
    bike.common_issues.forEach((issue, i) => {
      const div = document.createElement('div');
      div.innerHTML = `
        <h4>${i + 1}. ${issue.issue}</h4>
        <p><b>Cause:</b> ${issue.cause}</p>
        <p><b>Fix:</b> ${issue.fix}</p>
      `;
      issuesAccordion.appendChild(div);
    });

    // STICKY
    stickyBikeName.textContent = bike.name;
    stickyAiBtn.href = `chat.html?bike=${bike.id}`;

    loadingDiv.style.display = 'none';
    profileDiv.style.display = 'block';
    stickyBanner.style.display = 'flex';
  }

  fetchBikeDetails();
});