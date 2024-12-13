# Server README

## Overview
This is a Node.js server that supports both HTTP requests for login and WebSocket connections for real-time communication. It uses Express for handling HTTP requests and the `ws` library for WebSocket communication.

---

## Features
- **Login API**: Handles user authentication through a POST request.
- **WebSocket Server**: Supports real-time communication for connected clients with status updates and message delivery.
- **Typing Status**: Real-time "User is typing..." status for connected clients, which is automatically updated to a message when available.
- **Message Synchronization**: Uses unique message IDs to link typing status to specific messages, ensuring smooth transitions from status to message.

---

## Prerequisites
Make sure you have the following installed:

- **Node.js**: Version 14 or later
- **npm**: Installed with Node.js

---

## Installation

1. Clone this repository:

   ```bash
   git clone <repository_url>
   cd <repository_directory>
   ```

2. Install the required dependencies:

   ```bash
   npm install express body-parser ws
   ```

---

## Usage

1. Start the server:

   ```bash
   node server.js
   ```

   The server will start at `http://localhost:3001` on iOS, `http://10.0.2.2:3001` on Android.

2. **Login API**:
   - **Endpoint**: `POST /login`
   - **Input**:
     ```json
     {
       "username": "user",
       "password": "password"
     }
     ```
   - **Response (on success)**:
     ```json
     {
       "success": true,
       "token": "auth_token"
     }
     ```

3. **WebSocket**:
   - **Connection URL**: `ws://localhost:3001` on iOS, `ws://10.0.2.2:3001` on Android.
   - **Message Types**:  
     - **Typing Status**: When a user is typing, the server sends a status update.
     - **Message**: The actual message content sent after typing is complete.
   
   **Example WebSocket messages from server:**
   
   **Status Message:**
   ```json
   {
     "id": 1696329456254,
     "type": "status",
     "sender": "User",
     "data": "User is typing..."
   }
   ```
   
   **Message Update:**
   ```json
   {
     "id": 1696329456254,
     "type": "message",
     "sender": "User",
     "data": "Hello, this is the actual message!"
   }
   ```

   **How It Works**:
   - When a client sends a message to the server, the server immediately sends a **status** message with `type: "status"` and a unique `id`.
   - After a short delay (default is 2 seconds), the server sends the **actual message** with the same `id` to update the client's interface.
   
   **Example message from client:**
   ```
   Hello, WebSocket!
   ```
   
   **Example response from server:**
   - Status: "User is typing..."
   - Message: "I read your message: Hello, WebSocket!"

---

## File Structure
- **server.js**: Main server file where HTTP and WebSocket logic is implemented.

---

## Libraries Used
- [**Express**](https://expressjs.com/): For HTTP request handling.
- [**body-parser**](https://www.npmjs.com/package/body-parser): For parsing JSON request bodies.
- [**ws**](https://www.npmjs.com/package/ws): For WebSocket support.

---

## Troubleshooting

1. **Server not starting**:
   - Ensure Node.js is installed.
   - Verify no other process is using port 3001.

2. **Cannot connect to WebSocket**:
   - Check the WebSocket URL (`ws://localhost:3001`).
   - Ensure the server is running.

3. **Login not working**:
   - Ensure the username and password match the valid credentials defined in `server.js`.

4. **Duplicate "User is typing..." messages**:
   - The server now only sends one "User is typing..." status per client.
   - If multiple typing events are detected, the system updates the existing status instead of sending new ones.

5. **Message delays or missing messages**:
   - Check if `id` is being correctly generated for each message.
   - Verify that `id` is consistent for both "status" and "message" updates.

---

## Future Enhancements
- **Secure WebSocket (wss://) support**: Add support for SSL/TLS.
- **Dynamic user authentication**: Replace static credentials with a database for more secure user management.
- **Real-time Typing Enhancements**: Add logic for "user has stopped typing" notifications.

---

## License
This project is licensed under the MIT License. See the LICENSE file for details.

