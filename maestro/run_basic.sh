#!/bin/bash

# Simple Basic Test Runner for iOS
set -e

echo "🚀 Starting Basic Test Runner..."

# Check if Maestro is installed
if ! command -v maestro &> /dev/null; then
    echo "❌ Maestro not found. Install it first:"
    echo "curl -Ls 'https://get.maestro.mobile.dev' | bash"
    exit 1
fi

# Boot iOS Simulator (iPhone 15)
echo "📱 Booting iOS Simulator..."
xcrun simctl boot "iPhone 15" || echo "Simulator already booted"

# Wait for simulator to be ready
sleep 3

# Install app on simulator
echo "📦 Installing app..."
APP_PATH="../build/ios/iphonesimulator/Runner.app"
if [ -d "$APP_PATH" ]; then
    xcrun simctl install Booted "$APP_PATH"
    echo "✅ App installed"
else
    echo "⚠️ App not found at $APP_PATH, continuing without install"
fi

# Run basic test
echo "🧪 Running basic test..."
maestro test -c maestro/flows/regression/basic_test.yaml

echo "✅ Basic test completed!"