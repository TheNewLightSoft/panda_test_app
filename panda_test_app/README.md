# 📱 Panda Test App

## 📝 **Overview**
This is a Flutter application with a robust, scalable architecture following **Clean Architecture** principles. The app provides user authentication, real-time chat functionality, and interactive UI components. It is designed to support both **local development** and **server integration** via WebSocket and HTTP API.

The project structure has been thoughtfully designed to demonstrate a clean and maintainable approach. Some folders and files are intentionally left empty to showcase the architecture and possible areas for future expansion.

---

## 🚀 **Features**
- **Login**: Secure user authentication with token storage.
- **Real-time Chat**: Bi-directional messaging using WebSockets.
- **Typing Indicator**: Shows real-time "user is typing" status.
- **Clean Architecture**: Well-structured, maintainable codebase.
- **Modular File Structure**: Clear separation of responsibilities.

---

## 📂 **Project Structure**
```
📂 lib/
 ┣ 📂 app/
 ┃ ┣ 📂 cubits/
 ┃ ┃ ┣ 📂 chat/
 ┃ ┃ ┃ ┣ 📜 chat_cubit.dart        
 ┃ ┃ ┃ ┣ 📜 chat_state.dart        
 ┃ ┃ ┃ ┗ 📜 bloc.dart   
 ┃ ┃ ┣ 📂 login/
 ┃ ┃ ┃ ┣ 📜 login_cubit.dart        
 ┃ ┃ ┃ ┣ 📜 login_state.dart        
 ┃ ┃ ┃ ┗ 📜 bloc.dart         
 ┃ ┣ 📂 screens/
 ┃ ┃ ┣ 📜 chat_screen.dart        
 ┃ ┃ ┗ 📜 login_screen.dart  
 ┃ ┣ 📂 widgets/
 ┃ ┃ ┣ 📜 circular_user_avatar.dart        
 ┃ ┃ ┗ 📜 message_bubble.dart  
 ┣ 📂 core/
 ┃ ┣ 📂 client/
 ┃ ┃ ┗ 📜 dio_client.dart        
 ┃ ┃ 📂 constants/       
 ┃ ┣ 📂 enums/
 ┃ ┃ ┗ 📜 message_type_enum.dart        
 ┃ ┣ 📂 service_locator/
 ┃ ┃ ┗ 📜 di.dart        
 ┃ ┣ 📂 utils/
 ┃ ┃ ┗ 📜 theme.dart   
 ┣ 📂 data/
 ┃ ┣ 📂 models/
 ┃ ┃ ┣ 📂 chat/
 ┃ ┃ ┃ ┣ 📜 message_model.dart            
 ┃ ┃ ┃ ┗ 📜 message_model.g.dart   
 ┃ ┃ ┣ 📂 login/
 ┃ ┃ ┃ ┣ 📜 login_request_model.dart        
 ┃ ┃ ┃ ┣ 📜 login_request_model.g.dart  
 ┃ ┃ ┃ ┣ 📜 login_response_model.dart         
 ┃ ┃ ┃ ┗ 📜 login_response_model.g.dart         
 ┃ ┃ 📂 repositories/     
 ┃ ┃ ┣ 📜 chat_repository_impl.dart     
 ┃ ┃ ┗ 📜 login_repository_impl.dart  
 ┃ ┣ 📂 services/
 ┣ 📂 domain/
 ┃ ┣ 📂 entities/
 ┃ ┃ ┣ 📜 message_entity.dart            
 ┃ ┃ ┗ 📜 user_session_entity.g.dart       
 ┃ ┃ 📂 repositories/     
 ┃ ┃ ┣ 📜 chat_repository.dart     
 ┃ ┃ ┗ 📜 login_repository.dart  
 ┃ ┣ 📂 use_cases/
 ┃ ┃ ┣ 📜 auth_service.dart     
 ┃ ┃ ┗ 📜 chat_service.dart
 ┣ 📂 gen/
 ┃ ┗ 📜 assets.gen.dart
 ┗ 📜 main.dart
```

> **Note:** Some folders are intentionally left empty to illustrate future expansion for scalability and flexibility in the architecture.

---

## 📦 **Setup Instructions**

### 1️⃣ **Install Dependencies**
```bash
flutter pub get
```

### 2️⃣ **Run the Server**
Make sure you have Node.js installed. The **server folder** is located at the same level as the main project folder. To run the server, use:
```bash
cd ../server
npm install
node server.js
```
The server will run at `http://localhost:3001`.

### 3️⃣ **Run the Application**
To run the app on an emulator or device:
```bash
flutter run
```

---

## 📚 **Commands**
- **Generate files (model, bloc, etc.)**:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

---

## ⚙️ **Design Principles**
### **1️⃣ Clean Architecture**
The architecture follows the **Clean Architecture** principles. It ensures separation of concerns, modularity, and testability.

### **2️⃣ Scalable File Structure**
Each feature is self-contained within its folder. This makes it easy to expand features, such as adding a new screen, repository, or use case.

### **3️⃣ Why Empty Files?**
Some folders and files are included as placeholders to demonstrate the intended file structure. This shows how the project could evolve as new features are added.

---

## 📋 **File Descriptions**
| **File**             | **Description**                                  |
|---------------------|--------------------------------------------------|
| **cubit/**           | Business logic for login & chat                  |
| **data/**            | Data layer (models, repositories)                |
| **domain/**          | Domain layer (entities, repositories, use cases) |
| **screens/**         | UI screens for the app                          |
| **widgets/**         | Custom reusable UI components                    |
| **gen/assets.gen.dart** | Asset references generated automatically    |
| **main.dart**        | Entry point for the Flutter application          |

---

## 🔧 **Development Tools**
- **Dart**: Language for writing Flutter applications.
- **Flutter**: Cross-platform mobile app framework.
- **Node.js**: Used to run the backend server.
- **WebSocket**: Real-time communication with the server.

---

## 📜 **API Endpoints**
| **Method** | **Endpoint** | **Description**         |
|------------|--------------|-------------------------|
| **POST**   | `/login`      | Login with credentials  |
| **WebSocket** | `/`       | Real-time chat updates  |

---

## ❓ **Troubleshooting**
- **Server not starting?**
  - Ensure Node.js is installed.
  - Check if another process is using port 3001.

- **WebSocket not connecting?**
  - Ensure the server is running.
  - Check WebSocket URL (`ws://localhost:3001`).

- **Login not working?**
  - Check the credentials in the `server.js` file.

---

## 🔮 **Future Enhancements**
- **Database integration**: Replace static user data with a real database.
- **Push notifications**: Real-time notifications for new messages.
- **Secure WebSocket (wss://)**: Add SSL/TLS support for secure communication.

---

## 📜 **License**
This project is licensed under the MIT License. See the LICENSE file for details.

---

🚀 **Happy Coding!**

