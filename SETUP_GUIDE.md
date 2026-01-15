# Complete Setup Guide for Life Client

This guide will walk you through setting up the Life Client application from scratch, including Firebase, local development environment, and deployment preparation.

## Table of Contents

1. [Initial Setup](#1-initial-setup)
2. [Firebase Configuration](#2-firebase-configuration)
3. [Database Setup](#3-database-setup)
4. [Local Development](#4-local-development)
5. [Testing Setup](#5-testing-setup)
6. [Production Deployment](#6-production-deployment)
7. [Troubleshooting](#7-troubleshooting)

---

## 1. Initial Setup

### 1.1 System Requirements

**Required Software:**
- Flutter SDK 3.7.0 or higher
- Dart SDK 3.7.0 or higher
- Git
- Node.js and npm (for Firebase Functions)

**Platform-Specific:**

**For macOS:**
```bash
# Install Homebrew if not installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Flutter via Homebrew
brew install --cask flutter

# Verify installation
flutter doctor
```

**For Windows:**
1. Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
2. Extract to `C:\src\flutter`
3. Add to PATH: `C:\src\flutter\bin`

**For Linux:**
```bash
# Download Flutter
cd ~
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH (add to ~/.bashrc or ~/.zshrc)
export PATH="$PATH:$HOME/flutter/bin"

# Verify installation
flutter doctor
```

### 1.2 IDE Setup

**Recommended: Visual Studio Code**

```bash
# Install VS Code
# macOS
brew install --cask visual-studio-code

# Linux
sudo snap install code --classic
```

**Required Extensions:**
1. Flutter (Dart-Code.flutter)
2. Dart (Dart-Code.dart-code)
3. Pubspec Assist (jeroen-meijer.pubspec-assist)
4. Flutter Riverpod Snippets (robert-brunhage.flutter-riverpod-snippets)

**Alternative: Android Studio**
- Download from https://developer.android.com/studio
- Install Flutter and Dart plugins

### 1.3 Clone the Repository

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/life_client.git
cd life_client

# Install dependencies
flutter pub get
```

---

## 2. Firebase Configuration

### 2.1 Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name (e.g., "life-client-dev")
4. Enable Google Analytics (optional)
5. Click "Create project"

### 2.2 Install Firebase CLI

```bash
# Install Firebase CLI globally
npm install -g firebase-tools

# Login to Firebase
firebase login

# Verify installation
firebase --version
```

### 2.3 Install FlutterFire CLI

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Add to PATH if needed
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Verify installation
flutterfire --version
```

### 2.4 Configure FlutterFire

```bash
# Navigate to project root
cd life_client

# Run FlutterFire configuration
flutterfire configure

# Follow the prompts:
# 1. Select your Firebase project
# 2. Select platforms (Android, iOS)
# 3. Choose Android package name: com.hatayiyasat.app
# 4. Choose iOS bundle ID: com.hatayiyasat.app
```

This will create:
- `lib/firebase_options.dart`
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

### 2.5 Enable Firebase Services

In Firebase Console, enable the following services:

**Authentication** (if needed in future):
1. Go to Authentication > Sign-in method
2. Enable Email/Password (optional)
3. Enable Google Sign-in (optional)

**Cloud Firestore**:
1. Go to Firestore Database
2. Click "Create database"
3. Choose "Start in test mode" for development
4. Select a location (e.g., `us-central1`)

**Firebase Storage**:
1. Go to Storage
2. Click "Get started"
3. Choose "Start in test mode" for development
4. Use same location as Firestore

**Firebase Messaging** (Push Notifications):
1. Go to Cloud Messaging
2. Click "Get started" (automatically enabled)

**Firebase Analytics**:
1. Go to Analytics > Dashboard
2. Automatically enabled if selected during project creation

**Firebase Crashlytics**:
1. Go to Crashlytics
2. Click "Enable Crashlytics"

**Firebase Remote Config**:
1. Go to Remote Config
2. Click "Get started"

---

## 3. Database Setup

### 3.1 Firestore Collections

Create the following collections in Firestore:

1. **places**
   ```javascript
   {
     "name": "Example Place",
     "category": "restaurant",
     "town": "Antakya",
     "address": "Example Address",
     "phone": "+90 555 555 5555",
     "active": true,
     "createdAt": Timestamp,
     "images": []
   }
   ```

2. **events**
   ```javascript
   {
     "title": "Example Event",
     "description": "Event description",
     "date": Timestamp,
     "location": "Event Location",
     "category": "cultural",
     "active": true
   }
   ```

3. **news**
   ```javascript
   {
     "title": "News Title",
     "content": "News content",
     "publishDate": Timestamp,
     "category": "local",
     "imageUrl": ""
   }
   ```

4. **jobs**
   ```javascript
   {
     "title": "Job Title",
     "company": "Company Name",
     "description": "Job description",
     "location": "Hatay",
     "type": "full-time",
     "publishDate": Timestamp
   }
   ```

5. **history**
   ```javascript
   {
     "title": "Historical Place",
     "description": "Description",
     "images": [],
     "location": GeoPoint,
     "period": "Ottoman",
     "active": true
   }
   ```

6. **developers**
   ```javascript
   {
     "name": "Developer Name",
     "role": "Flutter Developer",
     "github": "github_username",
     "linkedin": "linkedin_url",
     "active": true
   }
   ```

7. **agencies**
   ```javascript
   {
     "name": "Agency Name",
     "type": "government",
     "contact": "+90 555 555 5555",
     "website": "https://example.com",
     "active": true
   }
   ```

### 3.2 Security Rules

**Firestore Rules** (`firestore.rules`):

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Helper functions
    function isSignedIn() {
      return request.auth != null;
    }

    // Public read access, authenticated write
    match /{document=**} {
      allow read: if true; // Public read for now
      allow write: if isSignedIn();
    }

    // User submissions (forms)
    match /place_requests/{requestId} {
      allow create: if true; // Anyone can submit
      allow read, update, delete: if isSignedIn();
    }

    match /project_requests/{requestId} {
      allow create: if true;
      allow read, update, delete: if isSignedIn();
    }
  }
}
```

**Storage Rules** (`storage.rules`):

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {

    // Public read, authenticated write
    match /{allPaths=**} {
      allow read: if true;
      allow write: if request.auth != null;
    }

    // Image uploads (with size limit)
    match /images/{imageId} {
      allow read: if true;
      allow write: if request.auth != null
                   && request.resource.size < 5 * 1024 * 1024 // 5MB limit
                   && request.resource.contentType.matches('image/.*');
    }
  }
}
```

Deploy rules:
```bash
firebase deploy --only firestore:rules
firebase deploy --only storage:rules
```

### 3.3 Firebase Remote Config

Set up default configuration:

1. Go to Firebase Console > Remote Config
2. Add parameters:

```json
{
  "maintenance_mode": false,
  "min_app_version": "8.0.0",
  "force_update": false,
  "feature_flags": {
    "enable_user_reviews": true,
    "enable_push_notifications": true,
    "enable_dark_mode": true
  }
}
```

---

## 4. Local Development

### 4.1 Environment Configuration

**For Firebase Functions (Optional):**

If using Cloud Functions:

```bash
cd functions

# Copy example env file
cp .env.example .env

# Edit .env with your credentials
nano .env
```

Example `.env`:
```bash
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/dbname
API_KEY=your_api_key_here
```

### 4.2 Generate Code

Run build_runner to generate necessary code:

```bash
# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Generate code
dart run build_runner build --delete-conflicting-outputs

# Or watch for changes during development
dart run build_runner watch --delete-conflicting-outputs
```

### 4.3 Run the App

**Android:**
```bash
# List available devices
flutter devices

# Run on connected device
flutter run

# Run on specific device
flutter run -d <device_id>

# Run in debug mode with hot reload
flutter run --debug
```

**iOS:**
```bash
# Install CocoaPods dependencies
cd ios
pod install
cd ..

# Run on simulator
flutter run

# Run on physical device (requires Apple Developer account)
flutter run -d <device_id>
```

### 4.4 Development Tips

**Hot Reload:**
- Press `r` in terminal for hot reload
- Press `R` for hot restart
- Press `q` to quit

**Debugging:**
```bash
# Enable verbose logging
flutter run --verbose

# Clear cache
flutter clean
flutter pub get
```

**Common Scripts:**

Add to `pubspec.yaml`:
```yaml
scripts:
  build: dart run build_runner build --delete-conflicting-outputs
  watch: dart run build_runner watch --delete-conflicting-outputs
  clean: flutter clean && flutter pub get
  analyze: flutter analyze
  format: dart format .
```

Run with:
```bash
flutter pub run <script_name>
```

---

## 5. Testing Setup

### 5.1 Install Maestro (UI Testing)

```bash
# Install Maestro CLI
curl -Ls 'https://get.maestro.mobile.dev' | bash

# Verify installation
maestro --version
```

### 5.2 Run UI Tests

```bash
# Build the app first
flutter build ios --simulator  # For iOS
flutter build apk             # For Android

# Run tests
cd maestro
./run_tests.sh smoke
```

### 5.3 Unit Testing (Future)

Create test files in `test/` directory:

```dart
// test/features/home/home_view_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:lifeclient/features/main/home/provider/home_view_model.dart';

void main() {
  group('HomeViewModel Tests', () {
    test('should initialize with empty state', () {
      // Test implementation
    });
  });
}
```

Run tests:
```bash
flutter test
```

---

## 6. Production Deployment

### 6.1 Android Release Build

**Step 1: Generate Keystore**

```bash
keytool -genkey -v -keystore ~/keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload
```

**Step 2: Create key.properties**

```bash
# Copy example
cp android/key.properties.example android/key.properties

# Edit with your values
nano android/key.properties
```

```properties
storePassword=YOUR_PASSWORD
keyPassword=YOUR_PASSWORD
keyAlias=upload
storeFile=/Users/yourname/keystore.jks
```

**Step 3: Build Release APK**

```bash
flutter build apk --release
```

**Step 4: Build App Bundle (for Play Store)**

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

### 6.2 iOS Release Build

**Step 1: Open Xcode**

```bash
open ios/Runner.xcworkspace
```

**Step 2: Configure Signing**

1. Select Runner in Project Navigator
2. Go to "Signing & Capabilities"
3. Select your Team
4. Choose provisioning profile

**Step 3: Build Archive**

```bash
# Build IPA
flutter build ipa --release

# Or use Xcode:
# Product > Archive
```

**Step 4: Upload to App Store**

Use Xcode Organizer or Transporter app

### 6.3 Firebase Production Setup

**Create Production Project:**

1. Create separate Firebase project for production
2. Run `flutterfire configure` again
3. Select production project
4. Update security rules to be more restrictive

**Production Firestore Rules:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // No public writes in production
    match /{document=**} {
      allow read: if true;
      allow write: if false; // Use Cloud Functions for writes
    }

    // User submissions
    match /place_requests/{requestId} {
      allow create: if true;
      allow read: if false;
    }
  }
}
```

---

## 7. Troubleshooting

### Common Issues

**Issue: Firebase not configured**
```bash
Error: No Firebase App '[DEFAULT]' has been created
```
**Solution:**
```bash
flutterfire configure
flutter clean && flutter pub get
```

**Issue: Build runner fails**
```bash
Error: Could not resolve dependency
```
**Solution:**
```bash
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

**Issue: iOS CocoaPods error**
```bash
Error: pod install failed
```
**Solution:**
```bash
cd ios
rm Podfile.lock
rm -rf Pods
pod install
cd ..
```

**Issue: Android signing fails**
```bash
Error: key.properties not found
```
**Solution:**
```bash
cp android/key.properties.example android/key.properties
# Edit with your keystore details
```

**Issue: Firebase permissions error**
```bash
Error: Missing permissions to access Firestore
```
**Solution:**
- Check Firebase Console > Firestore > Rules
- Ensure rules allow read access
- For testing, temporarily use test mode rules

### Getting Help

If you encounter issues not listed here:

1. Check [GitHub Issues](https://github.com/YOUR_USERNAME/life_client/issues)
2. Review [Flutter Documentation](https://flutter.dev/docs)
3. Check [Firebase Documentation](https://firebase.google.com/docs)
4. Open a new issue with:
   - Error message
   - Steps to reproduce
   - Flutter/Dart version
   - Platform (iOS/Android)

---

## Next Steps

After completing this setup:

1. ✅ Read [CONTRIBUTING.md](CONTRIBUTING.md) if you plan to contribute
2. ✅ Explore the codebase structure
3. ✅ Try making a small change and running the app
4. ✅ Set up your development workflow
5. ✅ Join the community discussions

---

**Happy Coding! 🎉**
