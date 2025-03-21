#!/bin/bash

# Script to set up Git hooks for Neovim Config Template

# Make sure we're in the project root
cd "$(dirname "$0")/.." || exit 1

# Create .githooks directory if it doesn't exist
mkdir -p .githooks

# Set up Git hooks directory
git config core.hooksPath .githooks

echo "Git hooks have been set up successfully."
echo "Pre-commit hook will now automatically format Lua files using StyLua,"
echo "run linting with luacheck, and run tests."