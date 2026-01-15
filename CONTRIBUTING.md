# Contributing to Hatay İyasat - Life Client

First off, thank you for considering contributing to Life Client! It's people like you that make this app a great tool for the Hatay community.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Code Style Guidelines](#code-style-guidelines)
- [Commit Message Guidelines](#commit-message-guidelines)
- [Pull Request Process](#pull-request-process)
- [Testing Guidelines](#testing-guidelines)
- [Project Structure](#project-structure)
- [Need Help?](#need-help)

---

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to grafikhtyapp@gmail.com.

### Our Standards

- **Be respectful**: Treat everyone with respect and kindness
- **Be collaborative**: Work together and help each other
- **Be constructive**: Provide helpful feedback and suggestions
- **Be inclusive**: Welcome newcomers and diverse perspectives

---

## Getting Started

### Prerequisites

Before you start contributing, make sure you have:

1. **Development Environment**:
   - Flutter SDK 3.7.0+
   - Dart SDK 3.7.0+
   - Android Studio or Xcode (depending on target platform)
   - Git installed

2. **Firebase Project**:
   - Set up your own Firebase project (see [README.md](README.md#firebase-setup))
   - Configure FlutterFire CLI

3. **Code Editor**:
   - VS Code or Android Studio with Flutter/Dart plugins
   - Recommended VS Code extensions:
     - Flutter
     - Dart
     - Pubspec Assist
     - Flutter Riverpod Snippets

### Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/life_client.git
   cd life_client
   ```

3. Add the upstream repository:
   ```bash
   git remote add upstream https://github.com/ORIGINAL_OWNER/life_client.git
   ```

4. Install dependencies:
   ```bash
   flutter pub get
   ```

5. Configure Firebase (follow README.md instructions)

6. Generate code:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

7. Run the app to ensure everything works:
   ```bash
   flutter run
   ```

---

## Development Workflow

### 1. Create a Branch

Always create a new branch for your work:

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/bug-description
```

Branch naming conventions:
- `feature/` - New features (e.g., `feature/add-user-reviews`)
- `fix/` - Bug fixes (e.g., `fix/login-crash`)
- `docs/` - Documentation changes (e.g., `docs/update-readme`)
- `refactor/` - Code refactoring (e.g., `refactor/home-view`)
- `test/` - Adding tests (e.g., `test/add-home-view-tests`)

### 2. Make Your Changes

- Write clean, readable code
- Follow the project's code style (see below)
- Add comments for complex logic
- Update documentation if needed
- Add tests for new features

### 3. Keep Your Branch Updated

Regularly sync with the upstream repository:

```bash
git fetch upstream
git rebase upstream/main
```

### 4. Test Your Changes

Before submitting:

```bash
# Run code analysis
flutter analyze

# Run tests (if available)
flutter test

# Build the app
flutter build apk --debug  # For Android
flutter build ios --debug  # For iOS
```

### 5. Commit Your Changes

Follow our [commit message guidelines](#commit-message-guidelines):

```bash
git add .
git commit -m "feat: add user review feature"
```

### 6. Push to Your Fork

```bash
git push origin feature/your-feature-name
```

### 7. Open a Pull Request

1. Go to your fork on GitHub
2. Click "New Pull Request"
3. Select your branch
4. Fill out the PR template (see below)
5. Submit the PR

---

## Code Style Guidelines

We follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) style guide with some project-specific conventions.

### Flutter/Dart Standards

This project uses **Very Good Analysis** for linting:

```yaml
# analysis_options.yaml
include: package:very_good_analysis/analysis_options.yaml
```

**Key principles**:
- ✅ Always run `flutter analyze` before committing
- ✅ Fix all warnings and errors
- ✅ Use meaningful variable and function names
- ✅ Keep functions small and focused

### Code Formatting

Use `dart format` to automatically format your code:

```bash
# Format all Dart files
dart format .

# Check formatting without making changes
dart format --set-exit-if-changed .
```

### Naming Conventions

```dart
// Classes: UpperCamelCase
class HomeViewModel { }
class PlaceDetailView { }

// Files: snake_case
home_view_model.dart
place_detail_view.dart

// Variables & functions: lowerCamelCase
final userName = 'John';
void fetchUserData() { }

// Constants: lowerCamelCase
const defaultTimeout = Duration(seconds: 30);

// Private members: prefix with _
final _privateField = '';
void _privateMethod() { }

// Enums: UpperCamelCase for type, lowerCamelCase for values
enum SortingType {
  byName,
  byDate,
  byRating,
}
```

### Widget Structure

Follow this order for widget properties:

```dart
Widget build(BuildContext context) {
  return Scaffold(
    // 1. Key
    key: const Key('homeView'),

    // 2. Layout properties
    appBar: AppBar(...),
    body: ...,

    // 3. Styling properties
    backgroundColor: Colors.white,

    // 4. Interaction callbacks
    onTap: () { },
  );
}
```

### State Management (Riverpod)

Use Riverpod code generation:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeState build() {
    return HomeState.initial();
  }

  Future<void> fetchPlaces() async {
    // Implementation
  }
}
```

### File Organization

Each feature should follow this structure:

```
feature_name/
├── provider/
│   ├── feature_provider.dart      # Riverpod provider
│   └── feature_state.dart         # State model
├── view/
│   ├── feature_view.dart          # Main view
│   ├── widget/                    # Feature-specific widgets
│   │   └── feature_widget.dart
│   └── mixin/                     # View mixins
│       └── feature_mixin.dart
├── model/                          # Data models (optional)
│   └── feature_model.dart
└── README.md                       # Feature documentation (optional)
```

### Comments & Documentation

- ✅ Add doc comments for public APIs:
  ```dart
  /// Fetches places from Firestore based on [category].
  ///
  /// Returns a list of [PlaceModel] or throws [FirebaseException]
  /// if the fetch fails.
  Future<List<PlaceModel>> fetchPlaces(String category) async {
    // Implementation
  }
  ```

- ✅ Add inline comments for complex logic:
  ```dart
  // Calculate the weighted score based on rating and distance
  final score = (rating * 0.7) + (normalizedDistance * 0.3);
  ```

- ❌ Avoid obvious comments:
  ```dart
  // Bad: This increments the counter
  counter++;

  // Good: Increment to track pagination offset
  counter++;
  ```

### Imports

Organize imports in this order:

```dart
// 1. Dart imports
import 'dart:async';
import 'dart:io';

// 2. Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 3. Package imports (alphabetically)
import 'package:firebase_core/firebase_core.dart';
import 'package:riverpod/riverpod.dart';

// 4. Project imports (alphabetically)
import 'package:lifeclient/features/home/home_view.dart';
import 'package:lifeclient/product/model/place_model.dart';
```

---

## Commit Message Guidelines

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification.

### Format

```
<type>(<scope>): <subject>

<body (optional)>

<footer (optional)>
```

### Types

- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, no logic change)
- **refactor**: Code refactoring
- **perf**: Performance improvements
- **test**: Adding or updating tests
- **build**: Build system or dependencies changes
- **ci**: CI/CD changes
- **chore**: Other changes (e.g., updating .gitignore)

### Examples

```bash
# Good commit messages
feat(home): add place filtering by category
fix(auth): resolve login crash on iOS 16
docs(readme): update Firebase setup instructions
refactor(place): extract place card to separate widget
test(home): add unit tests for HomeViewModel
perf(image): optimize image loading with caching

# Bad commit messages (avoid these)
update stuff
fixed bug
WIP
asdfasdf
```

### Scope (Optional but Recommended)

The scope should indicate the feature or module affected:

- `home`
- `auth`
- `place`
- `event`
- `news`
- `settings`
- `firebase`
- etc.

---

## Pull Request Process

### Before Submitting

1. ✅ Ensure your code follows the style guidelines
2. ✅ Run `flutter analyze` and fix all issues
3. ✅ Run `dart format .` to format code
4. ✅ Test your changes thoroughly
5. ✅ Update documentation if needed
6. ✅ Rebase on latest `main` branch

### PR Template

When creating a PR, include:

```markdown
## Description
Brief description of what this PR does.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Changes Made
- Added X feature
- Fixed Y bug
- Refactored Z component

## Screenshots (if applicable)
[Add screenshots for UI changes]

## Testing
- [ ] Tested on Android
- [ ] Tested on iOS
- [ ] Added unit tests
- [ ] All tests pass

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-reviewed my own code
- [ ] Commented complex code sections
- [ ] Updated documentation
- [ ] No new warnings from flutter analyze
- [ ] Tested on physical device (if UI change)

## Related Issues
Closes #123
```

### Review Process

1. A maintainer will review your PR
2. Address any feedback or requested changes
3. Once approved, your PR will be merged
4. Your contribution will be credited in the release notes

### What to Expect

- **Response time**: Usually within 2-3 days
- **Feedback**: Constructive feedback to improve code quality
- **Iterations**: Be prepared for multiple review rounds
- **Patience**: Some PRs may take time to review thoroughly

---

## Testing Guidelines

### Manual Testing

Always test your changes on:

1. **Android devices/emulators**:
   - Different screen sizes (phone, tablet)
   - Different Android versions (API 24+)

2. **iOS devices/simulators**:
   - Different iPhone models
   - Different iOS versions (13+)

3. **Edge cases**:
   - No internet connection
   - Empty states
   - Error scenarios
   - Loading states

### Automated Testing

#### Unit Tests (When Applicable)

```dart
// test/features/home/home_view_model_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeViewModel', () {
    test('should fetch places successfully', () async {
      // Arrange
      final viewModel = HomeViewModel();

      // Act
      await viewModel.fetchPlaces();

      // Assert
      expect(viewModel.state.places, isNotEmpty);
    });
  });
}
```

Run tests:
```bash
flutter test
```

#### UI Tests with Maestro

```bash
cd maestro
./run_tests.sh smoke
```

---

## Project Structure

Understanding the project structure will help you contribute effectively:

```
lib/
├── core/                    # Core shared functionality
│   ├── dependency/         # Dependency injection setup
│   ├── init/              # App initialization
│   └── service/           # Core services (permissions, etc.)
│
├── features/               # Feature modules (feature-first)
│   ├── main/              # Main navigation features
│   ├── details/           # Detail screens
│   ├── sub_feature/       # Supporting features
│   ├── tourism/           # Tourism module
│   └── splash/            # Splash screen
│
├── product/                # Shared product code
│   ├── init/              # Product initialization
│   ├── model/             # Shared data models
│   ├── navigation/        # App routing
│   ├── widget/            # Reusable widgets
│   ├── utility/           # Helper utilities
│   └── package/           # Custom packages
│
└── sub_feature/            # Standalone feature modules
```

### Where to Add Your Changes

- **New feature**: Create a new folder in `lib/features/`
- **New shared widget**: Add to `lib/product/widget/`
- **New model**: Add to `lib/product/model/` or feature-specific `model/`
- **New utility**: Add to `lib/product/utility/`
- **Bug fix**: Modify existing files in the relevant feature

---

## Need Help?

### Resources

- **Documentation**: Check [README.md](README.md)
- **Flutter Docs**: https://flutter.dev/docs
- **Riverpod Docs**: https://riverpod.dev
- **Firebase Docs**: https://firebase.google.com/docs

### Getting Support

- **Questions**: Open a [GitHub Discussion](https://github.com/OWNER/life_client/discussions)
- **Bugs**: Open a [GitHub Issue](https://github.com/OWNER/life_client/issues)
- **Email**: grafikhtyapp@gmail.com

### Communication Channels

- GitHub Issues: Bug reports and feature requests
- GitHub Discussions: Questions and general discussions
- Email: Direct communication with maintainers

---

## Recognition

All contributors will be:
- Listed in the project's README
- Credited in release notes
- Added to the GitHub contributors graph

Thank you for contributing! 🎉

---

<div align="center">

**Together, we're building something great for the Hatay community!**

</div>
