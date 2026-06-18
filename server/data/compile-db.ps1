# compile-db.ps1
# Programmatically builds the massive 100 bikes database for BikeAI
# Run this script to generate server/data/bikes-db.json

$bikes = @(
  # --- HERO BRANDS (15 bikes) ---
  @{
    id = "hero-splendor-plus"; name = "Hero Splendor Plus"; brand = "Hero"; type = "commuter"; price_inr = 75000
    engine_cc = 97.2; mileage_kmpl = 65; power_bhp = 7.91; torque_nm = 8.05; weight_kg = 112
    gear_type = "gear"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $false
    features = @("APDV Engine", "i3S Technology (Idle Start-Stop)", "Tubeless Tires", "Integrated Braking System")
    pros = @("Legendary fuel efficiency", "Low cost of maintenance", "Durable engine that lasts decades")
    cons = @("Basic retro styling", "Drum brakes lack modern bite", "Vibrates above 65 km/h")
    best_for = "Ultra-economical daily city commuting and rural riding"
  },
  @{
    id = "hero-hf-deluxe"; name = "Hero HF Deluxe"; brand = "Hero"; type = "commuter"; price_inr = 65000
    engine_cc = 97.2; mileage_kmpl = 65; power_bhp = 7.91; torque_nm = 8.05; weight_kg = 110
    gear_type = "gear"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $false
    features = @("xSens Fuel Injection", "i3S Technology", "Long Seat", "Tubeless Tires")
    pros = @("Highly affordable price point", "Excellent daily mileage", "Lightweight and easy handling")
    cons = @("Lacks basic digital console", "Very simple styling", "Hard rear suspension")
    best_for = "Budget-focused daily commuting and short utility runs"
  },
  @{
    id = "hero-hf-100"; name = "Hero HF 100"; brand = "Hero"; type = "commuter"; price_inr = 57000
    engine_cc = 97.2; mileage_kmpl = 65; power_bhp = 7.91; torque_nm = 8.05; weight_kg = 109
    gear_type = "gear"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $false
    features = @("Arise kick starter", "xSens technology", "Tubeless tires", "Alloy wheels")
    pros = @("Cheapest 100cc bike in India", "Extremely low running costs", "Light weight frame")
    cons = @("No electric start option", "Basic drum brakes only", "No cosmetic features")
    best_for = "Basic point A to point B travel at the lowest cost"
  },
  @{
    id = "hero-glamour"; name = "Hero Glamour"; brand = "Hero"; type = "commuter"; price_inr = 82000
    engine_cc = 124.7; mileage_kmpl = 55; power_bhp = 10.7; torque_nm = 10.6; weight_kg = 122
    gear_type = "gear"; fuel_type = "petrol"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Real-time mileage indicator", "Digital-analog cluster", "Bluetooth navigation support", "USB charger")
    pros = @("Refined 125cc commuter engine", "Comfortable riding position", "Modern looks with pilot lamps")
    cons = @("Gearbox shifts feel notched", "Slight lag in initial pickup", "Basic brakes")
    best_for = "Feature-rich daily office commutes with high fuel efficiency"
  },
  @{
    id = "hero-super-splendor"; name = "Hero Super Splendor"; brand = "Hero"; type = "commuter"; price_inr = 80000
    engine_cc = 124.7; mileage_kmpl = 55; power_bhp = 10.7; torque_nm = 10.6; weight_kg = 122
    gear_type = "gear"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("5-Speed Gearbox", "Longer seat comfort", "Chrome engine detailing", "Side stand engine cut-off")
    pros = @("Smooth highway stability compared to 100cc", "Low vibrations at 70 km/h", "Sturdy build quality")
    cons = @("Lacks full digital console", "Flimsy plastic side guards", "Plain exhaust sound")
    best_for = "Reliable daily commuter with 5-speed comfort"
  },
  @{
    id = "hero-passion-pro"; name = "Hero Passion Pro"; brand = "Hero"; type = "commuter"; price_inr = 78000
    engine_cc = 113.0; mileage_kmpl = 60; power_bhp = 9.02; torque_nm = 9.79; weight_kg = 117
    gear_type = "gear"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $false
    features = @("Digi-analog console", "Autosail technology", "Signature LED tail lamp", "Stylish tank shrouds")
    pros = @("Attractive styling for a commuter", "Very soft suspension setup", "Consistent mileage figures")
    cons = @("Engine gets noisy at high RPMs", "Fiber parts vibrate", "Basic front drum standard")
    best_for = "Stylish commuter riding with comfort and economy"
  },
  @{
    id = "hero-xpulse-200-4v"; name = "Hero Xpulse 200 4V"; brand = "Hero"; type = "adventure"; price_inr = 145000
    engine_cc = 199.6; mileage_kmpl = 40; power_bhp = 18.9; torque_nm = 17.35; weight_kg = 158
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $true
    features = @("Long-travel front suspension", "Off-road tyres", "Turn-by-turn navigation", "Fully digital display", "Oil cooler")
    pros = @("Best entry level adventure bike in India", "Incredible off-road capability", "High ground clearance (220mm)")
    cons = @("Highway cruising top-speed is limited", "Tall seat height (825mm) for shorter riders", "Small fuel tank capacity")
    best_for = "Weekend trail riding, off-roading, and touring on broken roads"
  },
  @{
    id = "hero-xtreme-160r"; name = "Hero Xtreme 160R"; brand = "Hero"; type = "sports"; price_inr = 122000
    engine_cc = 163.0; mileage_kmpl = 45; power_bhp = 15.0; torque_nm = 14.0; weight_kg = 139
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("All LED lighting", "Inverted LCD cluster", "Single-channel ABS", "Side-stand indicator")
    pros = @("Super light and agile chassis", "Very punchy low-end throttle response", "Modern streetfighter design")
    cons = @("Pillion seat is very small", "Lack of top-end performance", "No Bluetooth console standard")
    best_for = "Spirited city commuting and light weekend rides"
  },
  @{
    id = "hero-xtreme-200s"; name = "Hero Xtreme 200S"; brand = "Hero"; type = "sports"; price_inr = 135000
    engine_cc = 199.6; mileage_kmpl = 40; power_bhp = 17.8; torque_nm = 16.4; weight_kg = 154
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Full fairing design", "Bluetooth mobile connectivity", "LED headlamps", "Monoshock suspension")
    pros = @("Aerodynamic styling", "Upright comfortable riding posture", "Affordable 200cc performance")
    cons = @("Fins on fairing rattle", "Gear position sensor lag", "Front brakes feel soft")
    best_for = "Sporty looking commuting and occasional highway touring"
  },
  @{
    id = "hero-maestro-edge-125"; name = "Hero Maestro Edge 125"; brand = "Hero"; type = "scooter"; price_inr = 85000
    engine_cc = 124.6; mileage_kmpl = 45; power_bhp = 9.0; torque_nm = 10.4; weight_kg = 111
    gear_type = "gearless"; fuel_type = "petrol"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Programmed Fuel Injection", "External fuel filling", "USB port & boot light", "Connected navigation app")
    pros = @("High ground clearance", "Advanced connected tech features", "Very large underseat storage")
    cons = @("Body weight feels slightly imbalanced", "Rear suspension is stiff", "Average headlight throw")
    best_for = "Tech-centric city scooter commuting"
  },
  @{
    id = "hero-destini-125"; name = "Hero Destini 125"; brand = "Hero"; type = "scooter"; price_inr = 80000
    engine_cc = 124.6; mileage_kmpl = 45; power_bhp = 9.0; torque_nm = 10.4; weight_kg = 113
    gear_type = "gearless"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("i3S smart start-stop", "Chrome design highlights", "Digi-analog instrumentation", "Integrated braking")
    pros = @("Solid metal front body panels", "Very comfortable seat padding", "Decent fuel mileage")
    cons = @("Plain retro styling", "No disc brake variant", "Heavy steel wheel rims standard")
    best_for = "Family-oriented daily city commuting and grocery runs"
  },
  @{
    id = "hero-pleasure-plus-110"; name = "Hero Pleasure Plus 110"; brand = "Hero"; type = "scooter"; price_inr = 70000
    engine_cc = 110.9; mileage_kmpl = 50; power_bhp = 8.0; torque_nm = 8.7; weight_kg = 104
    gear_type = "gearless"; fuel_type = "petrol"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Retro styling options", "Integrated mobile charger", "LED boot lamp", "Smart sensor technology")
    pros = @("Extremely lightweight and nimble", "Retro styling appeal", "Easy to park and handle in tight traffic")
    cons = @("Flimsy body panels", "Too small for tall riders", "Weak performance on flyovers")
    best_for = "Office/college travel for lightweight riders and beginners"
  },
  @{
    id = "hero-vida-v1-pro"; name = "Hero Vida V1 Pro"; brand = "Hero"; type = "electric"; price_inr = 146000
    engine_cc = 0.0; mileage_kmpl = 110; power_bhp = 8.0; torque_nm = 25.0; weight_kg = 125
    gear_type = "gearless"; fuel_type = "electric"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Removable dual batteries", "Touchscreen TFT console", "Cruise control & reverse mode", "Keyless ignition")
    pros = @("Highly practical removable batteries", "Fast charging support", "Refined acceleration curves")
    cons = @("Polarizing futuristic styling", "Premium pricing model", "Underseat space split by batteries")
    best_for = "Premium and eco-friendly city commuting with zero range anxiety"
  },
  @{
    id = "hero-xtreme-125r"; name = "Hero Xtreme 125R"; brand = "Hero"; type = "sports"; price_inr = 95000
    engine_cc = 124.7; mileage_kmpl = 66; power_bhp = 11.55; torque_nm = 10.5; weight_kg = 136
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $false
    features = @("Single-channel ABS (optional)", "Full LED package", "Wide radial rear tyre", "Sporty split seat setup")
    pros = @("Stunning premium sporty looks for 125cc", "Incredible fuel economy", "Segment-first ABS feature")
    cons = @("Pillion rider seat is high", "Limited highway top end speed", "Hard seat cushion")
    best_for = "Budget-friendly sporty looker with legendary mileage"
  },
  @{
    id = "hero-karizma-xmr"; name = "Hero Karizma XMR"; brand = "Hero"; type = "sports"; price_inr = 180000
    engine_cc = 210.0; mileage_kmpl = 35; power_bhp = 25.15; torque_nm = 20.4; weight_kg = 163
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $true
    features = @("Liquid-cooled DOHC engine", "Adjustable windscreen", "Bluetooth turn-by-turn navigation", "Dual-channel ABS")
    pros = @("Iconic nameplate resurrected", "Modern aerodynamic styling", "Powerful liquid-cooled engine")
    cons = @("Engine vibes felt in mid-range", "Plastic fit and finish is basic", "High pillion grab rail")
    best_for = "Weekend highway touring and styling daily commutes"
  },

  # --- BAJAJ BRANDS (12 bikes) ---
  @{
    id = "bajaj-pulsar-n160"; name = "Bajaj Pulsar N160"; brand = "Bajaj"; type = "sports"; price_inr = 130000
    engine_cc = 164.82; mileage_kmpl = 45; power_bhp = 16.0; torque_nm = 14.65; weight_kg = 152
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $true
    features = @("Dual-Channel ABS", "USB mobile charging port", "Digital console with bluetooth navigation", "Bi-functional LED projector headlamp")
    pros = @("Segment-first dual channel ABS safety", "Extremely smooth engine refinement", "Aggressive projector headlight look")
    cons = @("Console is small", "Bike weight is high for a 160cc", "Low-end throttle play")
    best_for = "Safe city sports commuting and highway cruising"
  },
  @{
    id = "bajaj-pulsar-ns200"; name = "Bajaj Pulsar NS200"; brand = "Bajaj"; type = "sports"; price_inr = 142000
    engine_cc = 199.5; mileage_kmpl = 36; power_bhp = 24.5; torque_nm = 18.74; weight_kg = 159
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Liquid Cooled Engine", "Triple Spark DTS-i", "Perimeter Frame", "Underbelly Exhaust", "Backlit Switches", "Upside Down Front Forks")
    pros = @("High-revving, punchy performance", "Excellent cornering stability", "Very aggressive streetfighter looks")
    cons = @("Vibrations at high engine RPMs", "No gear position indicator on older variants", "Tall seat height")
    best_for = "Street racing, daily sports commuting, and spirited canyon carving"
  },
  @{
    id = "bajaj-pulsar-rs200"; name = "Bajaj Pulsar RS200"; brand = "Bajaj"; type = "sports"; price_inr = 172000
    engine_cc = 199.5; mileage_kmpl = 35; power_bhp = 24.5; torque_nm = 18.7; weight_kg = 166
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Dual Projector Headlamps", "Full fairing aerodynamics", "Dual-Channel ABS", "Liquid cooling")
    pros = @("High speed cruising wind protection", "Sporty visual presence", "Great handling response")
    cons = @("Dated fairing panel styling", "High body weight", "No bluetooth connectivity options")
    best_for = "High-speed highway touring and entry-level track days"
  },
  @{
    id = "bajaj-pulsar-220f"; name = "Bajaj Pulsar 220F"; brand = "Bajaj"; type = "sports"; price_inr = 138000
    engine_cc = 220.0; mileage_kmpl = 38; power_bhp = 20.4; torque_nm = 18.5; weight_kg = 160
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Semi-fairing design", "Projector headlamp", "Oil cooled engine", "Backlit switchgears")
    pros = @("Cult classic appeal", "Very strong mid-range throttle pull", "Comfortable semi-cruising seats")
    cons = @("Dated instrument panel", "Vibrations in the front fairing", "Old structural chassis frame")
    best_for = "Affordable highway commuting and retro sports performance"
  },
  @{
    id = "bajaj-ct110"; name = "Bajaj CT110"; brand = "Bajaj"; type = "commuter"; price_inr = 68000
    engine_cc = 115.45; mileage_kmpl = 70; power_bhp = 8.6; torque_nm = 9.81; weight_kg = 118
    gear_type = "gear"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $false
    features = @("Semi-knobby tyres", "Heavy duty crash guard", "SNS rear suspension", "Rubber tank pads")
    pros = @("Extremely rugged construction", "High fuel economy", "Handles rough rural roads easily")
    cons = @("Basic styling details", "Fewer performance figures", "Analogue indicators only")
    best_for = "Rural cargo carrying and low cost daily travel"
  },
  @{
    id = "bajaj-ct125x"; name = "Bajaj CT125X"; brand = "Bajaj"; type = "commuter"; price_inr = 74000
    engine_cc = 124.4; mileage_kmpl = 60; power_bhp = 10.9; torque_nm = 11.0; weight_kg = 130
    gear_type = "gear"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("USB phone charging port", "Headlight protective grille", "V-shaped LED DRL", "Heavy-duty carrier")
    pros = @("Sturdy design aesthetics", "Decent load carrying power", "Very comfortable dual seat")
    cons = @("Slightly heavy steering feel", "No disc brake at rear", "Basic plastic switches")
    best_for = "Utility-based daily commuting with rough road usage"
  },
  @{
    id = "bajaj-platina-110"; name = "Bajaj Platina 110"; brand = "Bajaj"; type = "commuter"; price_inr = 70000
    engine_cc = 115.45; mileage_kmpl = 75; power_bhp = 8.6; torque_nm = 9.81; weight_kg = 119
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $false
    features = @("First-in-segment ABS", "Comfortec suspension system", "LED DRL light", "Wide footrests")
    pros = @("Outstanding mileage (75 kmpl)", "Unmatched suspension comfort on potholes", "ABS adds high safety margin")
    cons = @("No digital gauges", "Very light weight on highway gusts", "Simple retro look")
    best_for = "Max comfort and mileage focused daily commuting"
  },
  @{
    id = "bajaj-avenger-street-160"; name = "Bajaj Avenger Street 160"; brand = "Bajaj"; type = "cruiser"; price_inr = 116000
    engine_cc = 160.0; mileage_kmpl = 45; power_bhp = 15.0; torque_nm = 13.7; weight_kg = 156
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Low seat cruiser height (737mm)", "Street styling accents", "Single-channel ABS", "Wide rear tyre")
    pros = @("Highly accessible for short riders", "Smooth cruiser comfort in city", "Affordable cruiser option")
    cons = @("Low ground clearance (169mm)", "Rear drum brake lacks power", "Not suitable for heavy pillions")
    best_for = "Relaxed daily city commuting and highway cruising for short riders"
  },
  @{
    id = "bajaj-avenger-cruise-220"; name = "Bajaj Avenger Cruise 220"; brand = "Bajaj"; type = "cruiser"; price_inr = 143000
    engine_cc = 220.0; mileage_kmpl = 40; power_bhp = 19.0; torque_nm = 17.55; weight_kg = 163
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Classic chrome styling", "Tall touring windscreen", "Cruiser backrest standard", "Digital console display")
    pros = @("Premium retro cruiser looks", "High highway stability", "Comfortable backrest support")
    cons = @("Hard to handle in bumper-to-bumper traffic", "Heats up in heavy traffic", "No tubeless tires standard")
    best_for = "Comfortable relaxed long-distance highway cruising"
  },
  @{
    id = "bajaj-dominar-400"; name = "Bajaj Dominar 400"; brand = "Bajaj"; type = "cruiser"; price_inr = 230000
    engine_cc = 373.3; mileage_kmpl = 29; power_bhp = 40.0; torque_nm = 35.0; weight_kg = 193
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $true
    city_friendly = $false; highway_capable = $true
    features = @("Liquid-cooled DOHC engine", "Slipper clutch", "Inverted front forks", "Integrated touring accessories", "Twin-barrel exhaust")
    pros = @("Powerhouse highway performance", "Factory fitted touring visor, handguards, and racks", "Comfortable riding layout")
    cons = @("Heavy weight makes narrow parking difficult", "Poor city mileage figures", "Engine vibrations around 6000 RPM")
    best_for = "Long-distance budget sports touring and highway cruising"
  },
  @{
    id = "bajaj-dominar-250"; name = "Bajaj Dominar 250"; brand = "Bajaj"; type = "cruiser"; price_inr = 185000
    engine_cc = 248.77; mileage_kmpl = 32; power_bhp = 27.0; torque_nm = 23.5; weight_kg = 180
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Liquid cooled 4V engine", "Dual channel ABS", "USD front forks", "LED headlight cowl")
    pros = @("Excellent build heft and stability", "Much smoother engine than Dominar 400", "Affordable premium cruising look")
    cons = @("Heavy body for a 250cc engine", "Slower off-the-line pickup", "Soft rear suspension")
    best_for = "Easy highway cruises and daily urban travel"
  },
  @{
    id = "bajaj-chetak-electric"; name = "Bajaj Chetak Electric"; brand = "Bajaj"; type = "electric"; price_inr = 115000
    engine_cc = 0.0; mileage_kmpl = 90; power_bhp = 5.3; torque_nm = 20.0; weight_kg = 133
    gear_type = "gearless"; fuel_type = "electric"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("All metal body panels", "IP67 water resistant battery", "Regenerative braking system", "Digital console display")
    pros = @("Excellent retro metal build quality", "Plush premium seating comfort", "Reliable battery thermal management")
    cons = @("Slightly slow top speed (63 km/h)", "Long charging time (approx 5 hours)", "Limited underseat storage")
    best_for = "Elegant, nostalgic, and eco-friendly city scooter commuting"
  },

  # --- HONDA BRANDS (10 bikes) ---
  @{
    id = "honda-activa-6g"; name = "Honda Activa 6G"; brand = "Honda"; type = "scooter"; price_inr = 78000
    engine_cc = 109.51; mileage_kmpl = 50; power_bhp = 7.73; torque_nm = 8.90; weight_kg = 106
    gear_type = "gearless"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $false
    features = @("PGM-Fi Engine", "ESP silent start technology", "Telescopic front suspension", "External fuel filling")
    pros = @("Bulletproof reliability and engine refinement", "High market resale value", "Easy city handling and comfort")
    cons = @("Flimsy plastic indicators", "No digital display standard", "Lack of front disc brake option")
    best_for = "Daily family utility rides and city commuting"
  },
  @{
    id = "honda-activa-125"; name = "Honda Activa 125"; brand = "Honda"; type = "scooter"; price_inr = 82000
    engine_cc = 124.0; mileage_kmpl = 47; power_bhp = 8.18; torque_nm = 10.3; weight_kg = 110
    gear_type = "gearless"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $false
    features = @("LED headlamp cluster", "Digi-analog console", "Front disc brake (optional)", "Silent starter ACG")
    pros = @("Strong mid-range torque", "Premium chrome styling overlays", "Very quiet startup sequence")
    cons = @("Fuel efficiency drops under load", "Slightly heavy front fork feel", "Basic rear brake performance")
    best_for = "Comfortable daily city commutes with occasional pillion riders"
  },
  @{
    id = "honda-shine-100"; name = "Honda Shine 100"; brand = "Honda"; type = "commuter"; price_inr = 65000
    engine_cc = 98.98; mileage_kmpl = 65; power_bhp = 7.28; torque_nm = 8.05; weight_kg = 99
    gear_type = "gear"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $false
    features = @("Fuel injection PGM-Fi", "Alloy wheels", "Combi-Brake System (CBS)", "Long seating cushion")
    pros = @("Very affordable pricing standard", "Featherlight weight of 99 kg", "Outstanding fuel mileage")
    cons = @("Plain visual design", "Extremely thin tyres", "Vibrates at speeds above 60 km/h")
    best_for = "Ultra-cheap city travels and budget conscious delivery riders"
  },
  @{
    id = "honda-shine-sp"; name = "Honda Shine SP"; brand = "Honda"; type = "commuter"; price_inr = 86000
    engine_cc = 123.94; mileage_kmpl = 55; power_bhp = 10.7; torque_nm = 10.9; weight_kg = 116
    gear_type = "gear"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $false
    features = @("5-speed transmission", "Full digital console meter", "Silent ACG starter", "Sealed drive chain")
    pros = @("Smooth 5th gear highway refinement", "Modern looking tank decals", "Very light clutch operation")
    cons = @("Rear suspension is soft", "Poor headlight illumination", "No Bluetooth diagnostics")
    best_for = "Comfortable daily office commutes with high fuel efficiency"
    city_friendly = $true; highway_capable = $false
  },
  @{
    id = "honda-unicorn"; name = "Honda Unicorn"; brand = "Honda"; type = "commuter"; price_inr = 110000
    engine_cc = 162.7; mileage_kmpl = 50; power_bhp = 12.7; torque_nm = 14.0; weight_kg = 140
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Mono-shock rear suspension", "Single-channel ABS", "Refined HET engine", "Classic chrome 3D emblem")
    pros = @("Exceptional ride plushness", "Legendary engine life and refinement", "Comfortable upright riding layout")
    cons = @("Traditional styling is very dated", "Lacks digital console", "Spongey front brake lever")
    best_for = "Super comfortable daily office commutes and mature riders"
  },
  @{
    id = "honda-hornet-2-0"; name = "Honda Hornet 2.0"; brand = "Honda"; type = "sports"; price_inr = 139000
    engine_cc = 184.4; mileage_kmpl = 40; power_bhp = 17.0; torque_nm = 16.1; weight_kg = 142
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Golden USD front forks", "Petal disc brakes", "Fully digital display with brightness adjust", "Hazard light switch")
    pros = @("Agile chassis handling performance", "Premium gold colored USD forks", "Flickable in city traffic jams")
    cons = @("No dual-channel ABS variant", "Pillion seating comfort is poor", "Stiff ride quality over bumps")
    best_for = "Sporty city streetfighting and weekend corner carving"
  },
  @{
    id = "honda-cb300r"; name = "Honda CB300R"; brand = "Honda"; type = "sports"; price_inr = 240000
    engine_cc = 286.0; mileage_kmpl = 30; power_bhp = 31.1; torque_nm = 27.5; weight_kg = 146
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("IMU-based Dual-Channel ABS", "Neo-Sports Cafe styling", "Assist & Slipper Clutch", "LED lighting suite")
    pros = @("Incredibly lightweight (146 kg) handling", "Refined high rev performance", "Stunning Neo-Retro cafe design")
    cons = @("Very small fuel tank (9.7 Liters)", "Tiny pillion seat space", "Soft front suspension setup")
    best_for = "Neo-retro city cruising and fast weekend runs"
  },
  @{
    id = "honda-cb350-hness"; name = "Honda H'ness CB350"; brand = "Honda"; type = "cruiser"; price_inr = 210000
    engine_cc = 348.36; mileage_kmpl = 35; power_bhp = 20.8; torque_nm = 30.0; weight_kg = 181
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $true
    features = @("Selectable Torque Control (HSTC)", "Bluetooth Voice Control", "Assist & Slipper clutch", "Dual-Channel ABS")
    pros = @("Silky smooth exhaust thump", "Vibration-free J-series rival engine", "Premium retro styling cues")
    cons = @("Tall gear ratios require constant downshifting", "Limited sales network (BigWing dealerships only)", "Rear brake pedal play")
    best_for = "Refined highway retro cruising and comfortable city riding"
  },
  @{
    id = "honda-cb350rs"; name = "Honda CB350RS"; brand = "Honda"; type = "cruiser"; price_inr = 215000
    engine_cc = 348.36; mileage_kmpl = 35; power_bhp = 20.8; torque_nm = 30.0; weight_kg = 179
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Scrambler design aesthetic", "Tuck-and-roll seat cover", "Skid plate protection", "HSTC Traction control")
    pros = @("Sporty retro scrambler design", "Great block pattern tire grip", "Vibration-free engine refinement")
    cons = @("No USB charging port standard", "Rear mud splash is high", "Firm seating padding")
    best_for = "Stylish scrambler cruising and highway touring"
  },
  @{
    id = "honda-dio-125"; name = "Honda Dio 125"; brand = "Honda"; type = "scooter"; price_inr = 84000
    engine_cc = 123.97; mileage_kmpl = 48; power_bhp = 8.18; torque_nm = 10.4; weight_kg = 104
    gear_type = "gearless"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Smart Key technology", "Bold graphical styling", "Sporty split grab rail", "Dual outlet muffler")
    pros = @("Aggressive, youth-focused styling", "Convenient keyless smart fob", "Flickable handling")
    cons = @("Bumpy rear shock setup", "Full plastic body prone to squeaks", "High speed stability is average")
    best_for = "Youthful and sporty city scooter riding"
  },

  # --- TVS BRANDS (10 bikes) ---
  @{
    id = "tvs-apache-rtr-160-4v"; name = "TVS Apache RTR 160 4V"; brand = "TVS"; type = "sports"; price_inr = 124000
    engine_cc = 159.7; mileage_kmpl = 45; power_bhp = 17.55; torque_nm = 14.73; weight_kg = 145
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("SmartXonnect Bluetooth console", "Multiple Riding Modes", "GTT Glide Through Technology", "Aggressive LED headlamps")
    pros = @("Highest power output in 160cc segment", "Smooth engine feel", "Advanced bluetooth features")
    cons = @("Notched gear shift feel", "Rear brakes feel slightly spongey", "Complex dashboard pairing")
    best_for = "Feature-rich city commuting and weekend canyon carving"
  },
  @{
    id = "tvs-apache-rtr-200-4v"; name = "TVS Apache RTR 200 4V"; brand = "TVS"; type = "sports"; price_inr = 147000
    engine_cc = 197.75; mileage_kmpl = 38; power_bhp = 20.5; torque_nm = 17.25; weight_kg = 152
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Adjustable front suspension forks", "Dual-Channel ABS with modes", "Slipper clutch", "SmartXonnect telemetry")
    pros = @("First-in-segment adjustable forks", "Excellent track-focused handling", "Crisp low-end acceleration torque")
    cons = @("Vibrations at high RPM limits", "Lacks a 6th gear for highway cruising", "Narrow rear seat profile")
    best_for = "Track day beginners, street races, and city sports commutes"
  },
  @{
    id = "tvs-apache-rr-310"; name = "TVS Apache RR 310"; brand = "TVS"; type = "sports"; price_inr = 272000
    engine_cc = 312.2; mileage_kmpl = 30; power_bhp = 34.0; torque_nm = 27.3; weight_kg = 174
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $false
    city_friendly = $false; highway_capable = $true
    features = @("Vertical TFT display", "Bi-LED Twin Projectors", "Throttle-by-wire", "Michelin Road 5 Tyres")
    pros = @("Premium track styling design", "Advanced digital dashboard and modes", "Top-tier Michelin tire grip")
    cons = @("Heavy engine heat in bumper city traffic", "Significant engine vibrations at high RPM", "High service costs")
    best_for = "Weekend track riding and high-speed highway touring"
  },
  @{
    id = "tvs-raider-125"; name = "TVS Raider 125"; brand = "TVS"; type = "commuter"; price_inr = 95000
    engine_cc = 124.8; mileage_kmpl = 57; power_bhp = 11.2; torque_nm = 11.2; weight_kg = 123
    gear_type = "gear"; fuel_type = "petrol"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("TFT Color Display with Bluetooth", "Eco & Power Riding Modes", "Underseat storage cubby", "USB charging slot")
    pros = @("Aggressive look for a 125cc commuter", "Color TFT screen with voice assists", "Great fuel efficiency stats")
    cons = @("Slightly soft rear monoshock", "No ABS variant option", "Thin front tyres")
    best_for = "Stylishly tech-loaded daily office commutes"
  },
  @{
    id = "tvs-ronin"; name = "TVS Ronin"; brand = "TVS"; type = "cruiser"; price_inr = 149000
    engine_cc = 225.9; mileage_kmpl = 40; power_bhp = 20.1; torque_nm = 19.93; weight_kg = 160
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $true
    features = @("Golden USD forks", "Assymmetrical speedometer console", "Dual-Channel ABS with Rain/Urban modes", "Slipper clutch")
    pros = @("Comfortable scrambler-cruiser riding layout", "Superb low-end torque pull", "Unique retro-modern styling")
    cons = @("Polarizing square rear tail styling", "Slightly low highway top speed", "Vibrations at 90 km/h+")
    best_for = "Relaxed scrambler cruising and daily city riding"
  },
  @{
    id = "tvs-star-city-plus"; name = "TVS Star City Plus"; brand = "TVS"; type = "commuter"; price_inr = 78000
    engine_cc = 109.7; mileage_kmpl = 68; power_bhp = 8.08; torque_nm = 8.7; weight_kg = 116
    gear_type = "gear"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $false
    features = @("ET-Fi Technology", "LED headlamp setup", "Adjustable rear shocks", "Service reminder indicator")
    pros = @("Buttery smooth engine refined travel", "Superb real-world mileage", "Soft and wide seating pad")
    cons = @("Drum brakes feel soft", "Simple styling accents", "Lacks digital display panels")
    best_for = "Super-economical daily city commutes and comfort focus travel"
  },
  @{
    id = "tvs-radeon"; name = "TVS Radeon"; brand = "TVS"; type = "commuter"; price_inr = 74000
    engine_cc = 109.7; mileage_kmpl = 65; power_bhp = 8.08; torque_nm = 8.7; weight_kg = 116
    gear_type = "gear"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Chrome tank bezels", "USB charger port", "Side-stand indicator with beeper", "Heavy duty pillion grab rack")
    pros = @("Retro robust styling look", "Loud, bassy exhaust note for a 110cc", "Sturdy metal build frame")
    cons = @("High speed vibrations", "Narrow steering handle width", "Soft rear suspension feels bouncy")
    best_for = "Rugged utility commutes and rural riding needs"
  },
  @{
    id = "tvs-jupiter-125"; name = "TVS Jupiter 125"; brand = "TVS"; type = "scooter"; price_inr = 86000
    engine_cc = 124.8; mileage_kmpl = 50; power_bhp = 8.04; torque_nm = 10.5; weight_kg = 108
    gear_type = "gearless"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Huge 33L underseat storage", "Front fuel filling cap", "Semi-digital cluster meter", "IntelliGO start-stop")
    pros = @("Market-best underseat utility space", "Class-leading fuel fill convenience", "Wide spacious floorboard design")
    cons = @("Styling looks a bit generic", "Slight acceleration vibes", "Rear shock bounces when single riding")
    best_for = "Highly practical family commuting and grocery running"
  },
  @{
    id = "tvs-ntorq-125"; name = "TVS NTORQ 125"; brand = "TVS"; type = "scooter"; price_inr = 90000
    engine_cc = 124.8; mileage_kmpl = 42; power_bhp = 9.25; torque_nm = 10.5; weight_kg = 118
    gear_type = "gearless"; fuel_type = "petrol"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Stealth fighter cockpit design", "SmartXonnect Bluetooth telemetry", "Engine lap timer", "Sporty split grab rail")
    pros = @("Most exciting 125cc scooter pickup", "Bassy exhaust sound note", "Loaded with navigation assists")
    cons = @("Low fuel mileage compared to rivals", "Heavy weight of 118 kg", "Stiff sporty suspension ride")
    best_for = "Youthful street carving and fast city scooter commutes"
  },
  @{
    id = "tvs-iqube-electric"; name = "TVS iQube Electric"; brand = "TVS"; type = "electric"; price_inr = 125000
    engine_cc = 0.0; mileage_kmpl = 100; power_bhp = 5.9; torque_nm = 33.0; weight_kg = 117
    gear_type = "gearless"; fuel_type = "electric"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Smart LED headlights", "TFT cluster with navigation", "Q-park park assist system", "Regenerative braking")
    pros = @("Very conventional family-scooter ride feeling", "Silent and refined hub motor setup", "Comfortable dual-rider seating")
    cons = @("Slow home charging cycles", "Futuristic design is basic", "Console software resets occasionally")
    best_for = "Frugal and quiet daily family city commutes"
  },

  # --- ROYAL ENFIELD (10 bikes) ---
  @{
    id = "re-classic-350"; name = "Royal Enfield Classic 350"; brand = "Royal Enfield"; type = "cruiser"; price_inr = 193000
    engine_cc = 349.0; mileage_kmpl = 35; power_bhp = 20.2; torque_nm = 27.0; weight_kg = 195
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $true
    features = @("J-Series Engine refinement", "Dual-Channel ABS safety", "Tripper navigation display (optional)", "Analog-Digital dashboard")
    pros = @("Retro styling thump and presence", "Highway stability and seating comfort", "Much reduced vibes compared to UCE engine")
    cons = @("Heavy weight frame makes narrow parking hard", "Clutch lever pull is firm", "Headlamp standard bulb is weak")
    best_for = "Highway touring, relaxed long distance rides, and weekend cruising"
  },
  @{
    id = "re-bullet-350"; name = "Royal Enfield Bullet 350"; brand = "Royal Enfield"; type = "cruiser"; price_inr = 173000
    engine_cc = 349.0; mileage_kmpl = 35; power_bhp = 20.2; torque_nm = 27.0; weight_kg = 191
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Iconic hand-painted pinstripes", "J-Series Engine", "Single/Dual channel ABS", "Thick single-piece seat")
    pros = @("Oldest iconic legacy styling in production", "Buttery smooth J-series engine refinement", "Very comfortable seat padding")
    cons = @("Lacks basic digital console panels", "No alloy wheel variants standard", "Higher price than legacy Bullet")
    best_for = "Pure vintage cruising and classic retro commutes"
  },
  @{
    id = "re-meteor-350"; name = "Royal Enfield Meteor 350"; brand = "Royal Enfield"; type = "cruiser"; price_inr = 205000
    engine_cc = 349.0; mileage_kmpl = 38; power_bhp = 20.2; torque_nm = 27.0; weight_kg = 191
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $true
    features = @("Low stance cruiser frame", "Tripper navigation unit standard", "USB charging outlet", "Dual-Channel ABS")
    pros = @("Relaxed, feet-forward touring posture", "Minimal highway vibrations", "Easy highway tracking stability")
    cons = @("Rear shock absorption feels stiff", "Priced higher than classic siblings", "Low rev range restricts fast overtaking shifts")
    best_for = "Relaxed long-distance highway cruising and daily touring travels"
  },
  @{
    id = "re-himalayan-411"; name = "Royal Enfield Himalayan 411"; brand = "Royal Enfield"; type = "adventure"; price_inr = 215000
    engine_cc = 411.0; mileage_kmpl = 30; power_bhp = 24.3; torque_nm = 32.0; weight_kg = 199
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $true
    city_friendly = $false; highway_capable = $true
    features = @("Long travel off-road shocks", "Luggage racks standard", "Switchable ABS", "Compass display gauge")
    pros = @("Incredible trail crawler torque", "Plush long-travel suspension", "Rugged and durable build layout")
    cons = @("Fails to cruise past 110 km/h smoothly", "High curb weight of 199 kg", "Front braking power feels lazy")
    best_for = "Budget adventure touring and rough terrain crawling"
  },
  @{
    id = "re-himalayan-450"; name = "Royal Enfield Himalayan 450"; brand = "Royal Enfield"; type = "adventure"; price_inr = 285000
    engine_cc = 452.0; mileage_kmpl = 28; power_bhp = 39.5; torque_nm = 40.0; weight_kg = 196
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $true
    city_friendly = $false; highway_capable = $true
    features = @("Sherpa liquid-cooled engine", "Ride-by-wire with modes", "TFT display with full Google Maps integration", "USD front forks")
    pros = @("Powerful high-speed highway cruising (130 km/h+)", "World-class full TFT navigation screen", "Excellent off-road agility")
    cons = @("Engine buzz felt at high RPMs", "Tall seat height (835mm)", "Tubeless spoke wheels are premium additions")
    best_for = "High-speed highway touring and aggressive off-road adventure trails"
  },
  @{
    id = "re-hunter-350"; name = "Royal Enfield Hunter 350"; brand = "Royal Enfield"; type = "cruiser"; price_inr = 150000
    engine_cc = 349.0; mileage_kmpl = 36; power_bhp = 20.2; torque_nm = 27.0; weight_kg = 181
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $true
    city_friendly = $true; highway_capable = $true
    features = @("Lightweight street frame layout", "17-inch alloy wheels", "Retro-metro instrument dial", "USB power outlet")
    pros = @("Most flickable Royal Enfield in city", "Affordable entry pricing point", "Punchy initial throttle pickup")
    cons = @("Stiff rear shock setup", "Small footprint lacks heavy retro size presence", "Slight highway top end vibrations")
    best_for = "City commuting and weekend street riding for youthful buyers"
  },
  @{
    id = "re-scram-411"; name = "Royal Enfield Scram 411"; brand = "Royal Enfield"; type = "adventure"; price_inr = 206000
    engine_cc = 411.0; mileage_kmpl = 30; power_bhp = 24.3; torque_nm = 32.0; weight_kg = 185
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("19-inch front tire wheel", "Urban scrambler seat styling", "Single-pod console cluster", "Offset front mudguard")
    pros = @("More manageable in city than Himalayan 411", "Torque-rich tractability in traffic", "Funky dual-tone color options")
    cons = @("Heavy steering handle weight", "Lacks off-road windscreen protection", "No gear position display standard")
    best_for = "Urban scrambler touring and exploring gravel roads"
  },
  @{
    id = "re-thunderbird-350x"; name = "Royal Enfield Thunderbird 350X"; brand = "Royal Enfield"; type = "cruiser"; price_inr = 163000
    engine_cc = 346.0; mileage_kmpl = 35; power_bhp = 19.8; torque_nm = 28.0; weight_kg = 195
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Alloy wheels with tubeless tires", "Bright colored fuel tanks", "Gunslinger saddle seats", "Blacked-out engine theme")
    pros = @("Modernized custom cruiser styling", "Extremely comfortable touring handlebar", "Large 20 Liter fuel tank")
    cons = @("UCE engine vibrations are heavy", "Old push-rod engine layouts", "Weak headlight beam output")
    best_for = "Daily retro touring commutes and custom styling cruiser fans"
  },
  @{
    id = "re-super-meteor-650"; name = "Royal Enfield Super Meteor 650"; brand = "Royal Enfield"; type = "cruiser"; price_inr = 360000
    engine_cc = 648.0; mileage_kmpl = 25; power_bhp = 47.0; torque_nm = 52.3; weight_kg = 241
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $true
    city_friendly = $false; highway_capable = $true
    features = @("Showable USD front forks", "Premium cruiser chassis frame", "All LED headlamp cowl", "Standard tripper navigation")
    pros = @("True low-slung international cruiser aesthetics", "Buttery smooth parallel twin engine", "Top-tier highway stability")
    cons = @("Ground clearance (135mm) scrapes big speedbumps", "Extremely heavy (241 kg) weight", "Stiff rear suspension throws shocks on back")
    best_for = "Premium long distance highway cruising and highway touring"
  },
  @{
    id = "re-continental-gt-650"; name = "Royal Enfield Continental GT 650"; brand = "Royal Enfield"; type = "sports"; price_inr = 319000
    engine_cc = 648.0; mileage_kmpl = 25; power_bhp = 47.0; torque_nm = 52.0; weight_kg = 211
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $false; highway_capable = $true
    features = @("Cafe racer clip-on bars", "Twin exhaust canisters", "Double cradle frame structure", "Slipper clutch system")
    pros = @("Incredible twin-cylinder acceleration", "Stunning retro cafe racer styling", "Highly engaging cornering posture")
    cons = @("Aggressive clip-ons cause wrist pain in traffic", "Seating cushion is thin", "Lacks modern dashboard metrics")
    best_for = "Thrilling weekend café runs and fast highway rides"
  },

  # --- KTM BRANDS (6 bikes) ---
  @{
    id = "ktm-duke-125"; name = "KTM Duke 125"; brand = "KTM"; type = "sports"; price_inr = 178000
    engine_cc = 124.7; mileage_kmpl = 45; power_bhp = 14.5; torque_nm = 12.0; weight_kg = 159
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $false
    features = @("WP front USD forks", "Bosch single-channel ABS", "Premium trellis frame", "Underbelly exhaust layout")
    pros = @("Premium chassis equipment for 125cc", "Excellent cornering stability", "Aggressive sporty aesthetics")
    cons = @("Very expensive for a 125cc bike", "Underpowered compared to chassis capabilities", "Heavy curb weight")
    best_for = "Premium entry-level sports riding and styling commutes"
  },
  @{
    id = "ktm-duke-200"; name = "KTM Duke 200"; brand = "KTM"; type = "sports"; price_inr = 196000
    engine_cc = 199.5; mileage_kmpl = 35; power_bhp = 25.0; torque_nm = 19.3; weight_kg = 159
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Liquid cooled DOHC engine", "WP USD front suspension", "Dual-Channel ABS safety", "Aggressive tank extensions")
    pros = @("Incredible initial pickup sprint", "Sharp flickable cornering handling", "Good track stability")
    cons = @("Engine heat felt in heavy traffic", "Very stiff seat cushions", "Fails to cruise quietly at low speeds")
    best_for = "Fast city commutes and entry level track days"
  },
  @{
    id = "ktm-duke-250"; name = "KTM Duke 250"; brand = "KTM"; type = "sports"; price_inr = 239000
    engine_cc = 248.76; mileage_kmpl = 30; power_bhp = 30.0; torque_nm = 25.0; weight_kg = 163
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("LCD console with smartphone connection", "Slipper clutch", "WP Apex rear monoshock", "LED split headlamp")
    pros = @("Best balanced performance/handling KTM", "Smooth engine throttle delivery", "Premium styling styling")
    cons = @("Higher price tag near 390 series", "Dated basic console look", "Pillion comfort is basic")
    best_for = "Balanced city sport riding and medium tours"
  },
  @{
    id = "ktm-duke-390"; name = "KTM Duke 390"; brand = "KTM"; type = "sports"; price_inr = 311000
    engine_cc = 373.2; mileage_kmpl = 28; power_bhp = 43.5; torque_nm = 37.0; weight_kg = 171
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Ride-by-wire throttle control", "Slipper clutch & Quickshifter+", "Color TFT screen with music/nav controls", "WP adjustable suspension")
    pros = @("Incredible power-to-weight ratio", "Advanced cornering ABS and electronics package", "Stunning aggressive streetfighter styling")
    cons = @("Heats up aggressively in traffic crawls", "Firm stiff ride over bumps", "High oil consumption rates")
    best_for = "Adrenaline-fueled sports riding, track days, and fast highway touring"
  },
  @{
    id = "ktm-rc-390"; name = "KTM RC 390"; brand = "KTM"; type = "sports"; price_inr = 318000
    engine_cc = 373.2; mileage_kmpl = 28; power_bhp = 43.5; torque_nm = 37.0; weight_kg = 172
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $false
    city_friendly = $false; highway_capable = $true
    features = @("Aggressive racing fairings", "Traction control system", "Cornering ABS with Supermoto mode", "Adjustable clip-on bars")
    pros = @("Track-weapon handling stability", "High-revving powerful acceleration", "Excellent racing aerodynamics")
    cons = @("Extremely aggressive wrist-heavy posture", "Hard to navigate in city traffic blockages", "Vibrates significantly past 7000 RPM")
    best_for = "Track riding, racing enthusiasts, and weekend highway corners"
  },
  @{
    id = "ktm-adventure-390"; name = "KTM Adventure 390"; brand = "KTM"; type = "adventure"; price_inr = 338000
    engine_cc = 373.2; mileage_kmpl = 28; power_bhp = 43.5; torque_nm = 37.0; weight_kg = 177
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $true
    city_friendly = $false; highway_capable = $true
    features = @("Adjustable WP suspension layout", "Quickshifter+ standard", "Traction control & Off-road ABS", "12V charger port")
    pros = @("Superb adventure cruising layout", "Highly advanced electronics suite", "Excellent long travel stability")
    cons = @("Lacks punchy low-end crawling torque", "Very tall seat height (855mm)", "Alloy wheels are prone to off-road damages")
    best_for = "Fast long-distance highway adventure touring and dirt paths"
  },

  # --- YAMAHA BRANDS (8 bikes) ---
  @{
    id = "yamaha-fzs-fi-v3"; name = "Yamaha FZ-S FI V3"; brand = "Yamaha"; type = "commuter"; price_inr = 116000
    engine_cc = 149.0; mileage_kmpl = 48; power_bhp = 12.4; torque_nm = 13.6; weight_kg = 137
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Blue Core fuel injection", "Single-Channel ABS", "LED headlamp setup", "LCD instrument display", "Wide radial rear tyre")
    pros = @("Very comfortable city seating", "Frugal fuel economy statistics", "Lightweight flickable chassis layout")
    cons = @("Lacks high-rev highway top end power", "Headlamp beam is weak", "Rear passenger seat area is small")
    best_for = "Reliable, economical, and comfortable daily city commuting"
  },
  @{
    id = "yamaha-fz-x"; name = "Yamaha FZ-X"; brand = "Yamaha"; type = "commuter"; price_inr = 136000
    engine_cc = 149.0; mileage_kmpl = 45; power_bhp = 12.4; torque_nm = 13.3; weight_kg = 139
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $true
    features = @("Neo-Retro design styling", "Traction Control System (TCS)", "Under cowl guard", "Metal tank cover")
    pros = @("Comfortable block seating pattern", "Unique neo-retro looks", "High safety margin with TCS")
    cons = @("Polarizing headlight front shape", "Engine feels underpowered on highway", "Rear wheel brake play")
    best_for = "Stylish commuter traveling and city cruising"
  },
  @{
    id = "yamaha-mt-15-v2"; name = "Yamaha MT-15 V2"; brand = "Yamaha"; type = "sports"; price_inr = 168000
    engine_cc = 155.0; mileage_kmpl = 45; power_bhp = 18.4; torque_nm = 14.1; weight_kg = 141
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("VVA Variable Valve Actuation", "USD gold colored front shocks", "Traction Control", "Smart Connect Bluetooth console")
    pros = @("Explosive mid-to-high end speed push", "Stunning aggressive robot headlight design", "Incredible mileage for a sports bike")
    cons = @("Very narrow seat space for pillion", "Only single-channel ABS at this price", "Stiff rear monoshock setup")
    best_for = "Fast city sports commuting and youthful weekend riding"
  },
  @{
    id = "yamaha-r15-v4"; name = "Yamaha R15 V4"; brand = "Yamaha"; type = "sports"; price_inr = 182000
    engine_cc = 155.0; mileage_kmpl = 45; power_bhp = 18.4; torque_nm = 14.2; weight_kg = 142
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Aerodynamic track fairing", "VVA Technology", "Quickshifter (select colors)", "Dual-Channel ABS safety")
    pros = @("Excellent racing stance aerodynamics", "Top tier fuel efficiency (45 kmpl)", "Razor-sharp cornering control")
    cons = @("Aggressive posture strains wrists and back", "Gear shifts feel slightly notched when cold", "Very expensive 150cc class model")
    best_for = "Entry level track racing and sporty weekend highway rides"
  },
  @{
    id = "yamaha-fascino-125"; name = "Yamaha Fascino 125"; brand = "Yamaha"; type = "scooter"; price_inr = 79000
    engine_cc = 125.0; mileage_kmpl = 50; power_bhp = 8.2; torque_nm = 10.3; weight_kg = 99
    gear_type = "gearless"; fuel_type = "petrol"; abs = $false; bluetooth = $true; usb_charging = $false
    city_friendly = $true; highway_capable = $false
    features = @("Smart motor generator hybrid", "Retro european styling", "Start-stop system", "Large 21L underseat storage")
    pros = @("Beautiful retro design lines", "Extremely lightweight (99 kg)", "Excellent fuel economy with hybrid assist")
    cons = @("No front glove box storage", "Plastic panel squeaks", "Weak headlight beam")
    best_for = "Stylish city scooter commutes and lightweight handling lovers"
  },
  @{
    id = "yamaha-ray-zr-125"; name = "Yamaha Ray-ZR 125"; brand = "Yamaha"; type = "scooter"; price_inr = 84000
    engine_cc = 125.0; mileage_kmpl = 50; power_bhp = 8.2; torque_nm = 10.3; weight_kg = 99
    gear_type = "gearless"; fuel_type = "petrol"; abs = $false; bluetooth = $true; usb_charging = $false
    city_friendly = $true; highway_capable = $false
    features = @("Sporty razor panel design", "Hybrid power assist motor", "Tough block pattern tires", "LED position lamp")
    pros = @("Edgy aggressive style theme", "Excellent pickup sprint", "Extremely fuel-efficient hybrid engine")
    cons = @("Firm rear suspension bump feeling", "Lacks basic glove box panel", "No disc brake standard option")
    best_for = "Youth-focused daily city scooter commuting"
  },
  @{
    id = "yamaha-aerox-155"; name = "Yamaha Aerox 155"; brand = "Yamaha"; type = "scooter"; price_inr = 148000
    engine_cc = 155.0; mileage_kmpl = 40; power_bhp = 15.0; torque_nm = 13.9; weight_kg = 126
    gear_type = "gearless"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $true
    features = @("R15-derived 155cc liquid-cooled engine", "VVA Technology", "Large 14-inch wheels", "Single-Channel ABS")
    pros = @("Fastest performance scooter in India", "Incredible stability on highway bends", "Smart keyless operation")
    cons = @("Central fuel tank spine eliminates floorboard space", "Stiff dual rear shocks", "Difficult for senior citizens to mount")
    best_for = "Performance scooter enthusiasts and high-speed city carving"
  },
  @{
    id = "yamaha-rx100"; name = "Yamaha RX100 (Classic)"; brand = "Yamaha"; type = "commuter"; price_inr = 40000
    engine_cc = 98.0; mileage_kmpl = 35; power_bhp = 11.0; torque_nm = 10.39; weight_kg = 103
    gear_type = "gear"; fuel_type = "petrol"; abs = $false; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $false
    features = @("Classic 2-stroke engine sound", "Chrome exhaust muffler", "Classic circular headlight", "Analogue dial speedo")
    pros = @("Cult retro 2-stroke exhaust screamer", "Featherlight instant pickup power", "Legendary collector value")
    cons = @("Discontinued, parts are rare", "High emission figures", "Poor drum brake safety standard")
    best_for = "Vintage collectors, classic enthusiasts, and retro weekend rides"
  },

  # --- SUZUKI BRANDS (5 bikes) ---
  @{
    id = "suzuki-gixxer-150"; name = "Suzuki Gixxer 150"; brand = "Suzuki"; type = "sports"; price_inr = 134000
    engine_cc = 155.0; mileage_kmpl = 45; power_bhp = 13.6; torque_nm = 13.8; weight_kg = 141
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Sporty twin-exhaust exit", "Single-channel ABS", "LED headlamp bezel", "Digital console display")
    pros = @("Buttery smooth Suzuki engine refinement", "Very stable handling balance", "Decent fuel mileage indicators")
    cons = @("Fails to excite at high highway speeds", "Instrument console looks outdated", "Seat padding is thin")
    best_for = "Refined daily city sports commuting"
  },
  @{
    id = "suzuki-gixxer-250"; name = "Suzuki Gixxer 250"; brand = "Suzuki"; type = "sports"; price_inr = 181000
    engine_cc = 249.0; mileage_kmpl = 35; power_bhp = 26.5; torque_nm = 22.2; weight_kg = 156
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Suzuki Oil Cooling (SOCS)", "Dual-Channel ABS safety", "Sporty split seat shroud", "Twin-exit muffler")
    pros = @("Quiet oil cooled touring performance", "Linear smooth throttle pull", "High build quality parts")
    cons = @("Stiff rear monoshock", "Very simple styling looks identical to 150cc", "Low range headlight projection")
    best_for = "Smooth sports touring and city commuting"
  },
  @{
    id = "suzuki-gixxer-sf-250"; name = "Suzuki Gixxer SF 250"; brand = "Suzuki"; type = "sports"; price_inr = 192000
    engine_cc = 249.0; mileage_kmpl = 38; power_bhp = 26.5; torque_nm = 22.2; weight_kg = 161
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Aerodynamic full fairing", "Suzuki Oil Cooling System", "Clip-on sports handlebar", "Dual-Channel ABS")
    pros = @("Highly refined 250cc engine", "Comfortable sports touring seating layout", "Incredibly stable highway tracking")
    cons = @("Stiff rear shock over big potholes", "Basic instrument panel graphics", "Windshield protection is limited")
    best_for = "Smooth highway sports touring and fast city commutes"
  },
  @{
    id = "suzuki-access-125"; name = "Suzuki Access 125"; brand = "Suzuki"; type = "scooter"; price_inr = 79000
    engine_cc = 124.0; mileage_kmpl = 48; power_bhp = 8.7; torque_nm = 10.0; weight_kg = 103
    gear_type = "gearless"; fuel_type = "petrol"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Suzuki Ride Connect console", "External fuel filler cap", "Retro chrome circular headlamp", "USB socket and front pocket")
    pros = @("Class-best engine smoothness and pickup", "Highly practical glovebox storage", "Retro styling elegance")
    cons = @("Front body panel prone to rattle", "Key release for fuel lid is separate", "Rear suspension bounces on bumpy roads")
    best_for = "Refined and comfortable city scooter commuting"
  },
  @{
    id = "suzuki-burgman-street-125"; name = "Suzuki Burgman Street 125"; brand = "Suzuki"; type = "scooter"; price_inr = 93000
    engine_cc = 124.0; mileage_kmpl = 48; power_bhp = 8.7; torque_nm = 10.0; weight_kg = 110
    gear_type = "gearless"; fuel_type = "petrol"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Maxi-scooter body styling", "Spacious front glovebox lids", "Dual riding footrest boards", "LED headlight cluster")
    pros = @("Very spacious seating layout", "Excellent wind protection on legs", "Smooth engine cruising pickup")
    cons = @("Rear tyre looks tiny compared to big body", "Rear brake lacks strong bite", "Heavy feel when backing up")
    best_for = "Comfortable, spacious daily city scooter travels"
  },

  # --- KAWASAKI BRANDS (4 bikes) ---
  @{
    id = "kawasaki-ninja-300"; name = "Kawasaki Ninja 300"; brand = "Kawasaki"; type = "sports"; price_inr = 340000
    engine_cc = 296.0; mileage_kmpl = 26; power_bhp = 39.0; torque_nm = 26.1; weight_kg = 179
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $false; highway_capable = $true
    features = @("Parallel twin engine layout", "Slipper clutch assist", "Sporty twin headlights", "Dual-Channel ABS")
    pros = @("Silky smooth parallel-twin acceleration", "Iconic Ninja design styling", "Stable high speed tracking")
    cons = @("Very dated analog instrument cluster", "Extremely expensive spare parts", "Heavy weight for 300cc")
    best_for = "Smooth weekend touring and entry-level twin performance"
  },
  @{
    id = "kawasaki-ninja-400"; name = "Kawasaki Ninja 400"; brand = "Kawasaki"; type = "sports"; price_inr = 524000
    engine_cc = 399.0; mileage_kmpl = 25; power_bhp = 45.0; torque_nm = 37.0; weight_kg = 168
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $false; highway_capable = $true
    features = @("Lightweight trellis chassis", "Aggressive Ninja face", "Parallel twin performance", "Dual-channel ABS")
    pros = @("Incredible power-to-weight ratio", "Excellent wind deflection on tracks", "Top tier track handling")
    cons = @("Extremely high price tag (CBU import)", "Stiff racing seat cushion", "Heats up in city traffic")
    best_for = "Track racing and premium sports touring tours"
  },
  @{
    id = "kawasaki-z400"; name = "Kawasaki Z400"; brand = "Kawasaki"; type = "sports"; price_inr = 490000
    engine_cc = 399.0; mileage_kmpl = 25; power_bhp = 45.0; torque_nm = 38.0; weight_kg = 167
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Sugomi streetfighter design", "Naked trellis frame", "Parallel twin motor", "LCD instrument panel")
    pros = @("Flickable naked handle styling", "Smooth power output delivery", "Highly comfortable urban seating layout")
    cons = @("Expensive service costs", "No wind buffer at high speeds", "Instrument console is small")
    best_for = "Premium streetfighting and highway sports runs"
  },
  @{
    id = "kawasaki-versys-650"; name = "Kawasaki Versys 650"; brand = "Kawasaki"; type = "adventure"; price_inr = 777000
    engine_cc = 649.0; mileage_kmpl = 20; power_bhp = 66.0; torque_nm = 61.0; weight_kg = 219
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $true
    city_friendly = $false; highway_capable = $true
    features = @("Adjustable long travel shocks", "Kawasaki Traction Control (KTRC)", "TFT screen dashboard", "Adjustable touring visor")
    pros = @("Exceptional highway mile-muncher comfort", "Torque-rich twin cylinder motor", "Excellent electronics safety suite")
    cons = @("Extremely heavy (219 kg) and tall", "Scrapes on narrow city paths", "Very expensive maintenance cost")
    best_for = "Premium long distance adventure touring and interstate roadtrips"
  },

  # --- BMW BRANDS (3 bikes) ---
  @{
    id = "bmw-g310r"; name = "BMW G 310 R"; brand = "BMW"; type = "sports"; price_inr = 290000
    engine_cc = 313.0; mileage_kmpl = 30; power_bhp = 34.0; torque_nm = 28.0; weight_kg = 164
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Reverse inclined engine layout", "Ride-by-wire throttle control", "LED headlights", "Dual-Channel ABS")
    pros = @("BMW brand status value", "Very comfortable city commuter ergonomics", "Sharp agile handling frame")
    cons = @("Single cylinder engine vibrations past 7000 RPM", "High price compared to same-engine TVS RR310", "Expensive service checks")
    best_for = "Premium city streetfighter riding and weekend tours"
  },
  @{
    id = "bmw-g310gs"; name = "BMW G 310 GS"; brand = "BMW"; type = "adventure"; price_inr = 330000
    engine_cc = 313.0; mileage_kmpl = 28; power_bhp = 34.0; torque_nm = 28.0; weight_kg = 175
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $true
    city_friendly = $true; highway_capable = $true
    features = @("Plush long travel suspension forks", "Luggage luggage rack", "Reverse inclined motor", "USD front forks")
    pros = @("Incredible suspension cushion comfort", "Commanding tall riding view", "BMW adventure badge value")
    cons = @("Soft forks dive heavily under braking", "Tall seat height (835mm)", "Engine gets buzzey on highway tours")
    best_for = "Comfortable city riding and touring on bad roads"
  },
  @{
    id = "bmw-g310rr"; name = "BMW G 310 RR"; brand = "BMW"; type = "sports"; price_inr = 305000
    engine_cc = 313.0; mileage_kmpl = 30; power_bhp = 34.0; torque_nm = 27.3; weight_kg = 174
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $false
    city_friendly = $false; highway_capable = $true
    features = @("Aggressive race track fairings", "TFT vertical console display", "Ride modes", "Michelin Pilot Street tires")
    pros = @("Premium racing graphics", "Useful track telemetry systems", "Responsive throttle engine")
    cons = @("Heavy engine vibrations in high range", "Aggressive sitting posture causes back pain", "High cost of repair")
    best_for = "Premium weekend sports rides and casual track entries"
  },

  # --- JAWA / YEZDI (4 bikes) ---
  @{
    id = "jawa-42"; name = "Jawa 42"; brand = "Jawa"; type = "cruiser"; price_inr = 198000
    engine_cc = 294.72; mileage_kmpl = 33; power_bhp = 27.0; torque_nm = 26.8; weight_kg = 182
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Twin exhaust pipes", "Bar end side mirrors", "Offset analogue cluster meter", "Dual-Channel ABS")
    pros = @("Modernized retro roadster look", "Fast high-speed cruising acceleration", "Bassy twin exhaust thump")
    cons = @("Very low seating position scrapes legs", "Stiff rear shock setup", "Small sales service network")
    best_for = "Retro-style city commuting and highway cruising"
  },
  @{
    id = "jawa-perak"; name = "Jawa Perak"; brand = "Jawa"; type = "cruiser"; price_inr = 213000
    engine_cc = 334.0; mileage_kmpl = 30; power_bhp = 30.64; torque_nm = 32.74; weight_kg = 185
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Single seat bobber styling", "Floating console seat frame", "Matte black finish overlays", "Hidden rear monoshock")
    pros = @("Stunning custom bobber visuals", "Extremely powerful engine acceleration", "Turns heads everywhere")
    cons = @("Lacks passenger pillion seat completely", "Low ground clearance (145mm)", "Bumpy rear ride comfort")
    best_for = "Stylishly customized solo cruiser riding"
  },
  @{
    id = "yezdi-adventure"; name = "Yezdi Adventure"; brand = "Yezdi"; type = "adventure"; price_inr = 216000
    engine_cc = 334.0; mileage_kmpl = 30; power_bhp = 30.2; torque_nm = 29.9; weight_kg = 188
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $true; usb_charging = $true
    city_friendly = $false; highway_capable = $true
    features = @("Tilt-adjustable digital console display", "Chassis crash racks standard", "ABS modes (Road/Rain/Off-road)", "USB charging socket")
    pros = @("Ready-to-tour layout features", "Powerful highway cruising speed range", "High ground clearance (220mm)")
    cons = @("Vibrates significantly around 80 km/h", "High heavy center of gravity", "Notched gearbox shifts")
    best_for = "Budget adventure touring and long off-road trails"
  },
  @{
    id = "yezdi-roadster"; name = "Yezdi Roadster"; brand = "Yezdi"; type = "cruiser"; price_inr = 206000
    engine_cc = 334.0; mileage_kmpl = 32; power_bhp = 29.7; torque_nm = 29.0; weight_kg = 184
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Retro styling windshield", "Short pillion backrest cushion", "Twin exhaust layout", "Bar end mirrors")
    pros = @("Fast acceleration for retro styling", "Stable highway cruiser tracking", "Bassy exhaust sound note")
    cons = @("Heavy clutch pull", "Seating cushion is hard", "Low speed engine heats up")
    best_for = "Retro touring cruises and daily commuting"
  },

  # --- ATHER / OLA / ELECTRIC (5 bikes) ---
  @{
    id = "ather-450x"; name = "Ather 450X"; brand = "Ather"; type = "electric"; price_inr = 138000
    engine_cc = 0.0; mileage_kmpl = 111; power_bhp = 8.5; torque_nm = 26.0; weight_kg = 111
    gear_type = "gearless"; fuel_type = "electric"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Android OS touchscreen dashboard", "Google Maps maps layout", "Warp riding mode sprint", "Reverse parking assist")
    pros = @("Segment-best touchscreen response and maps", "Excellent flickable handling", "Extremely reliable battery software")
    cons = @("Firm rear suspension feels hard", "Lacks passenger sitting room", "Premium pricing model")
    best_for = "Premium tech-loaded city scooter commuting"
  },
  @{
    id = "ather-450-apex"; name = "Ather 450 Apex"; brand = "Ather"; type = "electric"; price_inr = 175000
    engine_cc = 0.0; mileage_kmpl = 100; power_bhp = 9.3; torque_nm = 26.0; weight_kg = 111
    gear_type = "gearless"; fuel_type = "electric"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Warp+ hyper mode", "Magic Twist regenerative throttle", "Transparent side body panels", "TFT smart display")
    pros = @("Blazing acceleration pickup", "Magic throttle simplifies city braking", "Stunning transparent panels")
    cons = @("Extremely high cost for scooter", "Range drops quickly in Warp+ mode", "Firm stiff suspension setup")
    best_for = "Performance EV scooter fans and city riding"
  },
  @{
    id = "ola-s1-pro"; name = "Ola S1 Pro"; brand = "Ola"; type = "electric"; price_inr = 130000
    engine_cc = 0.0; mileage_kmpl = 130; power_bhp = 11.0; torque_nm = 58.0; weight_kg = 125
    gear_type = "gearless"; fuel_type = "electric"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Hyper performance mode", "Built-in speakers for music", "Keyless passcode ignition code", "Large touchscreen dashboard")
    pros = @("Highest range battery efficiency", "Massive 34L underseat storage compartment", "Fast pickup and top speed (120 km/h)")
    cons = @("Software glitch bugs occur", "Single front fork design prone to breakage", "No physical key option")
    best_for = "Fast, premium, and feature-rich city EV commuting"
  },
  @{
    id = "ola-s1-air"; name = "Ola S1 Air"; brand = "Ola"; type = "electric"; price_inr = 105000
    engine_cc = 0.0; mileage_kmpl = 100; power_bhp = 8.0; torque_nm = 15.0; weight_kg = 108
    gear_type = "gearless"; fuel_type = "electric"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Twin telescope front suspension", "Flat scooter floorboard", "Touchscreen console display", "Reverse park assist")
    pros = @("Highly affordable price", "Conventional flat floorboard utility", "Comfortable dual shock ride")
    cons = @("Slow battery charging speeds", "Basic drum brakes only", "Lacks hyper mode speed")
    best_for = "Budget conscious family city EV travels"
  },
  @{
    id = "bounce-infinity-e1"; name = "Bounce Infinity E1"; brand = "Bounce"; type = "electric"; price_inr = 80000
    engine_cc = 0.0; mileage_kmpl = 85; power_bhp = 3.0; torque_nm = 83.0; weight_kg = 94
    gear_type = "gearless"; fuel_type = "electric"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Swappable battery subscription", "Retro scooter styling", "Drag mode assistance", "Anti-theft alarm system")
    pros = @("Highly convenient battery swap system", "Extremely lightweight and nimble", "Affordable purchase price")
    cons = @("Very low top speed (65 km/h)", "Low build quality parts", "Bumpy rear ride")
    best_for = "Short daily runs and grocery runs with swap batteries"
  },

  # --- OTHERS (8 bikes) ---
  @{
    id = "benelli-trk-502"; name = "Benelli TRK 502"; brand = "Benelli"; type = "adventure"; price_inr = 585000
    engine_cc = 500.0; mileage_kmpl = 22; power_bhp = 47.5; torque_nm = 46.0; weight_kg = 235
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $true
    city_friendly = $false; highway_capable = $true
    features = @("Massive adventure body layout", "Plush touring double seat", "Windscreen and engine guards", "Dual-Channel ABS")
    pros = @("Huge visual road presence", "Extremely comfortable touring layout", "Refined parallel twin exhaust growl")
    cons = @("Very heavy (235 kg) dry weight", "Fails to accelerate quickly", "Expensive maintenance parts")
    best_for = "Comfortable highway cruising touring and long touring travels"
  },
  @{
    id = "triumph-speed-400"; name = "Triumph Speed 400"; brand = "Triumph"; type = "sports"; price_inr = 240000
    engine_cc = 398.15; mileage_kmpl = 30; power_bhp = 39.5; torque_nm = 37.5; weight_kg = 176
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Liquid-cooled engine", "Ride-by-wire throttle control", "Traction control (switchable)", "Dual-Channel ABS")
    pros = @("Incredible premium fit and finish", "Very punchy acceleration pull", "Extremely smooth engine performance")
    cons = @("Vibrations felt past 7500 RPM on highway", "A bit small in physical presence", "Soft front suspension")
    best_for = "Premium city streetfighter riding and fast highway touring"
  },
  @{
    id = "triumph-scrambler-400x"; name = "Triumph Scrambler 400X"; brand = "Triumph"; type = "adventure"; price_inr = 263000
    engine_cc = 398.15; mileage_kmpl = 28; power_bhp = 39.5; torque_nm = 37.5; weight_kg = 185
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $true
    city_friendly = $true; highway_capable = $true
    features = @("19-inch front tire wheel", "Grille headlight protector", "Hand guards standard", "Off-road ABS and TCS modes")
    pros = @("Plush off-road shock absorption", "Commanding tall riding view", "Stunning retro scrambler visuals")
    cons = @("Heavier than Speed 400", "Seat height (835mm) is tall", "Soft front brakes on road braking")
    best_for = "Urban scrambler riding, touring, and gravel trails"
  },
  @{
    id = "husqvarna-svartpilen-250"; name = "Husqvarna Svartpilen 250"; brand = "Husqvarna"; type = "sports"; price_inr = 225000
    engine_cc = 248.76; mileage_kmpl = 32; power_bhp = 30.0; torque_nm = 24.0; weight_kg = 166
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Scrambler design aesthetic", "WP APEX USD front forks", "Dual-Channel ABS safety", "Tank rack standard")
    pros = @("Unique premium swedish styling", "Fast high rev performance", "Excellent flickable handling")
    cons = @("Small fuel tank (9.5 Liters)", "Hard seat cushions", "Low passenger pillion space")
    best_for = "Premium urban street carving and weekend rides"
  },
  @{
    id = "husqvarna-vitpilen-250"; name = "Husqvarna Vitpilen 250"; brand = "Husqvarna"; type = "sports"; price_inr = 224000
    engine_cc = 248.76; mileage_kmpl = 32; power_bhp = 30.0; torque_nm = 24.0; weight_kg = 164
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Cafe racer clip-on bars", "WP Apex forks", "Dual-Channel ABS safety", "Liquid cooled engine")
    pros = @("Striking minimalist design", "Highly responsive cornering grip", "Lightweight agile frames")
    cons = @("Highly aggressive cafe stance causes wrist pain", "Tiny fuel tank capacity", "Firm stiff suspension setup")
    best_for = "Cafe racer riding style fans and weekend twists"
  },
  @{
    id = "cf-moto-300nk"; name = "CF Moto 300NK"; brand = "CF Moto"; type = "sports"; price_inr = 229000
    engine_cc = 292.4; mileage_kmpl = 33; power_bhp = 27.5; torque_nm = 25.0; weight_kg = 151
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("TFT color screen dashboard", "Slipper clutch", "USD front forks", "Aggressive streetfighter frame")
    pros = @("Stunning futuristic visual lines", "Lightweight easy handling", "Decent TFT console features")
    cons = @("Very scarce dealer support in India", "Vibrations at high RPM limits", "Basic braking power feel")
    best_for = "Entry level sports naked style commuting"
  },
  @{
    id = "keeway-k300n"; name = "Keeway K300N"; brand = "Keeway"; type = "sports"; price_inr = 265000
    engine_cc = 292.4; mileage_kmpl = 32; power_bhp = 27.5; torque_nm = 25.0; weight_kg = 151
    gear_type = "gear"; fuel_type = "petrol"; abs = $true; bluetooth = $false; usb_charging = $false
    city_friendly = $true; highway_capable = $true
    features = @("Naked street design layouts", "Dual-Channel ABS safety", "Liquid cooling system", "Underbelly exhaust")
    pros = @("Very aggressive visual profile", "Very light flickable weight", "Smooth initial power pull")
    cons = @("Overpriced for 300cc single cylinder", "Scarce spare parts network", "Stiff ride comfort")
    best_for = "Naked sports urban street riding"
  },
  @{
    id = "revolt-rv400"; name = "Revolt RV400"; brand = "Revolt"; type = "electric"; price_inr = 135000
    engine_cc = 0.0; mileage_kmpl = 80; power_bhp = 4.0; torque_nm = 54.0; weight_kg = 108
    gear_type = "gear"; fuel_type = "electric"; abs = $false; bluetooth = $true; usb_charging = $true
    city_friendly = $true; highway_capable = $false
    features = @("Simulated engine sounds", "Swipe startup via app", "Lithium swappable batteries", "Connected navigation")
    pros = @("Conventional naked sports bike layout", "Simulated exhaust sounds add safety", "Decent city mileage range")
    cons = @("Belt drive belt noise", "Brakes feel soft", "Long charge times")
    best_for = "Economical sporty city EV commuting"
  }
)

# ----------------- Templates of 10 Common Issues by Category -----------------
$commuterIssues = @(
  @{ issue = "Cold Start Hesitation"; cause = "Rich/lean mixture miscalculation by the economy-focused ECU map when cold."; fix = "1. Turn key on, wait for indicator light check. 2. Do not throttle. 3. Start engine. 4. Idle for 45 seconds." },
  @{ issue = "Carburetor/Injector Clogging"; cause = "Adulterated fuel blockages in fuel-delivery lines."; fix = "1. Use fuel additives or cleaners. 2. For heavy clog, dismantle and clean the injector nozzle. 3. Use XP95 clean fuel." },
  @{ issue = "Chain Sprocket Slackness"; cause = "Natural metal stretch combined with lack of lubrication in enclosed box."; fix = "1. Tighten rear axle, turn adjusters to set 25mm slack. 2. Apply 90W gear oil or chain spray. 3. Re-fit chain box cover." },
  @{ issue = "Brake Drum Squealing"; cause = "Brake dust buildup inside the drum hub assembly."; fix = "1. Open wheel drum. 2. Sand brake pads lightly. 3. Clean inside drum with dry cloth. 4. Grease actuator cam pivot." },
  @{ issue = "Clutch Cable Wear"; cause = "Dry inner wire routing friction leading to fraying."; fix = "1. Unhook cable. 2. Pour lube oil down cable sleeve. 3. Adjust free play to 2mm. 4. Replace if metal stands are cut." },
  @{ issue = "Headlight Flickering"; cause = "Loose grounding wire connections behind headlight cowl."; fix = "1. Remove front mask. 2. Clean rust from green ground connector. 3. Secure connection tightly with tape." },
  @{ issue = "Engine Overheating in Traffic"; cause = "Extended idling in low gear combined with poor oil quality."; fix = "1. Change oil to high quality synthetic. 2. Turn engine off at long signals. 3. Clean exterior cooling fins." },
  @{ issue = "White Smoke on Acceleration"; cause = "Worn piston rings letting engine oil enter combustion chamber."; fix = "1. Run compression test. 2. Hone cylinder bore. 3. Fit new piston ring kit. 4. Replace valve stem seals." },
  @{ issue = "Battery Charging Fault"; cause = "Failing Regulator Rectifier (RR) unit not converting alternator current."; fix = "1. Measure battery voltage when revving (must be ~14V). 2. If below 13V, replace the RR unit. 3. Secure fuse pins." },
  @{ issue = "Key Slot Shutter Jam"; cause = "Dirt and rust locking the magnet shutter mechanisms."; fix = "1. Spray WD-40 or contact cleaner. 2. Insert magnet key fob gently. 3. Do not force key turns." }
)

$sportsIssues = @(
  @{ issue = "Engine Coolant Leakage"; cause = "Loose hose clamp connectors or worn water pump mechanical seals."; fix = "1. Tighten metal hose clamps. 2. Check weeping hole under water pump. 3. If leaking, replace pump seal." },
  @{ issue = "Front Fork Oil Seal Leak"; cause = "Road grime scratches the inner slider fork, tearing the rubber seals."; fix = "1. Clean fork sliders. 2. Slide plastic card inside seal to clean. 3. Replace seals and refill with fork oil." },
  @{ issue = "Gear Shift Notchiness"; cause = "Improper clutch lever play or dirty engine oil."; fix = "1. Adjust clutch cable free play to 10-15mm. 2. Flush engine oil. 3. Lube shift link rod pivots." },
  @{ issue = "Rear Brake spongey bite"; cause = "Air bubbles trapped in hydraulic brake fluid lines."; fix = "1. Bleed rear brake line with bleed kit. 2. Keep DOT 4 reservoir full. 3. Clean rotor with alcohol." },
  @{ issue = "Console Resetting on Crank"; cause = "Weak battery voltage drop during high starter motor load."; fix = "1. Tighten battery terminals. 2. Charge battery externally. 3. Replace battery if voltage drops below 10V under crank." },
  @{ issue = "Tappet Noise at High RPM"; cause = "Thermal expansion alters valve clearances beyond specifications."; fix = "1. Let engine cool. 2. Adjust intake and exhaust valve clearances to manual specifications." },
  @{ issue = "Chain Slap on Swingarm"; cause = "Loose chain hitting swingarm rubber slider guide."; fix = "1. Lube chain. 2. Set chain slack to 20mm. 3. Replace swingarm rubber slider if worn to metal." },
  @{ issue = "Radiator Fan Fuse Blowing"; cause = "Dirt/debris blocking radiator fan blades, drawing excess current."; fix = "1. Turn fan blade manually to free debris. 2. Replace 15A fuse in fusebox. 3. Spray low-pressure water to clean." },
  @{ issue = "Sensor Error (FI Light)"; cause = "Water ingress in wiring couplers after pressure washing."; fix = "1. Unplug sensor couplers. 2. Clean with electrical contact spray. 3. Apply dielectric grease and snap back." },
  @{ issue = "Fuel Pump Clogging"; cause = "Particulates in low-grade fuel blocking pre-filter mesh."; fix = "1. Drain fuel. 2. Remove fuel pump. 3. Replace pump pre-filter mesh. 4. Refill with high-octane fuel." }
)

$cruiserIssues = @(
  @{ issue = "Excessive Frame Vibrations"; cause = "Loose engine hanger mounting bracket bolts."; fix = "1. Locate engine mount brackets. 2. Tighten all chassis mount bolts to spec torque. 3. Check wheel balancing." },
  @{ issue = "Hard Clutch Lever Pull"; cause = "High friction in dry routing curves of clutch cable."; fix = "1. Clean and lube inner cable using light machine oil. 2. Route cable with gentle curves. 3. Adjust lever play." },
  @{ issue = "Rear Brake Pedal Squealing"; cause = "Glazed rear brake pads or dirt on rotor."; fix = "1. Remove pads. 2. Sand pad surfaces. 3. Spray disc rotor with brake cleaner. 4. Re-fit pads." },
  @{ issue = "Exhaust Pipe Rusting"; cause = "Poor chrome protection quality reacting with moisture."; fix = "1. Wipe pipe clean. 2. Polish with chrome restorer. 3. Use steel wool on heavy spots. 4. Wipe dry after rain." },
  @{ issue = "Speedometer Fogging"; cause = "Moisture entry in console seal casing during rains."; fix = "1. Let bike sit in direct sun. 2. Seal instrument glass edge with clear silicone bead." },
  @{ issue = "Rear Suspension Stiffness"; cause = "High factory preload settings for single riders."; fix = "1. Use C-spanner on shock collar. 2. Turn collar to step 1 or 2 (softest). 3. Adjust equally on both sides." },
  @{ issue = "Battery Drain on Idle"; cause = "Continuous draw from aftermarket USB/GPS trackers."; fix = "1. Disconnect trackers when parked. 2. Verify alternator charging is ~14.2V. 3. Replace battery if old." },
  @{ issue = "Side Stand Switch Cutout"; cause = "Dirt blocking side stand kill switch magnetic sensor."; fix = "1. Clean side stand pivot. 2. Spray switch with contact cleaner. 3. Ensure stand returns fully up." },
  @{ issue = "Chrome Finish Discoloration"; cause = "Engine heat turning exhaust chrome yellow/blue."; fix = "1. Use specialized chrome metal polish. 2. Rub in circular motion. 3. Apply anti-rust protectant." },
  @{ issue = "Tappet Chatter Noise"; cause = "Valves expanding out of clearance parameters."; fix = "1. Set valve clearance: Inlet 0.08mm, Exhaust 0.18mm. 2. Tighten rocker locknuts." }
)

$adventureIssues = @(
  @{ issue = "Suspension Fork Seal Leak"; cause = "Mud and sand grit scratching the USD fork slider tubes."; fix = "1. Wipe sliders clean. 2. Clean under dust cap with plastic scraper. 3. Replace seal if oil continues to seep." },
  @{ issue = "Chassis Hanger Weld Crack"; cause = "High off-road impact loads on frame mounting welds."; fix = "1. Inspect chassis welds. 2. Have bracket re-welded at specialist shop. 3. Avoid landing hard jumps." },
  @{ issue = "Luggage Rack Rattling"; cause = "Vibrations loosening bolts on tail rack mounts."; fix = "1. Check rack screws. 2. Re-fit screws using blue threadlocker fluid. 3. Add rubber washers at mount interfaces." },
  @{ issue = "Front Wheel Rim Bend"; cause = "Hitting large rock impacts on alloy rims."; fix = "1. Spin wheel to check bend. 2. Visit wheel repair shop to straighten rim. 3. Maintain off-road tyre pressures." },
  @{ issue = "Engine Stalling on Inclines"; cause = "Fuel sloshing in tank causing temporary fuel pump airlocks."; fix = "1. Keep fuel level above 4 Liters. 2. Check fuel pump pressure. 3. Calibrate rollover lean sensor." },
  @{ issue = "ABS System Failure Indicator"; cause = "Mud and dust clogging the wheel ABS sensor rings."; fix = "1. Spray ABS rings with clean water. 2. Wipe sensor heads clean. 3. Verify sensor wire connections." },
  @{ issue = "Throttle Grip Sticking"; cause = "Dirt entry inside handlebar throttle sleeve."; fix = "1. Remove bar-end weight. 2. Pull throttle sleeve. 3. Clean handlebar tube, apply dry lube." },
  @{ issue = "Chain Roller Breakdown"; cause = "High tension off-road chain slap destroying plastic roller."; fix = "1. Inspect roller. 2. Replace with heavy duty poly roller. 3. Grease pivot mounting bolt." },
  @{ issue = "Console Condensation"; cause = "Micro gaps in instrument cluster casing seal."; fix = "1. Place screen protector cover. 2. Dry in sun. 3. Seal casing seams with adhesive." },
  @{ issue = "Slipper Clutch Slippage"; cause = "Worn clutch plates from aggressive off-road clutch slipping."; fix = "1. Measure clutch spring lengths. 2. Replace friction plates. 3. Use recommended engine oil grade." }
)

$scooterIssues = @(
  @{ issue = "Cold Start ECU Failure"; cause = "Rich mixture miscalculation on startup by the FI system."; fix = "1. Switch key on, wait for fuel pump noise to stop. 2. Crank without throttle. 3. Idle for 60 seconds." },
  @{ issue = "Front Telescopic Fork Squeaking"; cause = "Lack of lubrication grease under fork dust seals."; fix = "1. Clean fork sliders. 2. Apply silicone grease spray under dust cap. 3. Pump forks." },
  @{ issue = "CVT Drive Belt Slippage"; cause = "CVT belt wear or excessive clutch dust buildup."; fix = "1. Remove CVT cover. 2. Clean clutch housing. 3. Inspect belt for cracks; replace if worn." },
  @{ issue = "Fuel Lid Release Stuck"; cause = "Corrosion inside release cable and latch lock."; fix = "1. Spray WD-40 inside fuel key slot. 2. Pull/push seat fuel switch repeatedly. 3. Adjust cable tension." },
  @{ issue = "CBS Equalizer Cable Play"; cause = "Brake cables stretching out of sync in Combi-Brake."; fix = "1. Adjust equalizer screw under front shield. 2. Lube cables. 3. Maintain lever play to 15mm." },
  @{ issue = "Low Fuel Economy"; cause = "Clogged air filter element combined with incorrect tire PSI."; fix = "1. Replace air filter every 8000km. 2. Inflate tyres: Front 22, Rear 36 PSI. 3. Avoid sudden full throttle." },
  @{ issue = "Battery Discharging on Stand"; cause = "RR regulator failure or aftermarket USB charging outlet draw."; fix = "1. Check charging voltage (must be ~14V). 2. Disconnect accessories. 3. Replace regulator if faulty." },
  @{ issue = "Lock Shutter Jammed"; cause = "Dust entering key slot locking shutter slider."; fix = "1. Inject contact cleaner. 2. Tap key head. 3. Use magnetic fob to slide open shutter." },
  @{ issue = "CVT Variator Roller Flat Spots"; cause = "Natural wear of rollers causing acceleration vibrations."; fix = "1. Open CVT casing. 2. Remove variator fan. 3. Replace all 6 rollers with original parts." },
  @{ issue = "Spark Plug Carbon Deposit"; cause = "Extended slow city crawls prevent spark plug self-cleaning."; fix = "1. Remove spark plug. 2. Clean tip with wire brush. 3. Set gap to 0.8mm. 4. Ride fast occasionally." }
)

$electricIssues = @(
  @{ issue = "Dashboard Screen Lockup"; cause = "Software firmware crashes in Android dashboard module."; fix = "1. Turn key off, wait 3 minutes. 2. Perform hard reboot via brake/button hold. 3. Check for OTA update." },
  @{ issue = "Regenerative Brake Sensor Jam"; cause = "Dirt inside brake lever microswitch sensor contacts."; fix = "1. Clean brake lever pivot area. 2. Spray contact cleaner into microswitch. 3. Verify throttle roll back response." },
  @{ issue = "Charger Port Thermal Trip"; cause = "Heat buildup on charging terminals in hot sun."; fix = "1. Allow bike to cool. 2. Charge in shaded ventilated space. 3. Clean charging socket pins." },
  @{ issue = "Range Drop in Sport Mode"; cause = "High current battery draw causing cell heating and efficiency drops."; fix = "1. Use eco/normal modes for heavy traffic. 2. Avoid sudden aggressive launches. 3. Keep tyre PSI high." },
  @{ issue = "Keyless Keyfob Disconnect"; cause = "Smart keyfob battery dying or cell RF signal jamming."; fix = "1. Replace coin battery in fob. 2. Hold fob near seat receiver coil. 3. Use manual PIN code start." },
  @{ issue = "Hub Motor Noise"; cause = "Bearing wear or water ingress inside wheel motor hub."; fix = "1. Inspect hub seals. 2. Replace motor shaft bearings. 3. Avoid washing motor with high pressure." },
  @{ issue = "BMS Under-voltage Lockout"; cause = "Deep discharge of battery cells from long sitting periods."; fix = "1. Charge battery immediately if below 15%. 2. If locked, visit dealer for high-voltage jump." },
  @{ issue = "Throttle Sensor Calibration Error"; cause = "Electronic pot values drifting in ride-by-wire throttle."; fix = "1. Switch bike off. 2. Rotate throttle full open and close twice. 3. Switch bike on to calibrate." },
  @{ issue = "Side Stand Cutoff Switch Failure"; cause = "Mud coating the proximity stand sensor."; fix = "1. Clean stand pivot assembly. 2. Inspect sensor wiring. 3. Use dashboard diagnostic screen check." },
  @{ issue = "High Pressure Wash Screen Condensate"; cause = "Water ingress under LCD screen glass seal."; fix = "1. Park in dry direct sun. 2. Dry with hot air dryer. 3. Replace screen seal protector." }
)

# ----------------- Loop to Compile 100 Bikes -----------------
$finalBikes = [System.Collections.Generic.List[PSObject]]::new()

foreach ($b in $bikes) {
  # 1. Map category to issues pool
  $pool = $commuterIssues
  if ($b.type -eq "sports") { $pool = $sportsIssues }
  elseif ($b.type -eq "cruiser") { $pool = $cruiserIssues }
  elseif ($b.type -eq "adventure") { $pool = $adventureIssues }
  elseif ($b.type -eq "scooter") { $pool = $scooterIssues }
  elseif ($b.type -eq "electric") { $pool = $electricIssues }

  # 2. Select 10 issues (or all, since our pools have 10 issues exactly)
  $customIssues = @()
  for ($i = 0; $i -lt 10; $i++) {
    $template = $pool[$i]
    $bikeName = $b.name
    $issueTitle = $template.issue
    
    # Interpolate bike name to customize the issue details
    $customCause = $template.cause -replace "engine", "$bikeName engine" -replace "fuel", "$bikeName fuel" -replace "battery", "$bikeName battery"
    $customFix = $template.fix -replace "engine", "$bikeName engine" -replace "bike", "$bikeName" -replace "cables", "$bikeName cables"

    $customIssues += @{
      issue = $issueTitle
      cause = $customCause
      fix = $customFix
    }
  }

  # 3. Create full object with required properties
  $newBike = [PSCustomObject]@{
    id = $b.id
    name = $b.name
    brand = $b.brand
    type = $b.type
    price_inr = $b.price_inr
    engine_cc = $b.engine_cc
    mileage_kmpl = $b.mileage_kmpl
    power_bhp = $b.power_bhp
    torque_nm = $b.torque_nm
    weight_kg = $b.weight_kg
    gear_type = $b.gear_type
    fuel_type = $b.fuel_type
    abs = $b.abs
    bluetooth = $b.bluetooth
    usb_charging = $b.usb_charging
    city_friendly = $b.city_friendly
    highway_capable = $b.highway_capable
    features = $b.features
    pros = $b.pros
    cons = $b.cons
    best_for = $b.best_for
    common_issues = $customIssues
  }

  $finalBikes.Add($newBike)
}

# Ensure directory exists
$targetDir = Join-Path $PSScriptRoot ".." "data"
if (-not (Test-Path $targetDir)) {
  New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

$targetFile = Join-Path $targetDir "bikes-db.json"
$json = ConvertTo-Json -InputObject $finalBikes -Depth 10
Set-Content -Path $targetFile -Value $json -Encoding utf8

Write-Host "==================================================="
Write-Host "✅ Compiled 100 Indian bikes successfully!"
Write-Host "Target: $targetFile"
Write-Host "Total issues generated: ($($finalBikes.Count) * 10) = 1,000 issues"
Write-Host "==================================================="
