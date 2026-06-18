/**
 * AI Engine for BikeAI Assistant (Indian Bikes)
 * Pure rule-based implementation. Works offline on Node.js backend.
 */

/**
 * [RECOMMENDER ENGINE]
 * Scores all available bikes based on user criteria and returns the top 3 matches.
 * 
 * Criteria object: { budget: number, usage: string, daily_km: number, preference: string }
 */
function recommendBikes(bikes, criteria) {
  const budget = parseFloat(criteria.budget) || 150000;
  const usage = (criteria.usage || 'commuter').toLowerCase();
  const dailyKm = parseFloat(criteria.daily_km) || 20;
  const preference = (criteria.preference || '').toLowerCase();

  const scoredBikes = bikes.map(bike => {
    let score = 0;
    const reasons = [];

    // 1. Budget Match (Max 40 points)
    if (bike.price_inr <= budget) {
      score += 40;
      const budgetSavings = budget - bike.price_inr;
      if (budgetSavings > 0) {
        reasons.push(`Fits comfortably in your budget (saving you ₹${budgetSavings.toLocaleString('en-IN')})`);
      } else {
        reasons.push(`Fits perfectly within your budget limit of ₹${budget.toLocaleString('en-IN')}`);
      }
    } else {
      // Penalty for going over budget
      const excessRatio = (bike.price_inr - budget) / budget;
      const budgetPenalty = Math.min(40, excessRatio * 80); // Strict budget scaling
      const budgetScore = 40 - budgetPenalty;
      score += Math.max(0, budgetScore);
      if (budgetScore > 10) {
        reasons.push(`Slightly above your budget by ₹${(bike.price_inr - budget).toLocaleString('en-IN')}, but offers great value`);
      } else {
        reasons.push(`Exceeds your budget significantly by ₹${(bike.price_inr - budget).toLocaleString('en-IN')}`);
      }
    }

    // 2. Usage Type Match (Max 30 points)
    // Map usage inputs to bike types
    let targetType = 'commuter';
    if (usage.includes('sport') || usage.includes('race') || usage.includes('speed') || usage.includes('performance')) {
      targetType = 'sports';
    } else if (usage.includes('cruise') || usage.includes('tour') || usage.includes('highway') || usage.includes('long')) {
      targetType = 'cruiser';
    } else if (usage.includes('city') || usage.includes('daily') || usage.includes('office') || usage.includes('mileage')) {
      targetType = 'commuter';
    }

    if (bike.type === targetType) {
      score += 30;
      reasons.push(`Designed specifically for ${targetType} usage, matching your riding profile`);
    } else {
      // Partial matches
      if (bike.type === 'commuter' && targetType === 'cruiser') {
        score += 15;
        reasons.push(`A commuter bike that can handle short weekend tours, though not a dedicated cruiser`);
      } else if (bike.type === 'cruiser' && targetType === 'commuter') {
        score += 20;
        reasons.push(`A cruiser that offers high riding comfort for daily city rides`);
      } else if (bike.type === 'sports' && targetType === 'commuter') {
        score += 15;
        reasons.push(`A sporty bike that adds excitement to daily office commutes`);
      } else {
        score += 10;
        reasons.push(`Can handle your requested usage, though it is primarily built as a ${bike.type}`);
      }
    }

    // 3. Mileage vs Daily KM (Max 30 points)
    if (dailyKm >= 45) {
      // Long distance: Fuel efficiency is critical
      const mileageScore = Math.min(30, (bike.mileage_kmpl / 65) * 30);
      score += mileageScore;
      if (bike.mileage_kmpl >= 45) {
        reasons.push(`Highly fuel efficient (${bike.mileage_kmpl} kmpl) for your heavy daily run of ${dailyKm} km`);
      } else {
        reasons.push(`Has moderate efficiency (${bike.mileage_kmpl} kmpl) which might increase daily fuel bills for a ${dailyKm} km run`);
      }
    } else {
      // Short distance: Power, style, and comfort are prioritized over mileage
      const powerScore = Math.min(30, (bike.power_bhp / 43.5) * 20 + 10);
      score += powerScore;
      if (bike.power_bhp >= 20) {
        reasons.push(`Offers strong engine performance (${bike.power_bhp} bhp) which is perfect for exciting short commutes`);
      } else {
        reasons.push(`Lightweight and manageable power output (${bike.power_bhp} bhp) for easy short-distance handling`);
      }
    }

    // 4. Keyword Preference Match (Bonus Max 10 points)
    if (preference) {
      let preferenceMatch = false;
      if (bike.brand.toLowerCase().includes(preference) || bike.name.toLowerCase().includes(preference)) {
        score += 10;
        preferenceMatch = true;
        reasons.push(`Matches your specific brand/model preference for ${bike.brand}`);
      }
      
      const featuresText = bike.features.join(' ').toLowerCase();
      if (!preferenceMatch && (featuresText.includes(preference) || bike.best_for.toLowerCase().includes(preference))) {
        score += 8;
        reasons.push(`Features match your preference for '${preference}'`);
      }
    }

    // Round score to nearest integer
    score = Math.round(score);

    return {
      bike: {
        id: bike.id,
        name: bike.name,
        brand: bike.brand,
        type: bike.type,
        price_inr: bike.price_inr,
        mileage_kmpl: bike.mileage_kmpl,
        engine_cc: bike.engine_cc,
        power_bhp: bike.power_bhp,
        weight_kg: bike.weight_kg
      },
      score: score,
      reasons: reasons
    };
  });

  // Sort by score descending and take top 3
  return scoredBikes
    .sort((a, b) => b.score - a.score)
    .slice(0, 3);
}

/**
 * [DIAGNOSTICS ENGINE]
 * Matches symptoms against common_issues of a specific bike.
 * 
 * symptoms: array of symptom strings (or single string containing keywords)
 */
function diagnoseIssues(bike, symptoms) {
  if (!bike || !bike.common_issues) return [];

  // Convert input to lowercase string for keyword searching
  const symptomText = (Array.isArray(symptoms) ? symptoms.join(' ') : String(symptoms)).toLowerCase();

  // Define Keyword mapping categories
  const categories = {
    starting: ['start', 'cold start', 'ignition', 'kick', 'crank', 'battery', 'stalling', 'stall', 'key', 'lock'],
    mileage: ['mileage', 'average', 'fuel', 'carburetor', 'injector', 'cleaner', 'smoke', 'exhaust', 'white smoke'],
    vibration: ['vibration', 'vibrate', 'noise', 'squeak', 'rattle', 'buzz', 'chatter', 'tappet', 'loose', 'sound'],
    brakes: ['brake', 'stopping', 'squeal', 'spongey', 'lever', 'bite', 'disc', 'caliper', 'drum'],
    oil: ['oil', 'leak', 'coolant', 'gasket', 'heating', 'overheating', 'temperature', 'fan', 'radiator', 'seal'],
    chain: ['chain', 'sprocket', 'gear', 'clutch', 'shift', 'neutral', 'slack', 'roller']
  };

  // Identify matching categories based on user symptoms
  const matchedCategories = [];
  Object.keys(categories).forEach(cat => {
    const hasKeywords = categories[cat].some(kw => symptomText.includes(kw));
    if (hasKeywords) matchedCategories.push(cat);
  });

  const diagnoses = bike.common_issues.map(issue => {
    let confidence = 0;
    const issueTitle = issue.issue.toLowerCase();
    const issueCause = issue.cause.toLowerCase();
    const issueFix = issue.fix.toLowerCase();

    // 1. Direct title match (High weight)
    let titleMatches = 0;
    const splitWords = symptomText.split(/\s+/);
    splitWords.forEach(word => {
      if (word.length > 3 && issueTitle.includes(word)) {
        titleMatches++;
      }
    });
    confidence += titleMatches * 25;

    // 2. Category matching
    let categoryMatches = 0;
    matchedCategories.forEach(cat => {
      // Check if this issue fits the matching categories
      const kwList = categories[cat];
      const matchesIssue = kwList.some(kw => issueTitle.includes(kw) || issueCause.includes(kw));
      if (matchesIssue) {
        categoryMatches++;
      }
    });
    confidence += categoryMatches * 30;

    // 3. General body text match
    let bodyMatches = 0;
    splitWords.forEach(word => {
      if (word.length > 4 && (issueCause.includes(word) || issueFix.includes(word))) {
        bodyMatches++;
      }
    });
    confidence += bodyMatches * 10;

    // Cap confidence at 98% (since we are rule-based and not seeing the bike physically)
    confidence = Math.min(98, confidence);

    return {
      issue: issue.issue,
      cause: issue.cause,
      fix: issue.fix,
      confidence: confidence
    };
  });

  // Filter out diagnoses with zero or very low confidence
  // If nothing matched, we will return some high-frequency common issues for this bike with 15% confidence as general suggestions
  let finalDiagnoses = diagnoses.filter(d => d.confidence > 15);
  
  if (finalDiagnoses.length === 0) {
    // Return top 2 general issues for the bike as fallback
    finalDiagnoses = diagnoses.slice(0, 2).map(d => ({
      ...d,
      confidence: 15,
      note: "No direct symptom match found. Displaying general troubleshooting tips for this model."
    }));
  }

  return finalDiagnoses.sort((a, b) => b.confidence - a.confidence);
}

/**
 * [CHAT AI]
 * Keyword-intent parser to return smart responses using local bike data.
 */
function generateChatResponse(message, bikeId, bikes) {
  const text = message.toLowerCase();
  
  // Find current bike if bikeId is provided
  let currentBike = null;
  if (bikeId) {
    currentBike = bikes.find(b => b.id === bikeId);
  }

  // Attempt to detect a bike name in the message text even if bikeId is missing
  let mentionedBike = null;
  for (const b of bikes) {
    const bikeWords = b.name.toLowerCase().split(' ');
    // Match Royal Enfield or Classic 350 or Duke 390
    if (text.includes(b.id) || text.includes(b.name.toLowerCase()) || 
       (bikeWords.length > 1 && text.includes(bikeWords[0]) && text.includes(bikeWords[bikeWords.length - 1]))) {
      mentionedBike = b;
      break;
    }
  }

  // Set contextual bike
  const targetBike = mentionedBike || currentBike;

  // 1. Intent Detection Heuristics
  let intent = 'UNKNOWN';
  
  if (text.match(/\b(hi|hello|hey|namaste|greetings|yo)\b/)) {
    intent = 'GREETING';
  } else if (text.includes('recommend') || text.includes('suggest') || text.includes('which bike') || text.includes('choose') || text.includes('buy') || text.includes('help me select')) {
    intent = 'RECOMMENDATION';
  } else if (text.includes('compare') || text.includes(' vs ') || text.includes('versus') || text.includes('difference between')) {
    intent = 'COMPARISON';
  } else if (text.includes('problem') || text.includes('issue') || text.includes('trouble') || text.includes('fix') || text.includes('repair') || text.includes('diagnose') || text.includes('fault') || text.includes('starting') || text.includes('vibration') || text.includes('squeak') || text.includes('broken')) {
    intent = 'PROBLEM';
  } else if (text.includes('spec') || text.includes('engine') || text.includes('power') || text.includes('torque') || text.includes('weight') || text.includes('feature') || text.includes('cc') || text.includes('bhp') || text.includes('kg')) {
    intent = 'SPECS';
  } else if (text.includes('price') || text.includes('cost') || text.includes('inr') || text.includes('rupees') || text.includes('how much') || text.includes('budget') || text.includes('on road')) {
    intent = 'PRICE';
  } else if (text.includes('mileage') || text.includes('kmpl') || text.includes('fuel economy') || text.includes('efficiency') || text.includes('average')) {
    intent = 'MILEAGE';
  } else if (text.includes('maintenance') || text.includes('service') || text.includes('oil change') || text.includes('schedule') || text.includes('care') || text.includes('lube')) {
    intent = 'MAINTENANCE';
  }

  // 2. Generate Response based on Intent and Context
  switch (intent) {
    case 'GREETING': {
      let greetText = "Hello! I am your **BikeAI Assistant**. 🏍️\n\nI can help you explore Indian bikes, compare specifications, diagnose common maintenance issues, and recommend models that suit your budget.\n\n";
      if (targetBike) {
        greetText += `I see you are interested in the **${targetBike.name}**. You can ask me about its price, specifications, features, common issues, or how to fix them!`;
      } else {
        greetText += "What would you like to do? You can ask me something like:\n* *'Recommend a bike within 2 lakhs for office use'* \n* *'Compare Pulsar NS200 and Apache 160'* \n* *'What are the common issues of Activa 6G?'*";
      }
      return { response: greetText, bikeId: targetBike ? targetBike.id : null };
    }

    case 'RECOMMENDATION': {
      // Check if criteria can be parsed from text
      // Budget parsing
      let budgetVal = 150000;
      const budgetMatch = text.match(/(\d+)\s*(lakh|lakhs|k|thousand|l)/);
      if (budgetMatch) {
        let num = parseFloat(budgetMatch[1]);
        let unit = budgetMatch[2];
        if (unit.startsWith('l')) {
          budgetVal = num * 100000;
        } else if (unit === 'k' || unit.startsWith('t')) {
          budgetVal = num * 1000;
        }
      } else {
        // Look for plain numbers above 50000
        const numberMatches = text.match(/\b\d{5,6}\b/g);
        if (numberMatches) {
          budgetVal = Math.max(...numberMatches.map(Number));
        }
      }

      // Usage parsing
      let usageType = 'commuter';
      if (text.includes('sport') || text.includes('race') || text.includes('speed') || text.includes('performance')) {
        usageType = 'sports';
      } else if (text.includes('cruise') || text.includes('tour') || text.includes('highway') || text.includes('long')) {
        usageType = 'cruiser';
      }

      // Daily distance parsing
      let dailyDist = 20;
      const distMatch = text.match(/(\d+)\s*(km|kms|kilometer|kilometers)/);
      if (distMatch) {
        dailyDist = parseInt(distMatch[1]);
      }

      const recs = recommendBikes(bikes, { budget: budgetVal, usage: usageType, daily_km: dailyDist });
      let recText = `Based on your request, I ran a scoring analysis matching your criteria:\n`;
      recText += `* **Target Budget**: ₹${budgetVal.toLocaleString('en-IN')}\n`;
      recText += `* **Riding Usage**: ${usageType.toUpperCase()}\n`;
      recText += `* **Daily Commute**: ${dailyDist} km\n\n`;
      recText += `Here are my top 3 recommended bikes:\n\n`;

      recs.forEach((rec, idx) => {
        recText += `${idx + 1}. **${rec.bike.brand} ${rec.bike.name}** (Match Score: **${rec.score}%**)\n`;
        recText += `   * **Price**: ~₹${rec.bike.price_inr.toLocaleString('en-IN')} (Ex-showroom)\n`;
        recText += `   * **Engine/Specs**: ${rec.bike.engine_cc}cc | ${rec.bike.power_bhp} BHP | ${rec.bike.mileage_kmpl} kmpl\n`;
        recText += `   * **Why it matches**: ${rec.reasons.join('; ')}.\n\n`;
      });

      recText += `Would you like me to compare any of these, or do you have a specific brand in mind?`;
      return { response: recText, bikeId: targetBike ? targetBike.id : null };
    }

    case 'COMPARISON': {
      // Find two bikes mentioned in the query
      const matchedCompareList = [];
      for (const b of bikes) {
        const words = b.name.toLowerCase().split(' ');
        if (text.includes(b.id) || text.includes(b.name.toLowerCase()) || 
           (words.length > 1 && text.includes(words[0]) && text.includes(words[words.length - 1]))) {
          matchedCompareList.push(b);
        }
      }

      // If we only have 1 bike but also a contextual active bike, compare them
      if (matchedCompareList.length === 1 && currentBike && currentBike.id !== matchedCompareList[0].id) {
        matchedCompareList.push(currentBike);
      }

      if (matchedCompareList.length < 2) {
        // Fallback comparison: pick two prominent sports or commuter models
        matchedCompareList.push(bikes[2]); // NS200
        matchedCompareList.push(bikes[3]); // Apache RTR 160
      }

      const b1 = matchedCompareList[0];
      const b2 = matchedCompareList[1];

      let compText = `Here is a side-by-side comparison between **${b1.name}** and **${b2.name}**:\n\n`;
      compText += `| Specification | ${b1.name} | ${b2.name} |\n`;
      compText += `| :--- | :--- | :--- |\n`;
      compText += `| **Brand** | ${b1.brand} | ${b2.brand} |\n`;
      compText += `| **Type** | ${b1.type.toUpperCase()} | ${b2.type.toUpperCase()} |\n`;
      compText += `| **Price (approx)** | ₹${b1.price_inr.toLocaleString('en-IN')} | ₹${b2.price_inr.toLocaleString('en-IN')} |\n`;
      compText += `| **Engine Displacement** | ${b1.engine_cc} cc | ${b2.engine_cc} cc |\n`;
      compText += `| **Max Power** | ${b1.power_bhp} BHP | ${b2.power_bhp} BHP |\n`;
      compText += `| **Max Torque** | ${b1.torque_nm} Nm | ${b2.torque_nm} Nm |\n`;
      compText += `| **Mileage (Claimed)** | ${b1.mileage_kmpl} kmpl | ${b2.mileage_kmpl} kmpl |\n`;
      compText += `| **Curb Weight** | ${b1.weight_kg} kg | ${b2.weight_kg} kg |\n\n`;

      compText += `**Key Highlights**:\n`;
      compText += `* **${b1.name}**: Best for ${b1.best_for}. *Pros*: ${b1.pros.join(', ')}.\n`;
      compText += `* **${b2.name}**: Best for ${b2.best_for}. *Pros*: ${b2.pros.join(', ')}.\n\n`;
      compText += `Which of these specifications matters most for your riding style?`;

      return { response: compText, bikeId: b1.id };
    }

    case 'PROBLEM': {
      if (!targetBike) {
        return {
          response: "To help you troubleshoot, please tell me which bike model you own. For example, *'My Pulsar NS200 has a starting problem'* or *'Royal Enfield Classic 350 oil leak'*.",
          bikeId: null
        };
      }

      // Run diagnostics logic
      const issues = diagnoseIssues(targetBike, text);
      let diagText = `I ran a local diagnostic check on common issues reported for the **${targetBike.name}**:\n\n`;

      if (issues.length > 0 && issues[0].confidence > 15) {
        const topIssue = issues[0];
        diagText += `### 🔍 Match Found: **${topIssue.issue}** (Confidence: ${topIssue.confidence}%)\n`;
        diagText += `* **Probable Root Cause**: ${topIssue.cause}\n\n`;
        diagText += `**Step-by-Step Fix Instructions**:\n`;
        // Split fix into lines if it has steps
        const steps = topIssue.fix.split(/(?=\d\.)/);
        steps.forEach(step => {
          diagText += `* ${step.trim().replace(/^\*\s*/, '')}\n`;
        });
        
        if (issues.length > 1) {
          diagText += `\n---\n**Other possible issues matched:**\n`;
          issues.slice(1, 3).forEach(other => {
            diagText += `* **${other.issue}** (${other.confidence}% confidence)\n  *Cause*: ${other.cause}\n`;
          });
        }
      } else {
        diagText += `I couldn't find a direct symptom match for your query, but here are the most frequently reported issues for the **${targetBike.name}**:\n\n`;
        targetBike.common_issues.slice(0, 3).forEach((issue, idx) => {
          diagText += `${idx + 1}. **${issue.issue}**\n   * **Cause**: ${issue.cause}\n   * **Fix**: ${issue.fix}\n\n`;
        });
      }

      diagText += `\n*Disclaimer: Rule-based advice. If the problem persists or requires heavy mechanical dismantling, please visit an authorized service center.*`;
      return { response: diagText, bikeId: targetBike.id };
    }

    case 'SPECS': {
      if (!targetBike) {
        return {
          response: "Which bike's specifications are you looking for? Try asking *'What are the specs of KTM Duke 390?'* or *'Show features of Activa 6G'*.",
          bikeId: null
        };
      }

      let specText = `Here are the official specifications and premium features of the **${targetBike.brand} ${targetBike.name}**:\n\n`;
      specText += `* **Category**: ${targetBike.type.toUpperCase()}\n`;
      specText += `* **Engine Displacement**: ${targetBike.engine_cc} cc\n`;
      specText += `* **Max Power**: ${targetBike.power_bhp} BHP\n`;
      specText += `* **Max Torque**: ${targetBike.torque_nm} Nm\n`;
      specText += `* **Curb Weight**: ${targetBike.weight_kg} kg\n`;
      specText += `* **Fuel Mileage**: ~${targetBike.mileage_kmpl} kmpl\n\n`;
      
      specText += `**Key Feature Suite**:\n`;
      targetBike.features.forEach(feat => {
        specText += `* 🛡️ ${feat}\n`;
      });

      specText += `\n**Best Suited For**: ${targetBike.best_for}.\n\n`;
      specText += `Would you like to know the price or look at some common troubleshooting issues for this bike?`;
      return { response: specText, bikeId: targetBike.id };
    }

    case 'PRICE': {
      if (!targetBike) {
        return {
          response: "Which bike's price are you interested in? Try asking *'How much does the Meteor 350 cost?'* or *'Price of Hero Splendor'*",
          bikeId: null
        };
      }

      let priceText = `The **${targetBike.brand} ${targetBike.name}** has an approximate ex-showroom price of **₹${targetBike.price_inr.toLocaleString('en-IN')}** in India.\n\n`;
      priceText += `*Please note: On-road pricing varies by state and city due to RTO registration charges, road tax, insurance, and local logistics. For example, in Delhi or Mumbai, you can expect an additional 10-15% over the ex-showroom price.*\n\n`;
      priceText += `Would you like me to recommend a bike that fits a specific budget limit?`;
      return { response: priceText, bikeId: targetBike.id };
    }

    case 'MILEAGE': {
      if (!targetBike) {
        return {
          response: "Which bike's mileage or fuel efficiency would you like to check? Try asking *'What is the mileage of Splendor?'* or *'KTM Duke 390 mileage'*.",
          bikeId: null
        };
      }

      let fuelText = `The **${targetBike.brand} ${targetBike.name}** offers a claimed fuel efficiency of **${targetBike.mileage_kmpl} kmpl**.\n\n`;
      if (targetBike.mileage_kmpl >= 50) {
        fuelText += `This is a highly economical mileage bracket, meaning a low daily running cost. Ideal for riders looking to maximize savings!`;
      } else if (targetBike.mileage_kmpl >= 35) {
        fuelText += `This is a balanced mileage rating for its performance category. Solid for daily commuting, though not ultra-frugal.`;
      } else {
        fuelText += `As a performance-oriented engine, the fuel efficiency is lower. Ideal for enthusiasts who prioritize torque and power over savings.`;
      }
      return { response: fuelText, bikeId: targetBike.id };
    }

    case 'MAINTENANCE': {
      if (!targetBike) {
        return {
          response: "Which bike's maintenance are you asking about? Try *'Classic 350 maintenance checklist'* or *'How to maintain FZ-S?'*.",
          bikeId: null
        };
      }

      let maintText = `Here is a custom maintenance checklist for your **${targetBike.brand} ${targetBike.name}**:\n\n`;
      maintText += `1. **Engine Oil**: Replace engine oil every **2,500 - 5,000 km** (refer to owner's manual). For the ${targetBike.name}, use high-quality oil to ensure optimal clutch and engine health.\n`;
      maintText += `2. **Drive Chain Care**: Clean, inspect, and lubricate the chain every **500 km** with specialized lube. Check and adjust chain slackness to safety limits.\n`;
      maintText += `3. **Air Filter**: Inspect every 5,000 km. Replace if clogged with fine dust to protect fuel-injection/carburetor systems.\n`;
      maintText += `4. **Braking Assemblies**: Check brake fluid level in reservoirs (DOT 4). Keep disc rotors clean from grease. Inspect brake pads/shoes for wear.\n`;
      maintText += `5. **Spark Plug**: Clean carbon build-up and verify gap clearances at every service intervals.\n\n`;
      
      maintText += `Would you like to troubleshoot a specific issue like engine vibrations, cold starts, or soft braking?`;
      return { response: maintText, bikeId: targetBike.id };
    }

    default: {
      let fallText = "I can help you with bike recommendations, comparing models, viewing specifications, or troubleshooting mechanical issues.\n\n";
      if (targetBike) {
        fallText += `Ask me something about the **${targetBike.name}**, such as:\n`;
        fallText += `* *'What is the price of ${targetBike.name}?'*\n`;
        fallText += `* *'What are the specs and power?'*\n`;
        fallText += `* *'How do I fix cold start issues on it?'*`;
      } else {
        fallText += "Try asking:\n";
        fallText += "* *'Recommend a sports bike under 2.5 lakhs'* \n";
        fallText += "* *'Compare Royal Enfield Classic 350 and Meteor 350'* \n";
        fallText += "* *'My bike has starting trouble, what should I do?'*";
      }
      return { response: fallText, bikeId: targetBike ? targetBike.id : null };
    }
  }
}

module.exports = {
  recommendBikes,
  diagnoseIssues,
  generateChatResponse
};
