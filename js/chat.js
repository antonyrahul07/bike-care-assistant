/**
 * BikeAI - Chat Page Controller (js/chat.js)
 */

document.addEventListener('DOMContentLoaded', () => {
  const stream = document.getElementById('chatMessagesStream');
  const inputField = document.getElementById('chatInputField');
  const sendBtn = document.getElementById('chatSendButton');
  const contextContainer = document.getElementById('activeContextContainer');
  const contextName = document.getElementById('activeContextName');
  const clearContextBtn = document.getElementById('clearContextBtn');
  
  // Chips
  const chipRecommend = document.getElementById('chipRecommend');
  const chipDiagnose = document.getElementById('chipDiagnose');
  const chipCompare = document.getElementById('chipCompare');

  let currentBikeId = null;
  let activeBikeName = "";

  // 1. Parse URL Parameter for Active Bike Context
  const urlParams = new URLSearchParams(window.location.search);
  const bikeUrlParam = urlParams.get('bike');

  // Initialize Chat
  async function init() {
    if (bikeUrlParam) {
      await setContext(bikeUrlParam);
      // Greet in context
      sendSystemGreeting(true);
    } else {
      // Generic Greet
      sendSystemGreeting(false);
    }
  }

  // Set the current bike focus context
  async function setContext(bikeId) {
    try {
      const response = await fetch(`/api/bikes/${bikeId}`);
      if (!response.ok) throw new Error('Bike not found');
      
      const bike = await response.json();
      currentBikeId = bike.id;
      activeBikeName = bike.name;
      
      // Update UI Banner
      contextName.textContent = bike.name;
      contextContainer.style.display = 'block';
    } catch (e) {
      console.error("Could not set active context:", e);
      clearContext();
    }
  }

  // Clear Context
  function clearContext() {
    currentBikeId = null;
    activeBikeName = "";
    contextContainer.style.display = 'none';
    appendMessage('bot', "Active bike focus cleared. I am now answering general questions.");
  }

  clearContextBtn.addEventListener('click', clearContext);

  // Simple Markdown Parser to translate backend markdown to styled HTML
  function formatMarkdown(text) {
    // Escape HTML to prevent XSS
    let clean = text
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;");

    // Bold formatting: **text**
    clean = clean.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
    
    // Bullet list formatting
    clean = clean.replace(/^\*\s+(.*)$/gm, '<li>$1</li>');
    clean = clean.replace(/^-\s+(.*)$/gm, '<li>$1</li>');

    // Simple Table Parsing: lines starting with "|"
    if (clean.includes('|')) {
      const lines = clean.split('\n');
      let tableHtml = '<table>';
      let inTable = false;
      let headerPassed = false;
      const parsedLines = [];

      for (let line of lines) {
        const trimmed = line.trim();
        if (trimmed.startsWith('|')) {
          inTable = true;
          // Skip divider lines like |:---|:---|
          if (trimmed.includes('---') || trimmed.includes(':--')) continue;

          const cells = trimmed.split('|')
            .map(c => c.trim())
            .filter((c, index, arr) => index > 0 && index < arr.length - 1);

          if (!headerPassed) {
            tableHtml += '<thead><tr>' + cells.map(c => `<th>${c}</th>`).join('') + '</tr></thead><tbody>';
            headerPassed = true;
          } else {
            tableHtml += '<tr>' + cells.map(c => `<td>${c}</td>`).join('') + '</tr>';
          }
        } else {
          if (inTable) {
            tableHtml += '</tbody></table>';
            parsedLines.push(tableHtml);
            tableHtml = '<table>';
            inTable = false;
            headerPassed = false;
          }
          parsedLines.push(line);
        }
      }

      if (inTable) {
        tableHtml += '</tbody></table>';
        parsedLines.push(tableHtml);
      }
      clean = parsedLines.join('\n');
    }

    // Convert double linebreaks to spacing paragraphs, single linebreaks to HTML break tags
    clean = clean.replace(/\n\n/g, '<p></p>');
    clean = clean.replace(/\n/g, '<br>');

    return clean;
  }

  // Appends a bubble to the stream
  function appendMessage(sender, text) {
    const bubble = document.createElement('div');
    bubble.className = `message ${sender}`;
    bubble.innerHTML = formatMarkdown(text);
    stream.appendChild(bubble);
    scrollToBottom();
    return bubble;
  }

  // Append a temporary typing indicator bubble
  function showTypingIndicator() {
    const bubble = document.createElement('div');
    bubble.className = 'message bot';
    bubble.id = 'typingBubble';
    bubble.innerHTML = `
      <div class="typing-indicator">
        <div class="typing-dot"></div>
        <div class="typing-dot"></div>
        <div class="typing-dot"></div>
      </div>
    `;
    stream.appendChild(bubble);
    scrollToBottom();
  }

  function removeTypingIndicator() {
    const bubble = document.getElementById('typingBubble');
    if (bubble) bubble.remove();
  }

  function scrollToBottom() {
    stream.scrollTop = stream.scrollHeight;
  }

  // Initial greeting
  async function sendSystemGreeting(hasContext) {
    showTypingIndicator();
    // Simulate minor network delay
    setTimeout(() => {
      removeTypingIndicator();
      if (hasContext) {
        appendMessage('bot', `Hello! I am your **BikeAI Assistant** 🏍️.\n\nI have locked onto your **${activeBikeName}**. How can I help you today? You can ask about:\n\n* **Specs/Features**: *'Show specifications and power'* \n* **Pricing**: *'What is the ex-showroom price?'* \n* **Diagnostics**: *'My engine has vibrations'* \n* **Maintenance**: *'Show service intervals'*`);
      } else {
        appendMessage('bot', "Hello! I am your **BikeAI Assistant** 🏍️.\n\nHow can I assist you with Indian motorcycles today?\n\n* **Need suggestions?** Click the **Recommend a Bike** chip or tell me your budget and usage.\n* **Have a breakdown?** Describe the symptoms (e.g. starting issues, brake squeals).\n* **Comparing?** Ask me to compare models like *'Compare Pulsar NS200 and KTM Duke 390'*.");
      }
    }, 400);
  }

  // Handles sending a user message
  async function handleSendMessage(customText) {
    const message = customText || inputField.value.trim();
    if (!message) return;

    // Clear input box
    if (!customText) inputField.value = '';

    // Render User message
    appendMessage('user', message);

    // Show AI typing status
    showTypingIndicator();

    try {
      // POST payload
      const response = await fetch('/api/ai/chat', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          message: message,
          bike_id: currentBikeId
        })
      });

      if (!response.ok) throw new Error('API server returned error');
      const data = await response.json();

      removeTypingIndicator();
      appendMessage('bot', data.response);

      // If AI detects a bike context change, update context in UI
      if (data.bikeId && data.bikeId !== currentBikeId) {
        await setContext(data.bikeId);
      }

    } catch (error) {
      console.error("Chat error:", error);
      removeTypingIndicator();
      appendMessage('bot', "⚠️ Sorry, I had trouble processing that request. Please make sure the node server is active.");
    }
  }

  // Event bindings
  sendBtn.addEventListener('click', () => handleSendMessage());
  inputField.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') handleSendMessage();
  });

  // Action chips click behaviors
  chipRecommend.addEventListener('click', () => {
    handleSendMessage("Recommend a bike for daily city use. My budget is 1.5 lakhs, and I ride about 20 km daily.");
  });

  chipDiagnose.addEventListener('click', () => {
    if (currentBikeId) {
      handleSendMessage(`Help me diagnose a cold starting problem with my ${activeBikeName}.`);
    } else {
      handleSendMessage("My Royal Enfield Classic 350 has heavy engine vibrations at high speeds. How do I fix it?");
    }
  });

  chipCompare.addEventListener('click', () => {
    handleSendMessage("Compare Royal Enfield Classic 350 vs KTM Duke 390");
  });

  // Fire up setup
  init();
});
