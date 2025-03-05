#!/bin/bash
# Test runner script for Neovim config template

# Exit on first error
set -e

echo "========================================" 
echo "Running tests for Neovim config template"
echo "========================================"

# Find test directory 
TEST_DIR="$(dirname "$(dirname "$0")")/tests"
SPEC_DIR="$TEST_DIR/spec"

if [ ! -d "$SPEC_DIR" ]; then
  echo "Error: Test directory not found: $SPEC_DIR"
  exit 1
fi

# List test files
echo "Found test files:"
TEST_FILES=$(find "$SPEC_DIR" -name "*.lua" -type f)
if [ -z "$TEST_FILES" ]; then
  echo "No test files found in $SPEC_DIR"
  exit 1
fi

# Display test files
find "$SPEC_DIR" -name "*.lua" -type f

# Run all test files
echo "Running all tests..."
for test_file in "$SPEC_DIR"/*.lua; do
  if [ -f "$test_file" ]; then
    test_name=$(basename "$test_file")
    echo "Running test: $test_name"
    
    # Save the current directory and move to test dir
    pushd "$TEST_DIR" > /dev/null
    
    # Run the minimal test script with the current spec file
    # This will exit with error code if any test fails
    LUA_PATH=";;$TEST_DIR/?.lua" lua -e "dofile('minimal.lua'); dofile('spec/$test_name')"
    
    # Return to the original directory
    popd > /dev/null
    
    echo "Test passed: $test_name"
  fi
done

echo "========================================" 
echo "All tests passed!"
echo "========================================" 
exit 0