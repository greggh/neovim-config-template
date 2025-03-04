# Neovim Configuration Template

[![GitHub License](https://img.shields.io/github/license/username/neovim-config?style=flat-square)](./LICENSE)
[![Neovim Minimum Version](https://img.shields.io/badge/Neovim-0.8+-57A143?style=flat-square&logo=neovim)](https://neovim.io)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/username/neovim-config/ci.yml?branch=main&style=flat-square&logo=github)](https://github.com/username/neovim-config/actions/workflows/ci.yml)

*A standardized Neovim configuration template with best practices and modern plugins*

[Features](#features) •
[Requirements](#requirements) •
[Installation](#installation) •
[Structure](#structure) •
[Customization](#customization) •
[Key Mappings](#key-mappings) •
[Plugins](#plugins) •
[License](#license)

## Overview

This template provides a well-structured, modular Neovim configuration designed to be both powerful out of the box and easy to customize. It combines best practices from the Neovim community with a carefully curated selection of plugins to create a productive development environment.

## Features

- **Modular Structure**: Well-organized configuration for easy navigation and customization
- **Lazy Loading**: Fast startup with lazy-loaded plugins using lazy.nvim
- **Modern UI**: Aesthetically pleasing interface with consistent theme and colors
- **LSP Integration**: Rich code intelligence with built-in LSP support
- **Smart Completion**: Context-aware code completion with blink.cmp
- **Syntax Highlighting**: Advanced syntax highlighting via Treesitter
- **Testing Support**: Built-in testing framework
- **Git Integration**: Seamless Git workflow
- **Keybinding Help**: Intuitive key binding discovery with which-key
- **Documentation**: Comprehensive documentation with clear explanations

## Requirements

- Neovim 0.8+ (0.9+ recommended)
- Git
- A Nerd Font for icons (optional but recommended)
- External dependencies (installed automatically via Mason):
  - Language servers (e.g. lua_ls, pyright, tsserver)
  - Linters and formatters
  - DAP adapters

## Installation

### New Configuration

1. Backup your existing configuration (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Clone this template:
   ```bash
   git clone https://github.com/username/neovim-config-template.git ~/.config/nvim
   ```

3. Run the setup script to customize:
   ```bash
   cd ~/.config/nvim
   ./scripts/setup.sh
   ```

4. Start Neovim to install plugins:
   ```bash
   nvim
   ```

### Extending Existing Configuration

If you want to incorporate parts of this template into your existing setup:

1. Clone the repository to a temporary location:
   ```bash
   git clone https://github.com/username/neovim-config-template.git /tmp/nvim-template
   ```

2. Copy specific modules or files as needed:
   ```bash
   cp -r /tmp/nvim-template/lua/plugins/ui.lua ~/.config/nvim/lua/plugins/
   ```

## Structure

```
.
├── init.lua                 # Entry point
├── lua/
│   ├── config/              # Core configuration
│   │   ├── autocmd.lua      # Auto commands
│   │   ├── keymaps.lua      # Key mappings
│   │   ├── lazy.lua         # Plugin manager setup
│   │   └── options.lua      # Neovim options
│   ├── plugins/             # Plugin configurations
│   │   ├── coding/          # Development tools
│   │   │   ├── completion.lua  # blink.cmp configuration
│   │   │   ├── treesitter.lua  # Syntax highlighting
│   │   │   └── cmdline.lua     # Command-line completion
│   │   ├── lsp/            # LSP configuration
│   │   │   ├── mason.lua      # LSP installer
│   │   │   └── config.lua     # LSP server setup
│   │   ├── finder/         # File finding tools
│   │   ├── ui/             # UI enhancements
│   │   └── snacks/         # Snacks Explorer configuration
│   └── user/                # User customizations (optional)
├── .stylua.toml             # Lua formatter config
└── tests/                   # Test configurations
```

## Customization

### The `user` Directory

The template provides a separate directory for user customizations in `lua/user/`. Files in this directory are loaded after the core configuration, allowing you to override settings without modifying the original files.

To customize:

1. Create the directory structure:
   ```lua
   mkdir -p ~/.config/nvim/lua/user
   ```

2. Create your customization files:
   ```lua
   -- ~/.config/nvim/lua/user/init.lua
   -- This file is loaded after all other configuration

   -- Override options
   vim.opt.relativenumber = false

   -- Add custom autocommands
   vim.api.nvim_create_autocmd("FileType", {
     pattern = "markdown",
     callback = function()
       vim.opt_local.spell = true
     end,
   })

   -- Custom keymaps
   vim.keymap.set("n", "<leader>x", "<cmd>CustomCommand<CR>")
   ```

3. Add your own plugins:
   ```lua
   -- ~/.config/nvim/lua/user/plugins.lua
   return {
     {
       "username/custom-plugin",
       config = function()
         require("custom-plugin").setup({})
       end,
     },
   }
   ```

## Key Mappings

The template comes with carefully chosen key mappings designed for productivity. Here are some highlights:

| Key                  | Mode | Action                       |
|----------------------|------|------------------------------|
| `<Space>`            | N    | Leader key                   |
| `<C-h/j/k/l>`        | N    | Navigate windows             |
| `<C-s>`              | N    | Save file                    |
| `<C-q>`              | N    | Quit                         |
| `<leader>e`          | N    | Toggle file explorer         |
| `<leader>ca`         | N    | Code actions                 |
| `<leader>f`          | N    | Find files                   |
| `<leader>g`          | N    | Git commands                 |
| `gd`                 | N    | Go to definition             |
| `K`                  | N    | Show documentation           |
| `<leader>rn`         | N    | Rename symbol                |
| `<leader>cd`         | N    | Show diagnostics             |
| `<leader>w`          | N    | Save                         |
| `<leader>q`          | N    | Quit                         |

For a complete list, press `<Space>` and wait for the which-key popup, or see `lua/config/keymaps.lua`.

## Plugins

This template includes a carefully selected set of plugins, all configured for optimal performance and user experience. Some highlights include:

| Plugin            | Purpose                       |
|-------------------|-------------------------------|
| Catppuccin        | Beautiful colorscheme         |
| Lualine           | Status line                   |
| Snacks.nvim        | Feature-rich explorer/UI      |
| Treesitter        | Advanced syntax highlighting  |
| nvim-lspconfig    | LSP configuration             |
| Mason             | LSP/DAP/linter installer      |
| blink.cmp         | Modern completion engine      |
| blink.compat      | Compatibility layer           |
| Noice.nvim        | Enhanced UI notifications     |
| LuaSnip           | Snippet engine                |
| Telescope         | Fuzzy finder                  |
| Which-key         | Keybinding helper             |
| gitsigns          | Git integration               |

All plugins are lazy-loaded for optimal startup performance.

## License

This template is released under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Neovim](https://neovim.io/) - The core editor
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [Catppuccin](https://github.com/catppuccin/nvim) - Colorscheme
- Community contributors and plugin authors

---

<p align="center">
  Made with ❤️ for the Neovim community
</p>
## Discussions

Have questions or ideas? Join the conversation in [GitHub Discussions](https://github.com/USERNAME/neovim-config-template/discussions).

- **Questions**: For help with configuration or troubleshooting
- **Ideas**: Suggest new features or improvements
- **Show and Tell**: Share your customizations and setups
- **General**: For any other topics related to this configuration
