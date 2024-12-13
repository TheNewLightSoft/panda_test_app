const express = require('express');
const bodyParser = require('body-parser');
const WebSocket = require('ws');
const http = require('http');

// Create Express application and HTTP server
const app = express();
const server = http.createServer(app);

// Create WebSocket server using the same HTTP server
const wss = new WebSocket.Server({ server });

// Middleware for parsing JSON
app.use(bodyParser.json());

// Static credentials for login demonstration
const validUsername = 'user';
const validPassword = 'password';

// Login API
app.post('/login', (req, res) => {
  const { username, password } = req.body;

  if (username === validUsername && password === validPassword) {
    const token = 'auth_token';
    res.json({ success: true, token });
  } else {
    res.status(401).json({ success: false, message: '\nValid username: user\nValid password: password' });
  }
});

// Store active typing statuses and message queues
const activeTypingStatuses = new Map(); // Tracks typing status { ws: number of pending messages }

wss.on('connection', (ws) => {
  console.log('✅ Client connected via WebSocket');
  
  ws.on('message', (message) => {
    const messageId = Date.now();
    const messageString = message.toString();

    console.log('📩 Received raw message from client:', messageString);

    try {
      const parsedMessage = JSON.parse(messageString);
      console.log('📩 Parsed message from client:', parsedMessage);

      if (parsedMessage.type === 'message') {
        // Add pending message to the client's queue
        if (!activeTypingStatuses.has(ws)) {
          activeTypingStatuses.set(ws, 0);
        }
        activeTypingStatuses.set(ws, activeTypingStatuses.get(ws) + 1);

        const typingStatusMessage = JSON.stringify({
          id: messageId,
          type: 'status',
          sender: 'Server',
          data: 'User is typing...'
        });

        ws.send(typingStatusMessage);
        console.log('📤 Sent typing status message to client:', typingStatusMessage);

        // Simulate message delay for 1000 ms before sending the actual message
        setTimeout(() => {
          const serverMessage = {
            id: messageId + 1, // Unique ID for the server message
            type: 'message',
            sender: 'Server',
            data: `I read your message: ${parsedMessage.data}`
          };

          ws.send(JSON.stringify(serverMessage));
          console.log('📤 Sent message from server to client:', serverMessage);

          // Decrement the pending message count
          activeTypingStatuses.set(ws, activeTypingStatuses.get(ws) - 1);
          
          // Remove typing status only if there are no pending messages
          if (activeTypingStatuses.get(ws) === 0) {
            activeTypingStatuses.delete(ws);
            const typingStatusRemoved = {
              id: messageId + 2,
              type: 'status',
              sender: 'Server',
              data: 'Typing stopped'
            };
            ws.send(JSON.stringify(typingStatusRemoved));
            console.log('📤 Sent "Typing stopped" status to client:', typingStatusRemoved);
          }
        }, 1000);
      }
    } catch (error) {
      console.error('❌ Error parsing message:', error);
      ws.send(JSON.stringify({ error: 'Invalid message format' }));
    }
  });

  ws.on('close', () => {
    console.log('❌ Client disconnected');
    activeTypingStatuses.delete(ws);
  });
});

// Start the server on port 3001
server.listen(3001, () => {
  console.log('🚀 Server running at http://localhost:3001');
});
