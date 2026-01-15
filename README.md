# Hatayi Yasat

<div align="center">

**A comprehensive Flutter application for discovering local places, events, news, and community resources in Hatay, Turkey.**

[![Flutter](https://img.shields.io/badge/Flutter-3.7.0+-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?logo=firebase)](https://firebase.google.com)
[![Riverpod](https://img.shields.io/badge/State-Riverpod-00A7E1)](https://riverpod.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

[Features](#-features) • [Tech Stack](#-tech-stack) • [Getting Started](#-getting-started) • [Architecture](#-architecture) • [Contributing](#-contributing)

### 📱 Download the App

- [![Google Play](https://img.shields.io/badge/Google_Play-414141?style=for-the-badge&logo=google-play&logoColor=white)](https://play.google.com/store/apps/details?id=com.hatayiyasat.app&hl=tr)
- [![App Store](https://img.shields.io/badge/App_Store-0D96F6?style=for-the-badge&logo=app-store&logoColor=white)](https://apps.apple.com/us/app/hatay%C4%B1-ya%C5%9Fat/id6465691080)
- [![Instagram](https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://www.instagram.com/hatayiyasat/)

</div>

---

## 📱 About

**Hatay İyasat** (Life Client) is a mobile application designed to help residents and visitors discover and engage with local businesses, events, historical sites, and community resources in Hatay province, Turkey. The app provides a comprehensive directory of places, real-time event information, news updates, job listings, and tourism information.

### Key Highlights

- 🏪 **Local Directory**: Browse restaurants, cafes, shops, and services across Hatay
- 📍 **Interactive Maps**: Google Maps integration for location discovery
- 📰 **News & Jobs**: Stay updated with local news and employment opportunities
- 🎉 **Events**: Discover upcoming events and cultural activities
- 🏛️ **History & Tourism**: Explore historical sites and tourist attractions
- 🌐 **Multi-language**: Turkish and English language support
- 🎨 **Modern UI**: Material 3 design with light/dark theme support

---

## ✨ Features

### Core Features

- **Place Discovery**
  - Search and filter local businesses by category and district
  - View detailed information including contact details, hours, and photos
  - Save favorite places for quick access
  - Share places with friends

- **Events & Activities**
  - Browse upcoming local events
  - Add events to calendar
  - Get event notifications
  - Filter events by category

- **News & Jobs**
  - Local news updates
  - Job listings and opportunities
  - Category-based filtering
  - Detailed job descriptions

- **Historical Memory**
  - Archive of historical sites and photos
  - Interactive historical content
  - Photo galleries
  - Educational information

- **User Contributions**
  - Submit new place requests
  - Report issues or updates
  - Request scholarships
  - Submit project proposals

### Additional Features

- 🗺️ Google Maps integration with custom markers
- 🔔 Push notifications for updates
- 📊 Firebase Analytics tracking
- 💾 Offline caching with Hive
- 🌍 Localization (Turkish/English)
- 📱 Responsive design for all screen sizes
- 🎯 Advanced search and filtering
- 🖼️ Image compression and optimization
- 📄 PDF document viewing

---

## 🛠️ Tech Stack

### Framework & Language
- **Flutter**: 3.7.0+
- **Dart**: 3.7.0+

### State Management
- **Riverpod**: 3.0.0-dev.17 (with code generation)
- **Riverpod Annotation**: For declarative state management

### Backend & Services
- **Firebase Core**: 3.9.0
- **Cloud Firestore**: Real-time database
- **Firebase Storage**: Image and file storage
- **Firebase Analytics**: User analytics
- **Firebase Crashlytics**: Crash reporting
- **Firebase Messaging**: Push notifications
- **Firebase Remote Config**: Dynamic configuration
- **Cloud Functions**: Serverless backend

### Navigation & Routing
- **GoRouter**: 16.2.0 with code generation
- **GoRouter Builder**: Declarative routing

### UI & Design
- **Google Fonts**: Custom typography
- **Material 3**: Modern design system
- **Responsive Framework**: Multi-screen support
- **Lottie**: Animated illustrations
- **Shimmer**: Loading animations
- **Carousel Slider**: Image carousels

### Maps & Location
- **Google Maps Flutter**: 2.6.1
- **Permission Handler**: Location permissions

### Localization
- **Easy Localization**: 3.0.1
- Supported languages: Turkish (tr), English (en)

### Media & Files
- **Image Picker**: Photo selection
- **Image Cropper**: Image editing
- **Flutter Image Compress**: Image optimization
- **File Picker**: Document selection
- **Syncfusion PDF Viewer**: PDF viewing

### Local Storage
- **Hive**: Fast local database
- **Shared Preferences**: Key-value storage

### Networking & Utilities
- **Cached Network Image**: Image caching
- **Connectivity Plus**: Network status
- **URL Launcher**: External links
- **Share Plus**: Content sharing
- **Kartal**: Utility extensions

### Testing
- **Maestro**: Automated UI testing
- **Very Good Analysis**: Code quality linting

### Shared Library
- **life_shared**: Custom shared package (v5.4.2)
  - Repository: [VB-CORE/life_shared](https://github.com/VB-CORE/life_shared.git)

---

## 🏗️ Architecture

The project follows a **feature-first architecture** with clear separation of concerns:

```
lib/
├── core/                    # Core functionality
│   ├── dependency/         # Dependency injection (GetIt)
│   ├── init/              # App initialization
│   └── service/           # Core services
│
├── features/               # Feature modules
│   ├── main/              # Main app features
│   │   ├── home/         # Home screen
│   │   ├── event/        # Events listing
│   │   ├── news_jobs/    # News & jobs
│   │   ├── history/      # Historical content
│   │   └── settings/     # App settings
│   │
│   ├── details/           # Detail views
│   │   ├── place/        # Place details
│   │   ├── event/        # Event details
│   │   └── news/         # News details
│   │
│   ├── sub_feature/       # Supporting features
│   │   ├── favorite/     # Favorites management
│   │   ├── filter_and_search/  # Search & filtering
│   │   ├── forms/        # User submission forms
│   │   ├── developers/   # Developer info
│   │   └── map_picker/   # Map selection
│   │
│   ├── tourism/           # Tourism features
│   ├── chain_store/       # Chain stores
│   └── splash/            # Splash screen
│
├── product/                # Shared product code
│   ├── init/              # Initialization logic
│   ├── model/             # Data models
│   ├── navigation/        # Routing configuration
│   ├── widget/            # Reusable widgets
│   ├── utility/           # Helper utilities
│   ├── package/           # Custom packages
│   └── generated/         # Generated code
│
└── sub_feature/            # Standalone features
    ├── advertisement_board/
    └── notification_navigate/
```

### Design Patterns

- **MVVM Pattern**: Each feature follows Model-View-ViewModel
- **Provider Pattern**: Riverpod for state management
- **Repository Pattern**: Data layer abstraction
- **Dependency Injection**: GetIt for service locator
- **Code Generation**: Build runner for boilerplate reduction

### Feature Structure

Each feature typically contains:
```
feature_name/
├── provider/              # Riverpod providers & state
│   ├── feature_provider.dart
│   └── feature_state.dart
├── view/                  # UI components
│   ├── feature_view.dart
│   ├── widget/           # Feature-specific widgets
│   └── mixin/            # View mixins
└── model/                 # Feature models (if needed)
```

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK**: Version 3.7.0 or higher
  ```bash
  flutter --version
  # Verify installation
  flutter doctor
  ```

- **Dart SDK**: Version 3.7.0 or higher (comes with Flutter)

- **Node.js and npm**: For Firebase Functions and Firebase CLI
  ```bash
  node --version  # Should be 18+ recommended
  npm --version
  ```

- **Firebase CLI**: For Firebase configuration
  ```bash
  npm install -g firebase-tools
  firebase --version
  # Login to Firebase (required before setup)
  firebase login
  ```

- **FlutterFire CLI**: For Firebase project setup
  ```bash
  dart pub global activate flutterfire_cli
  # Add to PATH if needed (add to ~/.bashrc or ~/.zshrc)
  export PATH="$PATH:$HOME/.pub-cache/bin"
  flutterfire --version
  ```

- **Platform-specific tools**:
  - **For iOS**: 
    - Xcode 14+ 
    - CocoaPods (install with: `sudo gem install cocoapods`)
    - Verify: `pod --version`
  - **For Android**: 
    - Android Studio with Android SDK 24+
    - Android SDK Command-line Tools

### Installation

#### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/life_client.git
cd life_client
```

#### 2. Install Dependencies

```bash
flutter pub get
```

#### 3. 🔥 Firebase Setup (REQUIRED)

**IMPORTANT**: This project requires Firebase. You must create your own Firebase project and configure it.

##### Step 3.1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project (or use existing)
3. Enable the following Firebase services:
   - **Cloud Firestore** (Database)
   - **Firebase Storage** (File storage)
   - **Firebase Analytics** (Optional but recommended)
   - **Firebase Crashlytics** (Optional but recommended)
   - **Firebase Messaging** (For push notifications)
   - **Firebase Remote Config** (For dynamic configuration)
   - **Cloud Functions** (For backend logic)

##### Step 3.2: Login to Firebase (Required)

Before configuring FlutterFire, make sure you're logged in:

```bash
firebase login
```

This will open a browser window for authentication. After successful login, you can proceed.

##### Step 3.3: Configure FlutterFire

Run the FlutterFire configuration command:

```bash
flutterfire configure
```

This will:
- Create/update `lib/firebase_options.dart`
- Generate `android/app/google-services.json`
- Generate `ios/Runner/GoogleService-Info.plist`

**Select your platforms**: Android, iOS (or both)

**Note**: If you haven't logged in to Firebase CLI, run `firebase login` first.

##### Step 3.4: Verify Firebase Files

Ensure these files were created:
- ✅ `lib/firebase_options.dart`
- ✅ `android/app/google-services.json`
- ✅ `ios/Runner/GoogleService-Info.plist`

**Note**: These files contain your Firebase configuration and are gitignored for security.

**Verification**:
```bash
# Check if files exist
ls lib/firebase_options.dart
ls android/app/google-services.json
ls ios/Runner/GoogleService-Info.plist
```

##### Step 3.5: Firestore Database Setup

1. In Firebase Console, go to **Firestore Database**
2. Create the following collections:
   - `places` - For local places/businesses
   - `events` - For events
   - `news` - For news articles
   - `jobs` - For job listings
   - `history` - For historical content
   - `developers` - For developer information
   - `agencies` - For special agencies

3. **Set Security Rules** (Important!):
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       // Read access for authenticated users
       match /{document=**} {
         allow read: if request.auth != null;
         allow write: if false; // Disable public writes
       }
     }
   }
   ```

4. **Add sample data** (optional): You can add test documents to each collection

##### Step 3.6: Firebase Storage Setup

1. In Firebase Console, go to **Storage**
2. Set up Storage rules:
   ```javascript
   rules_version = '2';
   service firebase.storage {
     match /b/{bucket}/o {
       match /{allPaths=**} {
         allow read: if request.auth != null;
         allow write: if request.auth != null;
       }
     }
   }
   ```

#### 4. Configure Firebase Functions Environment Variables

If using Cloud Functions, you need to configure MongoDB connection:

**For Local Development:**

1. Create `.env` file in `functions/` directory:
```bash
cd functions
cp .env.example .env
```

2. Edit `.env` and add your MongoDB connection string:
```env
MONGODB_URI=your_mongodb_connection_string_here
```

3. Install dependencies:
```bash
npm install
cd ..
```

**For Production:**

Use Firebase Functions config (recommended):
```bash
firebase functions:config:set mongo.uri="your_mongodb_connection_string_here"
```

**Important**: 
- Never commit `.env` files to version control
- The `.env` file is already in `.gitignore`
- Use `.env.example` as a template
- For production, prefer Firebase Functions config over environment files

#### 5. Android Signing Setup (For Release Builds)

Create `android/key.properties`:

```properties
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=YOUR_KEY_ALIAS
storeFile=PATH_TO_YOUR_KEYSTORE_FILE
```

**For development**: You can skip this and use debug signing

#### 6. Generate Code

This project uses code generation for models, localization, and routing. Generate all necessary code:

**Option 1: Generate everything at once (Recommended)**
```bash
flutter pub run general
# This runs: build_runner + localization generation
```

**Option 2: Generate separately**
```bash
# Generate models and providers (build_runner)
dart run build_runner build --delete-conflicting-outputs

# Generate localization keys
flutter pub run lang
```

**What gets generated:**
- Model classes (JSON serialization)
- Riverpod providers
- GoRouter routes
- Localization keys (`locale_keys.g.dart`)
- Asset references

**Note**: If you modify models or add new translations, re-run code generation.

#### 7. Run the App

**For Android**:
```bash
flutter run
```

**For iOS**:
```bash
# First time setup: Install CocoaPods dependencies
cd ios
pod install
cd ..

# Run the app
flutter run
```

**Note**: If you encounter CocoaPods issues:
```bash
# Update CocoaPods
sudo gem install cocoapods
pod repo update

# Clean and reinstall
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
```

**For a specific device**:
```bash
flutter devices  # List available devices
flutter run -d <device_id>
```

#### 8. Firebase Emulator Setup (Optional - For Local Development)

To use Firebase emulators with sample data:

1. **Import example data to emulator format**:
   ```bash
   flutter pub run emulatorImport
   ```
   This converts `data/example_scheme.json` to Firebase emulator format.

2. **Start Firebase emulators**:
   ```bash
   flutter pub run emulator
   ```
   This starts all Firebase emulators (Auth, Firestore, Storage, Functions) with the imported data.

3. **Configure app to use emulators** (if needed):
   - The app should automatically connect to emulators when running in debug mode
   - Check `lib/product/init/application_init.dart` for emulator configuration

**Note**: 
- Emulator data is saved automatically when you stop the emulator (`--export-on-exit`)
- To reset data, delete `emulator-data/` folder and re-import
- See [data/README.md](data/README.md) for more details

#### 9. Verify Installation

After completing all setup steps, verify everything works:

```bash
# 1. Check Flutter setup
flutter doctor

# 2. Verify dependencies
flutter pub get

# 3. Generate code (if not done already)
flutter pub run general

# 4. Check for any issues
flutter analyze

# 5. Try building (without running)
flutter build apk --debug  # For Android
# or
flutter build ios --debug --no-codesign  # For iOS
```

**Quick Checklist**:
- [ ] Flutter SDK installed and verified (`flutter doctor`)
- [ ] Firebase CLI installed and logged in (`firebase login`)
- [ ] FlutterFire CLI installed (`flutterfire --version`)
- [ ] Firebase project created and configured
- [ ] Firebase files generated (`firebase_options.dart`, `google-services.json`, etc.)
- [ ] Dependencies installed (`flutter pub get`)
- [ ] Code generated (`flutter pub run general`)
- [ ] iOS pods installed (if developing for iOS)
- [ ] App builds successfully

---

## 🧪 Testing

### UI Testing with Maestro

This project includes automated UI testing using Maestro.

#### Prerequisites

1. Install Maestro CLI:
   ```bash
   curl -Ls 'https://get.maestro.mobile.dev' | bash
   ```

2. Ensure iOS Simulator is running (for iOS tests)

3. Build the app:
   ```bash
   flutter build ios --simulator  # For iOS
   flutter build apk             # For Android
   ```

#### Running Tests

Navigate to the maestro directory:

```bash
cd maestro
./run_tests.sh [test_type] [device_id]
```

**Test Types**:
- `smoke` (default): Quick smoke tests
- `core`: Core functionality tests
- `features`: Feature-specific tests
- `regression`: Full regression suite
- `all`: All available tests

**Examples**:
```bash
# Run smoke tests
./run_tests.sh smoke

# Run all tests
./run_tests.sh all

# Run with specific device
./run_tests.sh core "iPhone-15-Simulator"
```

Test reports are generated in `maestro/test-reports/`

---

## 🔧 Troubleshooting

### Common Issues

#### Firebase Configuration Issues

**Problem**: `flutterfire configure` fails or doesn't create files
- **Solution**: 
  ```bash
  # Make sure you're logged in
  firebase login
  # Try again
  flutterfire configure
  ```

**Problem**: Firebase files are missing after clone
- **Solution**: These files are gitignored. You need to create your own Firebase project and run `flutterfire configure`

#### Code Generation Issues

**Problem**: Build runner fails with "conflicting outputs"
- **Solution**:
  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```

**Problem**: Localization keys not found
- **Solution**:
  ```bash
  flutter pub run lang
  ```

#### iOS Build Issues

**Problem**: `pod install` fails
- **Solution**:
  ```bash
  cd ios
  sudo gem install cocoapods
  pod repo update
  rm -rf Pods Podfile.lock
  pod install
  cd ..
  ```

**Problem**: Xcode build errors
- **Solution**:
  ```bash
  # Clean build
  flutter clean
  cd ios
  rm -rf Pods Podfile.lock
  pod install
  cd ..
  flutter pub get
  flutter run
  ```

#### Android Build Issues

**Problem**: Gradle build fails
- **Solution**:
  ```bash
  cd android
  ./gradlew clean
  cd ..
  flutter clean
  flutter pub get
  flutter run
  ```

**Problem**: SDK version errors
- **Solution**: Check `android/app/build.gradle` for correct `minSdkVersion` and `targetSdkVersion`

#### Emulator Issues

**Problem**: Firebase emulator doesn't start
- **Solution**:
  ```bash
  # Check if Java is installed (required for emulators)
  java -version
  
  # Make sure Firebase CLI is up to date
  npm install -g firebase-tools@latest
  
  # Try starting emulator with verbose output
  firebase emulators:start --debug
  ```

### Getting Help

If you encounter issues not listed here:
1. Check [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed setup instructions
2. Check [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines
3. Search existing [GitHub Issues](https://github.com/YOUR_USERNAME/life_client/issues)
4. Create a new issue with:
   - Your Flutter version (`flutter --version`)
   - Your OS and version
   - Error messages and logs
   - Steps to reproduce

---

## 📝 Configuration

### Localization

The app supports multiple languages. Translation files are located in `assets/translations/`:

- `tr.json` - Turkish (default)
- `en.json` - English

To add a new language:
1. Create a new JSON file (e.g., `de.json`)
2. Update `lib/core/init/core_localize.dart`
3. Run the localization generator:
   ```bash
   flutter pub run easy_localization:generate -S assets/translations -O lib/product/init/language -o locale_keys.g.dart -f keys
   ```

### Firebase Remote Config

The app uses Firebase Remote Config for dynamic feature flags. Configure in Firebase Console under Remote Config.

### App Icons

Update app icons:
1. Replace `assets/app/app_icon.png`
2. Run:
   ```bash
   flutter pub run flutter_launcher_icons
   ```

---

## 📦 Build & Deployment

### Android

**Debug Build**:
```bash
flutter build apk --debug
```

**Release Build**:
```bash
flutter build apk --release
```

**App Bundle** (for Play Store):
```bash
flutter build appbundle --release
```

### iOS

**Debug Build**:
```bash
flutter build ios --debug
```

**Release Build**:
```bash
flutter build ios --release
```

**Archive** (for App Store):
```bash
flutter build ipa
```

---

## 🔒 Security

### Reporting Security Issues

We take security seriously. If you discover a security vulnerability, please **do not** open a public issue. Instead, email us at `grafikhtyapp@gmail.com` with "SECURITY" in the subject line.

For more details, please see our [Security Policy](SECURITY.md).

### Security Best Practices

- **Firebase Security Rules**: Always configure proper Firestore and Storage rules in Firebase Console
- **Environment Variables**: Never commit `.env` files. Use `.env.example` as a template
- **API Keys**: Firebase client-side API keys are safe to be public. Security is enforced through Security Rules
- **Signing Keys**: Android keystore and Google Play service account keys are never committed

See [SECURITY.md](SECURITY.md) for detailed security information.

### Security Best Practices

- **Firebase Security Rules**: Always configure proper Firestore and Storage rules in Firebase Console
- **Environment Variables**: Never commit `.env` files. Use `.env.example` as a template
- **API Keys**: Firebase client-side API keys are safe to be public. Security is enforced through Security Rules
- **Signing Keys**: Android keystore and Google Play service account keys are never committed

### Important Security Notes

- Firebase API keys in this repository are **client-side keys** and are intentionally public
- Real security is enforced through Firebase Security Rules (configured in Firebase Console)
- Always review and update Security Rules before deploying to production
- See [SECURITY.md](SECURITY.md) for detailed security information

---

## 🤝 Contributing

We welcome contributions! Please read our [CONTRIBUTING.md](CONTRIBUTING.md) for details on:

- Code of Conduct
- Development workflow
- Pull request process
- Code style guidelines

### Code of Conduct

This project adheres to a [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to `grafikhtyapp@gmail.com`.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed list of changes and version history.

---

## 👥 Contributors

We are grateful to all contributors who have helped make this project better!

See [CONTRIBUTORS.md](CONTRIBUTORS.md) for the full list of contributors and acknowledgments.

---

## 📞 Support & Contact

- **Issues**: [GitHub Issues](https://github.com/YOUR_USERNAME/life_client/issues)
- **Email**: grafikhtyapp@gmail.com
- **Project Link**: [https://github.com/YOUR_USERNAME/life_client](https://github.com/YOUR_USERNAME/life_client)

### 📱 Download & Follow

- **Google Play**: [Download on Google Play](https://play.google.com/store/apps/details?id=com.hatayiyasat.app&hl=tr)
- **App Store**: [Download on App Store](https://apps.apple.com/us/app/hatay%C4%B1-ya%C5%9Fat/id6465691080)
- **Instagram**: [@hatayiyasat](https://www.instagram.com/hatayiyasat/)

---

---

## 🙏 Acknowledgments

See [CONTRIBUTORS.md](CONTRIBUTORS.md) for acknowledgments and contributor recognition.

---

<div align="center">

**Made with ❤️ for the Hatay community**

⭐ Star this repo if you find it helpful!

</div>
