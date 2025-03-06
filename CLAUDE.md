# Project: Neovim Config Template

## Overview
Neovim Config Template provides a standardized starting point for creating Neovim configurations. It inherits from the base project template and adds Neovim-specific configuration structure, lazy-loading, modular organization, and comprehensive plugin configuration patterns for an optimized Neovim experience.

## Essential Commands
- Run Tests: `env -C /home/gregg/Projects/neovim/neovim-config-template lua tests/run_tests.lua`
- Check Formatting: `env -C /home/gregg/Projects/neovim/neovim-config-template stylua lua/ -c`
- Format Code: `env -C /home/gregg/Projects/neovim/neovim-config-template stylua lua/`
- Run Linter: `env -C /home/gregg/Projects/neovim/neovim-config-template luacheck lua/`
- Profile Startup: `env -C /home/gregg/Projects/neovim/neovim-config-template NVIM_PROFILE=1 nvim --clean -u init.lua`

## Project Structure
- `/lua/core`: Core configuration (options, keymaps, autocommands)
- `/lua/plugins`: Plugin specifications and configurations
- `/lua/utils`: Utility functions and helpers
- `/lua/modules`: Feature-specific configuration modules
- `/after/plugin`: Configuration that must load after plugins
- `/tests`: Test files for configuration components
- `/scripts`: Development utilities and helpers

## Current Focus
- Enhancing module organization with clearer interfaces
- Replacing custom utilities with nvim-toolkit modules
- Improving lazy-loading for better startup performance
- Adding more customization options for user preferences
- Creating better documentation for customization

## Documentation Links
- Tasks: `/home/gregg/Projects/docs-projects/neovim-ecosystem-docs/tasks/neovim-config-template-tasks.md`
- Project Status: `/home/gregg/Projects/docs-projects/neovim-ecosystem-docs/project-status.md`