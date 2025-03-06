<div align="center">

# Neovim Configuration Template

[![GitHub License](https://img.shields.io/github/license/greggh/neovim-config-template?style=flat-square)](https://github.com/greggh/neovim-config-template/blob/main/LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/greggh/neovim-config-template?style=flat-square)](https://github.com/greggh/neovim-config-template/stargazers)
[![GitHub Issues](https://img.shields.io/github/issues/greggh/neovim-config-template?style=flat-square)](https://github.com/greggh/neovim-config-template/issues)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/greggh/neovim-config-template?style=flat-square)](https://github.com/greggh/neovim-config-template/commits/main)
[![Neovim Version](https://img.shields.io/badge/Neovim-0.8%2B-blueviolet?style=flat-square&logo=neovim)](https://github.com/neovim/neovim)
[![CI](https://img.shields.io/github/actions/workflow/status/greggh/neovim-config-template/ci.yml?branch=main&style=flat-square&logo=github)](https://github.com/greggh/neovim-config-template/actions/workflows/ci.yml)
[![Version](https://img.shields.io/badge/Version-0.1.1-blue?style=flat-square)](https://github.com/greggh/neovim-config-template/releases/tag/v0.1.1)
[![Discussions](https://img.shields.io/github/discussions/greggh/neovim-config-template?style=flat-square&logo=github)](https://github.com/greggh/neovim-config-template/discussions)

*A standardized Neovim configuration template with best practices and modern plugins*

[Features](#features) •
[Requirements](#requirements) •
[Installation](#installation) •
[Customization](#customization) •
[Plugins](#plugins) •
[Key Mappings](#key-mappings) •
[Contributing](#contributing) •
[License](#license)

</div>

## Features

- 📦 **Plugin Management** - Modern plugin system with [lazy.nvim](https://github.com/folke/lazy.nvim)
- ⚡ **Performance** - Fast startup time with lazy loading
- 🧠 **Completion** - Powerful completion with [blink.cmp](https://github.com/greggh/blink.cmp)
- 🔍 **Diagnostics** - Advanced diagnostics with [Trouble](https://github.com/folke/trouble.nvim)
- 🎨 **Beautiful UI** - Modern look with [Catppuccin](https://github.com/catppuccin/nvim) and [Noice](https://github.com/folke/noice.nvim)
- 📂 **File Explorer** - Integrated explorer with [Snacks](https://github.com/greggh/snacks.nvim)
- 🔭 **Fuzzy Finding** - Telescope for searching files, text, and much more
- 📊 **Performance** - Profiling tools built-in for optimization
- ⌨️ **Keymaps** - Comprehensive mappings with which-key integration
- 🧩 **Modular** - Well-structured and modular configuration

## Requirements

- Neovim 0.8 or higher (0.9+ recommended)
- Git 2.19.0 or higher
- A Nerd Font (optional but recommended)
- [ripgrep](https://github.com/BurntSushi/ripgrep) for Telescope (optional)
- [fd](https://github.com/sharkdp/fd) for faster file finding (optional)
- [lazygit](https://github.com/jesseduffield/lazygit) for Git integration (optional)

## Installation

### Quick Install

```bash
# Backup your existing config if needed
mv ~/.config/nvim ~/.config/nvim.bak

# Clone the template
git clone https://github.com/greggh/neovim-config-template.git ~/.config/nvim

# Start Neovim - plugins will be installed automatically
nvim
```

### Manual Exploration

If you want to understand the template before installing:

```bash
# Clone to a temporary location
git clone https://github.com/greggh/neovim-config-template.git /tmp/nvim-template

# Look through the files
cd /tmp/nvim-template
```

## Customization

### Using User Config

The easiest way to customize is by creating a `lua/user/init.lua` file:

```lua
-- In lua/user/init.lua
return {
  -- Override options
  options = {
    tabstop = 4,
    background = "light",
  },
  
  -- Add your own plugins
  plugins = {
    "YOUR_USERNAME/custom-plugin",
    { "another/plugin", config = true },
  },
  
  -- Execute custom code
  setup = function()
    -- Any custom code you want to run
    vim.g.my_custom_var = "value"
  end,
}
```

### Directory Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/              # Core configuration
│   │   ├── autocmd.lua      # Auto commands
│   │   ├── keymaps.lua      # Key mappings
│   │   ├── lazy.lua         # Plugin manager setup
│   │   └── options.lua      # Vim options
│   ├── plugins/             # Plugin configurations
│   │   ├── coding/          # Coding plugins (treesitter, completion)
│   │   ├── colorscheme/     # Themes and colors
│   │   ├── diagnostics/     # Linting and diagnostics
│   │   ├── lsp/             # LSP configurations
│   │   └── ui/              # UI enhancements
│   └── utils/               # Utility functions
└── tests/                   # Tests for your config
```

## Plugins

This template includes a carefully selected set of plugins:

### Core Plugins
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Modern plugin manager
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Lua functions library
- [blink.cmp](https://github.com/greggh/blink.cmp) - Advanced completion (placeholder)

### Editor Features
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [which-key.nvim](https://github.com/folke/which-key.nvim) - Keybinding helper
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - Highlight TODOs
- [trouble.nvim](https://github.com/folke/trouble.nvim) - Diagnostics list

### UI Enhancements
- [catppuccin](https://github.com/catppuccin/nvim) - Modern colorscheme
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Status line
- [noice.nvim](https://github.com/folke/noice.nvim) - UI enhancements
- [snacks.nvim](https://github.com/greggh/snacks.nvim) - File explorer (placeholder)

See the `lua/plugins` directory for the complete list and configurations.

## Key Mappings

This template uses Space as the leader key. Here are some important mappings:

| Mapping | Description |
|---------|-------------|
| `<leader>e` | Toggle file explorer |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>gg` | Open LazyGit |
| `<leader>xx` | Open diagnostics list |
| `<leader>pp` | Generate profile report |
| `<leader>nn` | Open notifications panel |

For a complete list, press `<leader>` to see a which-key popup, or check `lua/config/keymaps.lua`.

## Profiling

Built-in profiling tools help you optimize your configuration:

| Mapping | Description |
|---------|-------------|
| `<leader>pp` | Generate profile report |
| `<leader>ps` | Show profile summary |
| `<leader>pL` | List all profile logs |
| `<leader>pa` | Analyze plugin performance |
| `<leader>pc` | Clean up profile logs |

Enable profiling by starting Neovim with:

```bash
NVIM_PROFILE=1 nvim
```

## Discussions

Have questions or ideas? Join the conversation in [GitHub Discussions](https://github.com/greggh/neovim-config-template/discussions).

- **Questions**: For help with configuration or troubleshooting
- **Ideas**: Suggest new features or improvements
- **Show and Tell**: Share your customizations and setups
- **General**: For any other topics related to this configuration

## Contributing

Contributions are welcome! Check out [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Development Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/greggh/neovim-config-template.git
   cd neovim-config-template
   ```

2. Install development dependencies:
   - Neovim 0.8+
   - Luacheck for linting
   - StyLua for formatting

3. Set up pre-commit hooks (important first step!):
   ```bash
   ./scripts/setup-hooks.sh
   ```
   This will enable automatic formatting, linting, and testing before each commit. Make sure to run this before making any changes to ensure code quality.

### Project Structure

```
.
├── lua/               # Lua configuration files
│   ├── config/        # Core configuration modules
│   ├── plugins/       # Plugin configurations
│   └── utils/         # Utility functions
├── plugin/            # Plugin files that are always loaded
├── tests/             # Test suite
├── .github/           # GitHub workflows and templates
├── .githooks/         # Git hooks for development
├── scripts/           # Development and utility scripts
├── .stylua.toml       # StyLua configuration
├── .luacheckrc        # Luacheck configuration
└── init.lua           # Main entry point
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [lazy.nvim](https://github.com/folke/lazy.nvim) - The plugin manager that makes this configuration possible
- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - Inspiration for some aspects of this template
- [Neovim](https://neovim.io) - The foundation of modern text editing
- [hooks-util](https://github.com/greggh/hooks-util) - Git hooks framework used in this project

---

<div align="center">
  <p>Made with ❤️ by <a href="https://github.com/greggh">greggh</a></p>
</div>