-- tests/minimal-init.lua
-- Minimal configuration for testing

-- Set up leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Configure basic Neovim options for testing
vim.opt.termguicolors = true
vim.opt.runtimepath:append(".")

-- Disable some features for testing
vim.cmd("syntax off")
vim.cmd("filetype off")

-- Install the plugin manager (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set up a mock for frequently used plugins
local function setup_mocks()
  -- Common plugins to mock
  local common_plugins = {
    "telescope",
    "nvim-lspconfig",
    "mason",
    "cmp", -- Mock for nvim-cmp (for backwards compatibility)
    "blink.cmp", -- Mock for blink.cmp
    "gitsigns",
    "which-key",
    "nvim-treesitter.configs",
    "lazy",
  }

  for _, plugin_name in ipairs(common_plugins) do
    if not package.loaded[plugin_name] then
      package.loaded[plugin_name] = {
        setup = function(_)
          return true
        end,
      }
    end
  end

  -- Mock table for blink.cmp
  package.loaded["blink.cmp"] = {
    setup = function()
      return true
    end,
    get_lsp_capabilities = function()
      return {}
    end,
    show = function()
      return true
    end,
    show_cmdline = function()
      return true
    end,
  }

  -- Mock table for nvim-cmp for compatibility
  package.loaded["cmp"] = {
    setup = function()
      return true
    end,
    mapping = {
      ["<C-d>"] = function() end,
      ["<C-u>"] = function() end,
      ["<C-Space>"] = function() end,
      ["<CR>"] = function() end,
      ["<Tab>"] = function() end,
      ["<S-Tab>"] = function() end,
    },
    config = {
      sources = function() end,
      formatting = function() end,
    },
    entry = {
      get_documentation = function() end,
    },
  }

  -- Mock for blink.compat
  package.loaded["blink.compat"] = {
    source = function()
      return {}
    end,
  }

  -- Additional mocks as needed
  package.loaded["luasnip"] = {
    expand_or_jumpable = function() return false end,
    expand_or_jump = function() end,
    jumpable = function() return false end,
    jump = function() end,
  }
end

-- Call the mock setup function
setup_mocks()

-- Simple plugin configuration for testing
require("lazy").setup({
  -- Add required plugins for testing here
})

-- Return the setup_mocks function for use in specific test files
return {
  setup_mocks = setup_mocks,
}