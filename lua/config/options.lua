-- config/options.lua
-- Neovim options configuration

-- Core behavior
vim.opt.compatible = false        -- Don't be compatible with vi
vim.opt.hidden = true             -- Allow switching buffers without saving
vim.opt.updatetime = 100          -- Faster update time
vim.opt.timeoutlen = 300          -- Shorter timeout for keymaps
vim.opt.mouse = "a"               -- Enable mouse in all modes
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Better completion

-- UI settings
vim.opt.termguicolors = true      -- True color support
vim.opt.number = true             -- Show line numbers
vim.opt.relativenumber = true     -- Relative line numbers
vim.opt.signcolumn = "yes"        -- Always show signcolumn
vim.opt.cursorline = true         -- Highlight current line
vim.opt.showmode = false          -- Don't show mode in command line
vim.opt.showcmd = true            -- Show command in status line
vim.opt.cmdheight = 1             -- Command line height
vim.opt.laststatus = 3            -- Global status line
vim.opt.title = true              -- Show title in terminal
vim.opt.splitbelow = true         -- Split below current window
vim.opt.splitright = true         -- Split right of current window
vim.opt.pumheight = 10            -- Maximum number of items in popup menu
vim.opt.scrolloff = 5             -- Lines of context around cursor
vim.opt.sidescrolloff = 8         -- Columns of context around cursor

-- Search settings
vim.opt.ignorecase = true         -- Ignore case in search patterns
vim.opt.smartcase = true          -- Override ignorecase if uppercase
vim.opt.hlsearch = true           -- Highlight matches
vim.opt.incsearch = true          -- Incremental search

-- Indentation
vim.opt.expandtab = true          -- Use spaces instead of tabs
vim.opt.shiftwidth = 2            -- Size of indent
vim.opt.tabstop = 2               -- Number of spaces tabs count for
vim.opt.smartindent = true        -- Insert indents automatically
vim.opt.shiftround = true         -- Round indent to multiple of 'shiftwidth'

-- Wrapping
vim.opt.wrap = false              -- No line wrapping
vim.opt.linebreak = true          -- Break at word boundaries
vim.opt.breakindent = true        -- Maintain indent when wrapping

-- File handling
vim.opt.backup = false            -- Don't create backup files
vim.opt.swapfile = false          -- Don't create swap files
vim.opt.undofile = true           -- Persistent undo
vim.opt.fileencoding = "utf-8"    -- File encoding

-- Appearance
vim.opt.fillchars = {
  fold = "·",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Folding
vim.opt.foldmethod = "marker"     -- Fold based on markers
vim.opt.foldlevelstart = 99       -- Start unfolded by default

-- Completion
vim.opt.wildmode = "longest:full,full" -- Command line completion mode

-- Performance settings
vim.opt.lazyredraw = true         -- Don't redraw while executing macros

-- Load user options if available
pcall(require, "user.options")