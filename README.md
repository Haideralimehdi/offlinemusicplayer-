# 🎵 Offline Music Player

A modern Flutter-based Offline Music Player that allows users to play songs stored on their device without requiring an internet connection. The application also includes Firebase-based user management and a separate Flutter Web Admin Panel for managing users.

---

## 📱 Features

### User App
- 🎵 Play offline music from device storage
- ⏯ Play, Pause, Next & Previous controls
- 🔀 Shuffle and Repeat modes
- ❤️ Favorite songs support
- 📂 Create custom playlists
- ➕ Add or remove songs from playlists
- 🔍 Search songs instantly
- 👤 User Registration & Login using Firebase Authentication
- ✏ Edit profile information
- 💾 Local data storage using Hive
- 📱 Responsive and clean UI

---

## 🌐 Admin Panel (Flutter Web)

- 🔐 Secure Admin Login
- 📊 Dashboard with analytics
- 👥 Manage all registered users
- 🔄 Change user roles (Admin/User)
- 🗑 Delete users with confirmation dialog
- 📈 User Growth Chart
- 🥧 User Role Distribution Chart
- 🔥 Real-time Firebase Firestore integration

---

## 🛠 Technologies Used

- Flutter
- Dart
- GetX
- Firebase Authentication
- Cloud Firestore
- Hive Database
- On Audio Query
- Just Audio
- Audio Session
- Flutter Web
- FL Chart

---

## 📂 Project Structure

```
lib/
│
├── Models
├── Controllers
├── Views
├── Widgets
├── Services
├── Utils
└── Main.dart
```

---


# 📸 Screenshots


| Home | Player | Playlist |
|------|----------|------|
| <img width="738" height="1600" alt="WhatsApp Image 2026-06-12 at 4 58 06 PM" src="https://github.com/user-attachments/assets/39024e26-e533-4e2a-b76c-06c342bb9d4f" />| <img width="738" height="1600" alt="WhatsApp Image 2026-06-12 at 4 58 07 PM" src="https://github.com/user-attachments/assets/37c09f04-e02b-47de-aa59-e29b2ef3ec2c" />| <img width="738" height="1600" alt="WhatsApp Image 2026-06-12 at 4 58 08 PM (1)" src="https://github.com/user-attachments/assets/d6ccb7d8-fbb9-49b5-9f3f-b2d551131dac" />|

---


## 🚀 Installation

### Clone Repository

```bash
git clone https://github.com/yourusername/offline-music-player.git
```

### Navigate to Project

```bash
cd offline-music-player
```

### Install Packages

```bash
flutter pub get
```

### Run Application

```bash
flutter run
```

---

## Firebase Setup

1. Create a Firebase Project.
2. Enable Authentication (Email & Password).
3. Enable Cloud Firestore.
4. Download `google-services.json`.
5. Place it inside:

```
android/app/
```

6. Run the application.

---

## Dependencies

Some of the major packages used:

```yaml
get:
firebase_core:
firebase_auth:
cloud_firestore:
hive:
hive_flutter:
just_audio:
on_audio_query:
permission_handler:
fl_chart:
```

---

## Future Improvements

- Dark Mode
- Lyrics Support
- Recently Played
- Most Played Songs
- Equalizer
- Sleep Timer
- Folder-wise Music
- Backup & Restore Playlists
- Cloud Playlist Sync

---

## Author

**Haider Ali Mehdi**

Flutter Mobile Application Developer

---

## License

This project is developed for educational and learning purposes.
