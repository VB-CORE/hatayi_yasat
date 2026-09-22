# Hatayi Yasat

<img height="600" alt="image" src="https://github.com/user-attachments/assets/144dd63a-de50-4594-8ef0-6a3e7a35e72f" />


<div align="center">

**A comprehensive Flutter application for discovering local places, events, news, and community resources in Hatay, Turkey.**

[![Flutter](https://img.shields.io/badge/Flutter-3.44+-02569B?logo=flutter)](https://flutter.dev)
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

**Hatayı Yaşat** is a mobile application designed to help residents and visitors discover and engage with local businesses, events, historical sites, and community resources in Hatay province, Turkey. The app provides a comprehensive directory of places, real-time event information, news updates, job listings, and tourism information.

The app is live on [Google Play](https://play.google.com/store/apps/details?id=com.hatayiyasat.app&hl=tr) and the [App Store](https://apps.apple.com/us/app/hatay%C4%B1-ya%C5%9Fat/id6465691080). Website: [hatayiyasat.com](https://www.hatayiyasat.com/).

### Key Highlights

- 🏪 **Local Directory**: Browse restaurants, cafes, shops, and services across Hatay
- 📍 **Interactive Maps**: Google Maps integration for location discovery
- 📰 **News & Jobs**: Stay updated with local news and employment opportunities
- 🎉 **Events**: Discover upcoming events and cultural activities
- 🏛️ **History & Tourism**: Explore historical sites and tourist attractions
- 👥 **Community**: Groups, discussions, and place ratings
- 🧑‍💼 **Merchant Panel**: Business owners manage their own store listing
- 🎟️ **Campaigns**: Coupons redeemed in-store via QR
- 🔐 **Accounts**: Google / Apple sign-in, plus a guest mode
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

- **Accounts & Authentication**
  - Google Sign-In and Sign in with Apple
  - Guest mode for browsing without an account
  - Favorites, saved news, and notifications tied to the account

- **Community**
  - Create and join local groups
  - Group discussions with detail threads
  - Rate and review places

- **Merchant Panel**
  - Store owners edit their own listing (hours, contact, photos)
  - Dashboard with listing performance
  - Read and respond to incoming reviews
  - Showcase management

- **Campaigns & Coupons**
  - Browse active campaigns from local businesses
  - Redeem coupons in-store through a personal QR code

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

> Versions below track `pubspec.yaml`. When you bump a dependency, update this section too.

### Framework & Language
- **Flutter**: 3.44.9 (the version CI builds with — see [analyze.yml](.github/workflows/analyze.yml))
- **Dart SDK**: `^3.10.7`

### State Management
- **flutter_riverpod**: ^3.1.0 — `@riverpod` Notifier classes with code generation
- **riverpod_annotation**: ^4.0.0 / **riverpod_generator**: ^4.0.0+1
- **equatable**: ^2.0.5 — state equality (this project does **not** use Freezed)

### Dependency Injection
- **get_it**: ^9.2.0 — service locator, wired at app start

### Backend & Services
- **firebase_core**: ^4.13.0
- **cloud_firestore**: ^6.8.0 — primary database
- **firebase_auth**: ^6.5.7 — with **google_sign_in** ^7.2.0 and **sign_in_with_apple** ^8.1.0
- **firebase_storage**: ^13.4.6 — image and file storage
- **firebase_analytics**: ^12.4.6 / **firebase_crashlytics**: ^5.2.7
- **firebase_messaging**: ^16.5.0 — push notifications
- **firebase_remote_config**: ^6.5.6 — feature flags
- **cloud_functions**: ^6.3.6 — the client calls callable functions (search); the function
  source is not hosted in this repository

> **Firestore/Storage rules and indexes live in the `life_admin` repository** (under
> `firebase/`) and are deployed from there, because both apps share the same `savehatay`
> project. `firebase.json` in this repo therefore declares no `firestore`/`storage` block.
> Any change that opens a new write path from this client must ship with the matching rules
> change in `life_admin` in the same PR. See CLAUDE.md § 3.

### Navigation & Routing
- **go_router**: ^17.0.1 with **go_router_builder**: ^4.1.3 — typed routes via code generation

### UI & Design
- **Material 3** with light / dark / system theming
- **Typography**: fonts are bundled in `assets/fonts/` — `PlusJakartaSans` for body text and
  `DMSerifDisplay` for headings. `google_fonts` is intentionally **not** used
- **responsive_framework**: ^1.1.0 / **responsive_builder**: ^0.7.0
- **lottie**: ^3.1.2 / **shimmer_animation**: ^2.2.2+1 / **carousel_slider**: ^5.0.0
- **flutter_svg**: ^2.0.9 / **hugeicons** / **material_symbols_icons**
- **qr_flutter**: ^4.1.0 — coupon redemption QR codes

### Maps & Location
- **google_maps_flutter**: ^2.18.0
- **permission_handler**: ^13.0.0

### Localization
- **easy_localization**: ^3.0.1 — keys generated into `lib/product/init/language/locale_keys.g.dart`
- Supported languages: Turkish (tr), English (en)

### Media & Files
- **image_picker**: ^1.0.4 / **image_cropper**: ^11.0.0
- **flutter_image_compress**: ^2.0.4
- **file_picker**: ^11.0.3
- **syncfusion_flutter_pdfviewer**: ^33.2.13

### Local Storage
- **hive_ce**: ^2.11.3 — local cache
- **shared_preferences**: ^2.2.1

### Networking & Utilities
- **cached_network_image**: ^3.2.3
- **connectivity_plus**: ^7.0.0
- **url_launcher**: ^6.2.3 / **share_plus**: ^12.0.2
- **kartal**: ^4.2.0 — utility extensions

### Testing & Quality
- **flutter_test** — unit tests under `test/`
- **Maestro** — automated UI flows under `maestro/`
- **very_good_analysis**: ^10.0.0 — lint rules

### Shared Library
- **life_shared** — internal shared package, pinned to git tag `v7.0.0`
  - Repository: [VB-CORE/life_shared](https://github.com/VB-CORE/life_shared)

---

## 🏗️ Architecture

The project follows a **feature-first architecture** with clear separation of concerns:

```
lib/
├── core/                    # Core functionality
│   ├── dependency/         # Dependency injection (GetIt)
│   ├── init/              # App initialization
│   ├── theme/             # Theme, colors, typography
│   └── service/           # Core services
│
├── features/               # Feature modules
│   ├── main/              # Bottom-tab destinations
│   │   ├── home/         # Home screen
│   │   ├── event/        # Events listing
│   │   ├── news_jobs/    # News & jobs
│   │   ├── history/      # Historical content
│   │   ├── profile/      # User profile
│   │   └── settings/     # App settings
│   │
│   ├── auth/              # Google / Apple sign-in, guest mode
│   ├── onboarding/        # First-run onboarding
│   ├── place_detail/      # Place detail screen
│   ├── details/           # Event & news detail views
│   │
│   ├── community/         # Groups, discussions, ratings
│   │   ├── groups/
│   │   ├── group_detail/
│   │   ├── create_group/
│   │   ├── discussion_detail/
│   │   └── rate/
│   │
│   ├── merchant_panel/    # Store owner dashboard, reviews, listing edit
│   ├── monetization/      # Campaigns, coupons, redemption
│   │
│   ├── sub_feature/       # Supporting features
│   │   ├── favorite/     # Favorites management
│   │   ├── filter_and_search/  # Search & filtering
│   │   ├── search/       # Search screen
│   │   ├── forms/        # User submission forms
│   │   ├── notifications/
│   │   ├── saved_news/
│   │   ├── user_qr/      # Personal coupon QR
│   │   ├── special_agency/
│   │   ├── useful_links/
│   │   ├── developers/   # Developer info
│   │   ├── web_view/
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
└── sub_feature/            # App shell & standalone features
    ├── main_tab/          # Bottom navigation shell
    ├── advertisement_board/
    ├── notification_navigate/
    ├── filter_button/
    ├── banned/
    └── unauthorized/
```

### Design Patterns

- **MVVM**: every feature is a ViewModel + State + View triple
- **Riverpod `@riverpod` Notifier**: ViewModels are generated notifier classes; state is an
  `Equatable` class with a hand-written `copyWith` (no Freezed). Async work is tracked with
  explicit `isLoading` / `isFetching` / `isError` flags rather than `AsyncValue`
- **Service layer**: Firestore and Storage access goes through `life_shared` services that
  return a `FirestoreResult` / `StorageResult` union, so failures surface as values instead
  of thrown exceptions
- **Dependency Injection**: GetIt as the service locator, reached from ViewModels via
  `ProjectDependencyMixin` and from widgets via `AppProviderMixin`
- **Code Generation**: build_runner for providers, routes, models, and assets

### Feature Structure

Each feature typically contains:
```
feature_name/
├── view_model/            # or provider/ in older features
│   ├── feature_view_model.dart   # @riverpod notifier
│   └── feature_state.dart        # Equatable state + copyWith
├── view/                  # UI components
│   ├── feature_view.dart         # ConsumerStatefulWidget
│   ├── widget/           # Feature-specific widgets
│   └── mixin/            # View mixins (initState/dispose/logic)
└── model/                 # Feature models (if needed)
```

The full set of conventions this project holds itself to — naming, state management,
DI, routing, and the styling tokens — lives in [CLAUDE.md](CLAUDE.md).

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK**: 3.44.9 or higher (this is the version CI builds with)
  ```bash
  flutter --version
  # Verify installation
  flutter doctor
  ```

- **Dart SDK**: 3.10.7 or higher (comes with Flutter)

- **rps**: the shortcut runner used by this project's `scripts:` block in `pubspec.yaml`
  ```bash
  dart pub global activate rps
  # Add to PATH if needed (add to ~/.bashrc or ~/.zshrc)
  export PATH="$PATH:$HOME/.pub-cache/bin"
  rps --version
  ```

- **Node.js and npm**: For the Firebase CLI
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
git clone https://github.com/VB-CORE/hatayi_yasat.git
cd hatayi_yasat
```

#### 2. Install Dependencies

```bash
flutter pub get
```

> **Heads-up:** generated files (`*.g.dart`, `*.gen.dart`) are **not** committed to this
> repository. A fresh clone will **not** compile until you run code generation in
> [step 6](#6-generate-code). `pubspec.lock` *is* committed, so the generated code and the
> package versions never drift apart between machines.

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

**Note**: This repository already ships the config for the production `savehatay` project, so
these three files exist right after cloning. Running `flutterfire configure` **overwrites them**
with your own project's values — which is what you want for local development. They are
committed on purpose: they hold only client-side identifiers, which are safe to publish (see
[Security](#-security)). Do not commit your own copies back.

**Verification**:
```bash
# Check if files exist
ls lib/firebase_options.dart
ls android/app/google-services.json
ls ios/Runner/GoogleService-Info.plist
```

##### Step 3.5: Firestore Database Setup

1. In Firebase Console, go to **Firestore Database**
2. The app reads from collections including:
   - `approvedAdvertise` — approved business listings
   - `touristicPlaces` — tourist attractions
   - `news` — news articles
   - `memories` — historical memory archive
   - `adBoard` — advertisement board
   - `approvedCampaigns` / `unApprovedCampaigns` — coupon campaigns
   - `approvedApplications` / `unApprovedApplications` — user submissions
   - `chainStores`, `specialAgency`, `scholarship`, `usefulLinks`, `developers`
   - `categories`, `towns`, `regionalCities`, `regionalTowns` — taxonomy and geography
   - `notifications`, `logs`, `adminList`, `allowedAdminClaims`
   - plus the community collections (groups, discussions, ratings)

   The full sample schema is in [`data/example_scheme.json`](data/example_scheme.json).

3. **Add sample data** (recommended): import that schema into the emulator instead of
   hand-creating documents — see
   [step 8](#8-firebase-emulator-setup-optional---for-local-development).

##### Step 3.6: Security Rules

> **Firestore and Storage rules are not maintained in this repository.**
>
> The production rules and indexes live in the companion admin repository (`life_admin`,
> private) because two applications share the same Firebase project and the rules have to
> have a single source of truth. `firebase.json` here points at `firebase/*.rules` paths
> that are intentionally absent, so **`firebase deploy` will not work from this repo**.

For your own Firebase project you need to author your own rules in the Firebase Console.
A restrictive starting point:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read: if true;      // tighten per collection before going to production
      allow write: if false;    // no public writes
    }
  }
}
```

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

These are deliberately minimal — the real ruleset is considerably stricter and is scoped per
collection. Review and tighten before deploying anything publicly.

#### 4. Cloud Functions

The app calls one Firebase **callable function** (used for search) through
`lib/product/package/firebase/custom_functions.dart`. The function's source is **not** part of
this repository and `firebase.json` declares no `functions` target, so there is nothing to
deploy or configure from here.

If you point the app at your own Firebase project, either deploy your own callable with a
matching name or expect search to fail while the rest of the app works.

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

This project uses code generation for models, providers, routing, and localization. Generated
files are not committed, so **this step is mandatory** — without it the project does not compile.

**Option 1: Generate everything at once (Recommended)**
```bash
rps general
# This runs: build_runner + localization generation
```

**Option 2: Generate separately**
```bash
# Generate models, providers, and routes (build_runner)
dart run build_runner build --delete-conflicting-outputs

# Generate localization keys
rps lang
```

`general` and `lang` are shortcuts defined in the `scripts:` section of `pubspec.yaml` and are
run by [`rps`](https://pub.dev/packages/rps), not by `flutter pub run`. If you would rather not
install `rps`, run the underlying commands directly:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter pub run easy_localization:generate \
  -O lib/product/init/language -f keys -o locale_keys.g.dart \
  --source-dir assets/translations
```

**What gets generated:**
- Model classes (JSON serialization)
- Riverpod providers (`*_view_model.g.dart`)
- GoRouter routes (`app_router.g.dart`)
- Localization keys (`locale_keys.g.dart`)
- Asset references

**Note**: If you modify models, providers, routes, or translations, re-run code generation.

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

**For Web**:
```bash
flutter run -d chrome
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
   rps emulatorImport
   # equivalent to: node scripts/import_example_data.js
   ```
   This converts `data/example_scheme.json` to Firebase emulator format.

2. **Start Firebase emulators**:
   ```bash
   rps emulator
   # equivalent to:
   # firebase emulators:start --import=./emulator-data --export-on-exit=./emulator-data
   ```
   This starts the Auth (port 3000), Firestore (3004), and Storage (3005) emulators with the
   imported data, plus the emulator UI.

3. **Point the app at the emulators**:
   - The wiring exists in [`lib/product/init/application_init.dart`](lib/product/init/application_init.dart)
     but is **commented out by default**, so a debug build talks to the real Firebase project
   - Uncomment the `if (kDebugMode)` block (`useFirestoreEmulator` / `useAuthEmulator` /
     `useStorageEmulator` on ports 3004 / 3000 / 3005) to route debug builds to the emulators
   - Comment it back out before building a release

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
rps general

# 4. Check for any issues
flutter analyze

# 5. Try building (without running)
flutter build apk --debug  # For Android
# or
flutter build ios --debug --no-codesign  # For iOS
```

**Quick Checklist**:
- [ ] Flutter SDK installed and verified (`flutter doctor`)
- [ ] `rps` activated (`rps --version`)
- [ ] Firebase CLI installed and logged in (`firebase login`)
- [ ] FlutterFire CLI installed (`flutterfire --version`)
- [ ] Firebase project created and configured
- [ ] Firebase files generated (`firebase_options.dart`, `google-services.json`, etc.)
- [ ] Dependencies installed (`flutter pub get`)
- [ ] Code generated (`rps general`) — **required, the project will not compile otherwise**
- [ ] iOS pods installed (if developing for iOS)
- [ ] App builds successfully

---

## 🧪 Testing

### Unit Tests

Dart unit tests live in `test/` and run with the standard toolchain:

```bash
flutter test
```

Note that tests depend on generated code, so run `rps general` first on a fresh clone.

### Static Analysis

```bash
flutter analyze
```

CI runs the same check on every pull request to `main` via
[.github/workflows/analyze.yml](.github/workflows/analyze.yml), which installs dependencies,
runs code generation, and then analyzes with [`very_good_analysis`](analysis_options.yaml)
rules. Generated files are deliberately **not** excluded from analysis — since they are never
committed, analyze is the only gate that catches generated code drifting from its generator.

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
- `smoke` (default): quick smoke suite — `flows/regression/smoke_tests.yaml`
- `core`: core functionality — app launch and navigation
- `features`: feature-specific flows
- `regression`: full regression suite
- `all`: all of the above

> The flow library is still being filled in. Today only `flows/core/` and
> `flows/regression/` contain checked-in flows, so `smoke` is the type that runs end to end.
> The other types reference flow files that are not in the repository yet and will report
> missing-file errors for those steps.

**Examples**:
```bash
# Run smoke tests
./run_tests.sh smoke

# Run with specific device
./run_tests.sh core "iPhone-15-Simulator"
```

Or from the project root via the shortcut: `rps mt`.

Test reports are written to `maestro/test-reports/`.

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
  rps lang
  ```

**Problem**: `flutter pub run general` / `flutter pub run lang` fails with "Could not find package"
- **Cause**: `general`, `lang`, `emulator`, and `emulatorImport` are `pubspec.yaml` `scripts:`
  entries, which are run by `rps` — not by `flutter pub run`
- **Solution**:
  ```bash
  dart pub global activate rps
  export PATH="$PATH:$HOME/.pub-cache/bin"
  rps general
  ```

**Problem**: Missing `*.g.dart` files, or "Target of URI doesn't exist" errors everywhere
- **Cause**: Generated files are not committed to this repository
- **Solution**: Run `rps general` (or the two underlying commands) before building

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
3. Search existing [GitHub Issues](https://github.com/VB-CORE/hatayi_yasat/issues)
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
2. Register the locale in `lib/core/init/core_localize.dart`
3. Regenerate the keys:
   ```bash
   rps lang
   ```

Never hardcode UI strings — use `LocaleKeys.<key>.tr()` from the generated
`lib/product/init/language/locale_keys.g.dart`.

### Firebase Remote Config

The app uses Firebase Remote Config for dynamic feature flags. Configure in Firebase Console under Remote Config.

### App Icons

Update app icons:
1. Replace `assets/app/app_icon.png`
2. Run:
   ```bash
   dart run flutter_launcher_icons
   # or: rps updateIcon
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

- **Firebase config is committed on purpose**: `firebase_options.dart`,
  `android/app/google-services.json`, and `ios/Runner/GoogleService-Info.plist` are tracked in
  this repository. They contain only **client-side identifiers**, which are safe to publish —
  Google documents them as such. Real access control is enforced by Security Rules, not by
  hiding these files
- **Security Rules are the actual boundary**: they are maintained and deployed outside this
  repository (see [step 3.6](#step-36-security-rules)). Review and tighten them before any
  public deployment
- **Environment variables**: never commit `.env` files — `functions/.env` is gitignored
- **Signing keys**: `android/key.properties`, the Android keystore, and Google Play service
  account keys are never committed

See [SECURITY.md](SECURITY.md) for the full security policy.

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

- **Issues**: [GitHub Issues](https://github.com/VB-CORE/hatayi_yasat/issues)
- **Email**: grafikhtyapp@gmail.com
- **Project Link**: [https://github.com/VB-CORE/hatayi_yasat](https://github.com/VB-CORE/hatayi_yasat)
- **Website**: [hatayiyasat.com](https://www.hatayiyasat.com/)

### 📱 Download & Follow

- **Google Play**: [Download on Google Play](https://play.google.com/store/apps/details?id=com.hatayiyasat.app&hl=tr)
- **App Store**: [Download on App Store](https://apps.apple.com/us/app/hatay%C4%B1-ya%C5%9Fat/id6465691080)
- **Instagram**: [@hatayiyasat](https://www.instagram.com/hatayiyasat/)

---

## 🙏 Acknowledgments

See [CONTRIBUTORS.md](CONTRIBUTORS.md) for acknowledgments and contributor recognition.

---

<div align="center">

**Made with ❤️ for the Hatay community**

⭐ Star this repo if you find it helpful!

</div>
