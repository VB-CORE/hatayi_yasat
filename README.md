<h1>Base Project Firebase with Riverpod</h1>

base line color sceme

https://m3.material.io/styles/color/the-color-system/tokens

## UI Testing with Maestro

This project includes automated UI testing using Maestro. The test runner script (`maestro/run_tests.sh`) automatically installs the iOS app and runs various test suites.

### Prerequisites

1. **Maestro Installation**: Install Maestro CLI

   ```bash
   curl -Ls 'https://get.maestro.mobile.dev' | bash
   ```

2. **iOS Simulator**: Make sure iOS Simulator is running and a device is booted

   ```bash
   xcrun simctl install Booted build/ios/iphonesimulator/Runner.app
   ```

3. **App Build**: Build the iOS app first
   ```bash
   flutter build ios --simulator
   ```

### Usage

Navigate to the maestro directory and run the test script:

```bash
cd maestro
./run_tests.sh [test_type] [device_id]
```

### Test Types

- **smoke** (default): Quick smoke tests to verify basic functionality
- **core**: Core functionality tests (app launch, navigation)
- **features**: Feature-specific tests (home, community, place details)
- **regression**: Full regression test suite
- **all**: Runs all available tests

### Examples

```bash
# Run smoke tests (default)
./run_tests.sh

# Run core functionality tests
./run_tests.sh core

# Run all tests
./run_tests.sh all

# Run with specific device ID
./run_tests.sh smoke "iPhone-15-Simulator"
```

### What the Script Does

1. **Pre-flight Checks**: Verifies Maestro installation and device connectivity
2. **App Installation**: Automatically installs the latest iOS build (`build/ios/iphonesimulator/Runner.app`) on the simulator
3. **Test Execution**: Runs the selected test suite(s)
4. **Report Generation**: Creates JUnit XML reports in `maestro/test-reports/` directory

### Test Reports

All test results are saved as JUnit XML files in the `maestro/test-reports/` directory with timestamps for easy tracking.
