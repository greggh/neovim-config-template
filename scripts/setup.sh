#!/bin/bash
# Setup script for the Neovim configuration template

set -e

# ANSI color codes
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Print a colored message
print_message() {
  local color="$1"
  local message="$2"
  echo -e "${color}${message}${NC}"
}

print_message "$BLUE" "========================================"
print_message "$BLUE" "  Neovim Configuration Setup"
print_message "$BLUE" "========================================"
echo

# Get user information
read -p "Enter your name: " USER_NAME
if [ -z "$USER_NAME" ]; then
  print_message "$YELLOW" "Warning: Using 'Your Name' as placeholder"
  USER_NAME="Your Name"
fi

read -p "Enter your GitHub username: " GITHUB_USERNAME
if [ -z "$GITHUB_USERNAME" ]; then
  print_message "$YELLOW" "Warning: Using 'username' as placeholder"
  GITHUB_USERNAME="username"
fi

read -p "Enter your email for contact: " EMAIL
if [ -z "$EMAIL" ]; then
  print_message "$YELLOW" "Warning: Using 'email@example.com' as placeholder"
  EMAIL="email@example.com"
fi

# Get configuration name
read -p "Enter a name for your configuration (e.g. awesome-nvim): " CONFIG_NAME
if [ -z "$CONFIG_NAME" ]; then
  print_message "$YELLOW" "Warning: Using 'my-neovim-config' as default name"
  CONFIG_NAME="my-neovim-config"
fi

# Ask for optional configurations
print_message "$BLUE" "Select preferred colorscheme:"
echo "1) Catppuccin (default)"
echo "2) Tokyonight"
echo "3) Gruvbox"
echo "4) Nord"
read -p "Enter choice [1-4]: " COLORSCHEME_CHOICE
case $COLORSCHEME_CHOICE in
  2) COLORSCHEME="tokyonight" ;;
  3) COLORSCHEME="gruvbox" ;;
  4) COLORSCHEME="nord" ;;
  *) COLORSCHEME="catppuccin" ;;
esac

read -p "Enable relative line numbers? [Y/n]: " RELATIVE_NUMBERS
RELATIVE_NUMBERS=${RELATIVE_NUMBERS:-Y}

read -p "Enable transparent background? [y/N]: " TRANSPARENT_BG
TRANSPARENT_BG=${TRANSPARENT_BG:-N}

# Summary
print_message "$GREEN" "Configuration Summary:"
echo "  Name: $CONFIG_NAME"
echo "  Author: $USER_NAME ($GITHUB_USERNAME)"
echo "  Email: $EMAIL"
echo "  Colorscheme: $COLORSCHEME"
echo "  Relative Numbers: $RELATIVE_NUMBERS"
echo "  Transparent Background: $TRANSPARENT_BG"
echo

# Ask for confirmation
read -p "Continue with this configuration? [Y/n]: " CONFIRM
CONFIRM=${CONFIRM:-Y}
if [[ ! $CONFIRM =~ ^[Yy]$ ]]; then
  print_message "$RED" "Setup cancelled"
  exit 1
fi

# Update files with user information
print_message "$BLUE" "Updating configuration files..."

# Update README.md
if [ -f "README.md" ]; then
  sed -i "s/Neovim Configuration Template/$CONFIG_NAME/g" README.md
  sed -i "s/username\/neovim-config/$GITHUB_USERNAME\/$CONFIG_NAME/g" README.md
  sed -i "s/username\/neovim-config-template/$GITHUB_USERNAME\/$CONFIG_NAME/g" README.md
  print_message "$GREEN" "✓ Updated README.md"
fi

# Update LICENSE
if [ -f "LICENSE" ]; then
  YEAR=$(date +%Y)
  sed -i "s/\[year\]/$YEAR/g" LICENSE
  sed -i "s/\[fullname\]/$USER_NAME/g" LICENSE
  print_message "$GREEN" "✓ Updated LICENSE"
fi

# Update GitHub templates
find .github -type f -exec sed -i "s/username/$GITHUB_USERNAME/g" {} \; 2>/dev/null || true
find .github -type f -exec sed -i "s/neovim-config-template/$CONFIG_NAME/g" {} \; 2>/dev/null || true
print_message "$GREEN" "✓ Updated GitHub templates"

# Update colorscheme in plugin configuration
if [ -f "lua/plugins/ui.lua" ]; then
  case $COLORSCHEME in
    "catppuccin")
      # Already set as default, no change needed
      ;;
    "tokyonight")
      # Replace catppuccin with tokyonight
      sed -i 's/  -- Colorscheme/  -- Colorscheme/g' lua/plugins/ui.lua
      sed -i 's/  {/  {/g' lua/plugins/ui.lua
      sed -i 's/    "catppuccin\/nvim",/    "folke\/tokyonight.nvim",/g' lua/plugins/ui.lua
      sed -i 's/    name = "catppuccin",/    name = "tokyonight",/g' lua/plugins/ui.lua
      sed -i 's/      require("catppuccin").setup({/      require("tokyonight").setup({/g' lua/plugins/ui.lua
      sed -i 's/        flavour = "mocha", -- latte, frappe, macchiato, mocha/        style = "storm", -- storm, moon, night, day/g' lua/plugins/ui.lua
      sed -i 's/        background = {/        -- background = {/g' lua/plugins/ui.lua
      sed -i 's/          light = "latte",/          -- light = "day",/g' lua/plugins/ui.lua
      sed -i 's/          dark = "mocha",/          -- dark = "storm",/g' lua/plugins/ui.lua
      sed -i 's/        },/        -- },/g' lua/plugins/ui.lua
      sed -i 's/      vim.cmd.colorscheme("catppuccin")/      vim.cmd.colorscheme("tokyonight")/g' lua/plugins/ui.lua
      ;;
    "gruvbox")
      # Replace catppuccin with gruvbox
      sed -i 's/  -- Colorscheme/  -- Colorscheme/g' lua/plugins/ui.lua
      sed -i 's/  {/  {/g' lua/plugins/ui.lua
      sed -i 's/    "catppuccin\/nvim",/    "sainnhe\/gruvbox-material",/g' lua/plugins/ui.lua
      sed -i 's/    name = "catppuccin",/    name = "gruvbox-material",/g' lua/plugins/ui.lua
      sed -i '/      require("catppuccin").setup({/,/      })/ s/^/      -- /' lua/plugins/ui.lua
      sed -i '/      require("catppuccin").setup({/a\      vim.g.gruvbox_material_background = "medium" -- soft, medium, hard\n      vim.g.gruvbox_material_better_performance = 1\n      vim.g.gruvbox_material_foreground = "material" -- material, mix, original' lua/plugins/ui.lua
      sed -i 's/      vim.cmd.colorscheme("catppuccin")/      vim.cmd.colorscheme("gruvbox-material")/g' lua/plugins/ui.lua
      ;;
    "nord")
      # Replace catppuccin with nord
      sed -i 's/  -- Colorscheme/  -- Colorscheme/g' lua/plugins/ui.lua
      sed -i 's/  {/  {/g' lua/plugins/ui.lua
      sed -i 's/    "catppuccin\/nvim",/    "shaunsingh\/nord.nvim",/g' lua/plugins/ui.lua
      sed -i 's/    name = "catppuccin",/    name = "nord",/g' lua/plugins/ui.lua
      sed -i '/      require("catppuccin").setup({/,/      })/ s/^/      -- /' lua/plugins/ui.lua
      sed -i '/      require("catppuccin").setup({/a\      vim.g.nord_contrast = true\n      vim.g.nord_borders = true\n      vim.g.nord_disable_background = false\n      vim.g.nord_italic = false' lua/plugins/ui.lua
      sed -i 's/      vim.cmd.colorscheme("catppuccin")/      vim.cmd.colorscheme("nord")/g' lua/plugins/ui.lua
      ;;
  esac
  print_message "$GREEN" "✓ Updated colorscheme to $COLORSCHEME"
fi

# Update relative line numbers setting
if [ -f "lua/config/options.lua" ]; then
  if [[ $RELATIVE_NUMBERS =~ ^[Nn]$ ]]; then
    sed -i 's/vim.opt.relativenumber = true/vim.opt.relativenumber = false/g' lua/config/options.lua
    print_message "$GREEN" "✓ Disabled relative line numbers"
  fi
fi

# Update transparent background setting
if [ -f "lua/plugins/ui.lua" ]; then
  if [[ $TRANSPARENT_BG =~ ^[Yy]$ ]]; then
    case $COLORSCHEME in
      "catppuccin")
        sed -i 's/        transparent_background = false,/        transparent_background = true,/g' lua/plugins/ui.lua
        ;;
      "tokyonight")
        sed -i '/        style = "storm"/a\        transparent = true,' lua/plugins/ui.lua
        ;;
      "gruvbox")
        sed -i '/vim.g.gruvbox_material_foreground/a\      vim.g.gruvbox_material_transparent_background = 1' lua/plugins/ui.lua
        ;;
      "nord")
        sed -i 's/      vim.g.nord_disable_background = false/      vim.g.nord_disable_background = true/g' lua/plugins/ui.lua
        ;;
    esac
    print_message "$GREEN" "✓ Enabled transparent background"
  fi
fi

# Create user directory
if [ ! -d "lua/user" ]; then
  mkdir -p "lua/user"
  cat > "lua/user/init.lua" << EOF
-- Custom configuration overrides
-- This file is loaded after all other configurations

-- Add your custom settings here
EOF
  print_message "$GREEN" "✓ Created user customization directory"
fi

# Initialize git repository if needed
if [ ! -d ".git" ]; then
  print_message "$BLUE" "Initializing git repository..."
  git init
  git add .
  git commit -m "Initial commit: Set up $CONFIG_NAME from template"
  print_message "$GREEN" "✓ Git repository initialized"
fi

# Add hooks-util as a submodule?
if [ ! -d ".hooks-util" ]; then
  print_message "$BLUE" "Would you like to add hooks-util as a git submodule? [y/N]"
  read -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_message "$BLUE" "Adding hooks-util as a submodule..."
    git submodule add https://github.com/$GITHUB_USERNAME/hooks-util.git .hooks-util
    cd .hooks-util
    ./install.sh -c
    cd ..
    print_message "$GREEN" "✓ hooks-util added as a submodule"
  fi
fi

print_message "$GREEN" "Setup complete! 🎉"
print_message "$BLUE" "Next steps:"
echo "  1. Start Neovim to install plugins: nvim"
echo "  2. Review the configuration files to understand the structure"
echo "  3. Add your own customizations in the lua/user directory"
echo
print_message "$BLUE" "Enjoy your new Neovim configuration! 💻"