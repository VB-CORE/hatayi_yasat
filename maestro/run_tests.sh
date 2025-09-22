#!/bin/bash

# Keep Hatay Alive - Maestro Test Runner
# Usage: ./run_tests.sh [test_type] [device_id]

set -e

# Configuration
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAESTRO_DIR="$PROJECT_DIR"
FLOWS_DIR="$MAESTRO_DIR/flows"
REPORTS_DIR="$PROJECT_DIR/test-reports"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${BLUE}=================================${NC}"
    echo -e "${BLUE}  Keep Hatay Alive - UI Tests${NC}"
    echo -e "${BLUE}=================================${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Create reports directory
mkdir -p "$REPORTS_DIR"

# Check if Maestro is installed
if ! command -v maestro &> /dev/null; then
    print_error "Maestro is not installed. Please install it first:"
    echo "curl -Ls 'https://get.maestro.mobile.dev' | bash"
    exit 1
fi

# Check if device is connected
if ! maestro test --help &> /dev/null; then
    print_error "No device connected or Maestro is not working properly"
    exit 1
fi

print_header

# Parse arguments
TEST_TYPE=${1:-"smoke"}
DEVICE_ID=${2:-""}

print_info "Test Type: $TEST_TYPE"
print_info "Timestamp: $TIMESTAMP"

# Install iOS app on simulator before running tests
print_info "Installing iOS app on simulator..."
if xcrun simctl install Booted "$PROJECT_DIR/../build/ios/iphonesimulator/Runner.app"; then
    print_success "iOS app installed successfully"
else
    print_error "Failed to install iOS app"
    exit 1
fi

# Set device if provided
if [ ! -z "$DEVICE_ID" ]; then
    print_info "Using device: $DEVICE_ID"
    export MAESTRO_DEVICE_ID="$DEVICE_ID"
fi

# Function to run a single flow
run_flow() {
    local flow_path="$1"
    local flow_name
    flow_name=$(basename "$flow_path" .yaml)
    
    print_info "Running: $flow_name"
    
    if maestro test "$flow_path" --format junit --output "$REPORTS_DIR/${flow_name}_${TIMESTAMP}.xml"; then
        print_success "$flow_name completed successfully"
        return 0
    else
        print_error "$flow_name failed"
        return 1
    fi
}

# Run tests based on type
case $TEST_TYPE in
    "smoke")
        print_info "Running smoke tests..."
        run_flow "$FLOWS_DIR/regression/smoke_tests.yaml"
        ;;
    
    "core")
        print_info "Running core functionality tests..."
        run_flow "$FLOWS_DIR/core/app_launch.yaml"
        run_flow "$FLOWS_DIR/core/navigation.yaml"
        ;;
    
    "features")
        print_info "Running feature tests..."
        run_flow "$FLOWS_DIR/features/home_functionality.yaml"
        run_flow "$FLOWS_DIR/features/community_functionality_clean.yaml"
        run_flow "$FLOWS_DIR/features/place_detail_interaction_clean.yaml"
        run_flow "$FLOWS_DIR/features/filter_hotels_antakya_arsuz.yaml"
        ;;
    
    "regression")
        print_info "Running full regression test suite..."
        run_flow "$FLOWS_DIR/regression/full_app_test.yaml"
        ;;
    
    "all")
        print_info "Running all tests..."
        run_flow "$FLOWS_DIR/regression/smoke_tests.yaml"
        run_flow "$FLOWS_DIR/core/app_launch.yaml"
        run_flow "$FLOWS_DIR/core/navigation.yaml"
        run_flow "$FLOWS_DIR/features/home_functionality.yaml"
        run_flow "$FLOWS_DIR/features/events_functionality.yaml"
        run_flow "$FLOWS_DIR/features/forms_testing.yaml"
        run_flow "$FLOWS_DIR/features/settings_functionality.yaml"
        run_flow "$FLOWS_DIR/regression/full_app_test.yaml"
        ;;
    
    *)
        print_error "Unknown test type: $TEST_TYPE"
        echo "Available test types:"
        echo "  smoke      - Quick smoke tests"
        echo "  core       - Core functionality tests"
        echo "  features   - Feature-specific tests"
        echo "  regression - Full regression suite"
        echo "  all        - All tests"
        exit 1
        ;;
esac

print_success "Test execution completed!"
print_info "Reports saved to: $REPORTS_DIR"
