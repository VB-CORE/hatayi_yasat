# Maestro UI Testing Setup Guide

## Architecture Overview

### 1. Flutter Semantic Keys
- Flutter widgets use `GeneralSemantic` wrapper for accessibility
- Keys defined in `GeneralSemanticKeys` enum
- Example: `Key('homeView')` in Flutter code

### 2. Maestro Page Objects
- JS files in `/elements/` define page object mappings
- Variables like `${output.home.splashView}` reference Flutter keys
- Structure: `output.[page].[element] = "flutter_key"`

### 3. Test Flow Structure
```yaml
# Load page objects
- runFlow: ../../elements/loadElements.yaml

# Use in tests
- assertVisible:
    id: ${output.home.mainTabView}
```

## Current Page Objects

### Home Page (`/elements/home.js`)
```javascript
output.home = {
  splashView: "splashView",
  mainTabView: "mainTabView",
  placeCard: {
    hermes: ".*place_grid_card_Hermes.*",
    cardContainer: "place_grid_card"
  },
  productName: ".*Hermes.*"
}
```

## Adding New Elements

### 1. Flutter Side
```dart
// In your widget
GeneralSemantic(
  semanticKey: GeneralSemanticKeys.yourNewKey,
  child: YourWidget(key: Key('yourElementKey'))
)
```

### 2. Maestro Side
```javascript
// In appropriate .js file
output.pageName = {
  yourElement: "yourElementKey"
}
```

### 3. Test Usage
```yaml
- tapOn:
    id: ${output.pageName.yourElement}
```

## File Structure
```
maestro/
├── elements/
│   ├── loadElements.yaml  # Loads all JS files
│   ├── home.js           # Home page objects
│   ├── nav.js            # Navigation objects
│   └── common.js         # Common UI elements
├── flows/
│   ├── features/         # Feature-specific tests
│   └── regression/       # Smoke tests
└── run_tests.sh          # Test runner script
```