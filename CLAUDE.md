# CLAUDE.md - Neovim Config Template

This document contains useful information and commands for working with this project.

## Project Overview

The neovim-config-template is a standardized template for creating Neovim configurations with modern plugins and structure. It provides a foundation with best practices for Neovim configuration management.

## Repository Structure

- `init.lua`: Main entry point that loads core modules
- `lua/config/`: Core configuration files
  - `lazy.lua`: Plugin management with lazy.nvim
  - `options.lua`: Neovim options and settings
  - `keymaps.lua`: Key mappings
  - `autocmd.lua`: Autocommand definitions
- `lua/plugins/`: Plugin configurations organized by category
- `lua/utils/`: Utility functions
- `lua/core/`: Core functionality modules
- `scripts/`: Utility scripts for version management and testing
- `tests/`: Test framework and specifications
- `docs/`: Documentation files

## Development Commands

### Git Commands

```bash
# Check Git status
git -C /home/gregg/Projects/neovim/neovim-config-template status

# Commit changes
git -C /home/gregg/Projects/neovim/neovim-config-template add .
git -C /home/gregg/Projects/neovim/neovim-config-template commit -m "commit message"

# Push changes
git -C /home/gregg/Projects/neovim/neovim-config-template push origin main

# Pull latest changes
git -C /home/gregg/Projects/neovim/neovim-config-template pull
```

### Testing

```bash
# Run all tests using the run_tests.sh script
bash /home/gregg/Projects/neovim/neovim-config-template/scripts/run_tests.sh

# Run a specific test file manually
cd /home/gregg/Projects/neovim/neovim-config-template/tests
LUA_PATH=";;./?.lua" lua -e "dofile('minimal.lua'); dofile('spec/config_spec.lua')"

# Run tests with verbose output
VERBOSE=1 bash /home/gregg/Projects/neovim/neovim-config-template/scripts/run_tests.sh
```

### Linting and Formatting

```bash
# Run luacheck with configuration from .luacheckrc
cd /home/gregg/Projects/neovim/neovim-config-template && luacheck .

# Format with stylua using .stylua.toml configuration
cd /home/gregg/Projects/neovim/neovim-config-template && stylua .

# Check a specific file with luacheck
luacheck /home/gregg/Projects/neovim/neovim-config-template/lua/config/options.lua

# Format a specific file with stylua
stylua /home/gregg/Projects/neovim/neovim-config-template/lua/config/options.lua
```

### Version Management

```bash
# Check version consistency
lua /home/gregg/Projects/neovim/neovim-config-template/scripts/version_check.lua

# Bump version
lua /home/gregg/Projects/neovim/neovim-config-template/scripts/version_bump.lua [major|minor|patch]
```

### Setup and Installation

```bash
# Run setup script
/home/gregg/Projects/neovim/neovim-config-template/scripts/setup.sh

# Setup git hooks
/home/gregg/Projects/neovim/neovim-config-template/scripts/setup-hooks.sh
```

## Common Tasks

### Adding a New Plugin

1. Create a new file in the appropriate category under `lua/plugins/`
2. Follow the lazy.nvim spec format for plugin configuration
3. Ensure proper lazy-loading with event/command/ft triggers
4. Add any required keymaps to the plugin spec with proper which-key integration

### Updating Documentation

1. Edit files in the `docs/` directory
2. Follow the existing structure and formatting
3. Run the documentation workflow after pushing changes

### Performing a Release

1. Ensure all tests pass
2. Update the version in `lua/core/version.lua`
3. Update `CHANGELOG.md` with the changes
4. Commit the changes
5. Create a new tag for the release version
6. Push the tag and changes

## Troubleshooting

### Debug Information

- Enable Neovim debugging with: `export NVIM_LOG_LEVEL=debug` before starting Neovim
- Profiling: Set `NVIM_PROFILE=1` to enable startup profiling
- Log files: Located in `$XDG_DATA_HOME/nvim/` or `~/.local/share/nvim/`

### Common Issues

- **Plugin loading errors**: Check lazy.nvim logs with `:Lazy log`
- **LSP setup issues**: Verify Mason installation with `:Mason`
- **Test failures**: Run tests with more verbosity using the `-v` flag

## References

- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim README](https://github.com/folke/lazy.nvim)
- [Project Roadmap](ROADMAP.md)
- [Contributing Guidelines](CONTRIBUTING.md)