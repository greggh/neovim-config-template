-- config/lazy.lua
-- Plugin management with lazy.nvim

-- Bootstrap lazy.nvim if not installed
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

-- Load lazy.nvim
require("lazy").setup({
  -- Load plugins directly from subdirectories
  { import = "plugins.snacks" },
  { import = "plugins.colorscheme" },
  { import = "plugins.statusline" },
  { import = "plugins.indent" },
  { import = "plugins.which-key" },
  { import = "plugins.lsp" },
  { import = "plugins.coding" },
  { import = "plugins.terminal" },
  { import = "plugins.finder" },
  { import = "plugins.ui" },
  { import = "plugins.diagnostics" },
  { import = "plugins.window" },
  
  -- Load user plugins if available
  { import = "user.plugins", optional = true },
}, {
  defaults = {
    lazy = true, -- Default to lazy loading
    version = false, -- Use latest git commit
  },
  install = {
    colorscheme = { "catppuccin", "habamax" }, -- Try to use these colorschemes when installing plugins
  },
  checker = {
    enabled = true, -- Enable checking for plugin updates
    notify = false, -- Don't notify about updates
    frequency = 86400, -- Check once a day
  },
  change_detection = {
    enabled = true, -- Enable detection of config changes
    notify = false, -- Don't notify about changes
  },
  performance = {
    cache = {
      enabled = true, -- Enable caching
    },
    reset_packpath = true, -- Reset packpath
    rtp = {
      -- Disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  -- UI customization
  ui = {
    border = "rounded", -- Rounded borders
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      import = "📥",
      keys = "🔑",
      lazy = "💤 ",
      loaded = "●",
      not_loaded = "○",
      plugin = "🔌",
      runtime = "🏃",
      source = "📄",
      start = "🚀",
      task = "📌",
    },
  },
})