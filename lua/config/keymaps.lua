local bind = require("utils.keymap-bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

-- Normal keymaps for the template
local builtin_map = {
  -- Fix for typo
  ["n|q:"] = map_cmd("<Cmd>q<CR>"):with_noremap():with_silent():with_desc("edit: Quit"),

  -- Paste replace visual selection without yanking
  ["v|p"] = map_cmd('"_dP'):with_noremap():with_silent():with_desc("edit: Paste replace visual selection"),

  -- Easy insertion of a trailing ; or , from insert mode
  ["i|;;"] = map_cmd("<Esc>A;"):with_noremap():with_silent():with_desc("edit: Insert trailing semicolon"),
  ["i|,,"] = map_cmd("<Esc>A,"):with_noremap():with_silent():with_desc("edit: Insert trailing comma"),

  -- Clear search highlights
  ["n|<leader>k"] = map_cr("nohlsearch"):with_noremap():with_silent():with_desc("edit: Clear search highlights"),

  -- Save & quit
  ["n|<leader>qs"] = map_cu("write"):with_noremap():with_silent():with_desc("edit: Save file"),
  ["n|<leader>qq"] = map_cr("wq"):with_desc("edit: Save file and quit"),
  ["n|<leader>qf"] = map_cr("qall!"):with_desc("edit: Force quit all (no save)"),
  ["n|<leader>qx"] = map_cr("wqall"):with_desc("edit: Save all and quit"),
  ["n|<leader>qz"] = map_cr("quitall!"):with_desc("edit: Force quit"),
  ["n|<C-s>"] = map_cu("write"):with_noremap():with_silent():with_desc("edit: Save file"),

  -- Insert mode
  ["i|<C-s>"] = map_cmd("<Esc>:w<CR>"):with_desc("edit: Save file"),
  ["i|<C-q>"] = map_cmd("<Esc>:wq<CR>"):with_desc("edit: Save file and quit"),
  ["i|<C-h>"] = map_cmd("<Left>"):with_noremap():with_silent():with_desc("edit: Move left"),
  ["i|<C-j>"] = map_cmd("<Down>"):with_noremap():with_silent():with_desc("edit: Move down"),
  ["i|<C-k>"] = map_cmd("<Up>"):with_noremap():with_silent():with_desc("edit: Move up"),
  ["i|<C-l>"] = map_cmd("<Right>"):with_noremap():with_silent():with_desc("edit: Move right"),
  ["i|<C-a>"] = map_cmd("<ESC>^i"):with_noremap():with_silent():with_desc("edit: Move to line start"),
  -- Note: <C-e> in normal mode is now used for Snacks Explorer
  ["i|<C-e>"] = map_cmd("<End>"):with_noremap():with_silent():with_desc("edit: Move to line end"),

  -- Window navigation (replaced by smart-splits)
  ["n|<C-h>"] = map_cu("SmartCursorMoveLeft"):with_silent():with_noremap():with_desc("window: Focus left"),
  ["n|<C-j>"] = map_cu("SmartCursorMoveDown"):with_silent():with_noremap():with_desc("window: Focus down"),
  ["n|<C-k>"] = map_cu("SmartCursorMoveUp"):with_silent():with_noremap():with_desc("window: Focus up"),
  ["n|<C-l>"] = map_cu("SmartCursorMoveRight"):with_silent():with_noremap():with_desc("window: Focus right"),

  -- Resize windows (replaced by smart-splits)
  -- These are kept as a fallback, but smart-splits is preferred using Alt+hjkl
  ["n|<C-Up>"] = map_cmd(":resize +2<CR>"):with_noremap():with_silent():with_desc("window: Increase height"),
  ["n|<C-Down>"] = map_cmd(":resize -2<CR>"):with_noremap():with_silent():with_desc("window: Decrease height"),
  ["n|<C-Left>"] = map_cmd(":vertical resize -2<CR>"):with_noremap():with_silent():with_desc("window: Decrease width"),
  ["n|<C-Right>"] = map_cmd(":vertical resize +2<CR>"):with_noremap():with_silent():with_desc("window: Increase width"),

  -- Move lines up and down
  -- Note: We use Ctrl+Alt+jk instead of Alt+jk to avoid conflict with smart-splits
  ["n|<C-A-j>"] = map_cmd(":m .+1<CR>=="):with_noremap():with_silent():with_desc("edit: Move line down"),
  ["n|<C-A-k>"] = map_cmd(":m .-2<CR>=="):with_noremap():with_silent():with_desc("edit: Move line up"),
  ["i|<C-A-j>"] = map_cmd("<Esc>:m .+1<CR>==gi"):with_noremap():with_silent():with_desc("edit: Move line down"),
  ["i|<C-A-k>"] = map_cmd("<Esc>:m .-2<CR>==gi"):with_noremap():with_silent():with_desc("edit: Move line up"),
  ["v|<C-A-j>"] = map_cmd(":m '>+1<CR>gv=gv"):with_noremap():with_silent():with_desc("edit: Move selection down"),
  ["v|<C-A-k>"] = map_cmd(":m '<-2<CR>gv=gv"):with_noremap():with_silent():with_desc("edit: Move selection up"),

  -- Stay in visual mode when indenting
  ["v|<"] = map_cmd("<gv"):with_noremap():with_silent():with_desc("edit: Indent left and stay in visual mode"),
  ["v|>"] = map_cmd(">gv"):with_noremap():with_silent():with_desc("edit: Indent right and stay in visual mode"),

  -- Buffer navigation
  ["n|<S-h>"] = map_cmd(":bprevious<CR>"):with_noremap():with_silent():with_desc("buffer: Previous buffer"),
  ["n|<S-l>"] = map_cmd(":bnext<CR>"):with_noremap():with_silent():with_desc("buffer: Next buffer"),
  ["n|<leader>bn"] = map_cmd(":enew<CR>"):with_noremap():with_silent():with_desc("buffer: New buffer"),
  ["n|<leader>bw"] = map_callback(function()
    -- Only delete buffer when not last
    if #vim.fn.getbufinfo({ buflisted = 1 }) > 1 then
      vim.cmd("bd")
    else
      vim.notify("Cannot close last buffer", vim.log.levels.WARN)
    end
  end):with_noremap():with_silent():with_desc("Buffer: Close (safe)"),
  ["n|<leader>bo"] = map_callback(function()
    -- Close all buffers except current
    vim.cmd("%bd|e#|bd#")
    vim.notify("Closed all buffers except current", vim.log.levels.INFO)
  end):with_noremap():with_silent():with_desc("Buffer: Close all except current"),
  ["n|<leader><tab>"] = map_cmd("<CMD>b#<CR>"):with_noremap():with_silent():with_desc("Buffer: Switch back & forth"),
  ["n|<C-PageDown>"] = map_cmd("<CMD>bn<CR>"):with_noremap():with_silent():with_desc("Buffer: Next"),
  ["n|<C-PageUp>"] = map_cmd("<CMD>bp<CR>"):with_noremap():with_silent():with_desc("Buffer: Previous"),

  -- Better up/down for wrapped lines
  ["n|j"] = map_cmd("v:count == 0 ? 'gj' : 'j'"):with_expr():with_noremap():with_silent():with_desc("edit: Move down (including wrapped lines)"),
  ["n|k"] = map_cmd("v:count == 0 ? 'gk' : 'k'"):with_expr():with_noremap():with_silent():with_desc("edit: Move up (including wrapped lines)"),

  -- Window management
  ["n|<leader>sv"] = map_cmd(":vsplit<CR>"):with_noremap():with_silent():with_desc("window: Split vertically"),
  ["n|<leader>sh"] = map_cmd(":split<CR>"):with_noremap():with_silent():with_desc("window: Split horizontally"),
  ["n|<leader>sx"] = map_cmd(":close<CR>"):with_noremap():with_silent():with_desc("window: Close window"),
  ["n|<leader>so"] = map_cmd(":only<CR>"):with_noremap():with_silent():with_desc("window: Close other windows"),

  -- Tab management
  ["n|<leader>tn"] = map_cmd(":tabnew<CR>"):with_noremap():with_silent():with_desc("tab: New tab"),
  ["n|<leader>tc"] = map_cmd(":tabclose<CR>"):with_noremap():with_silent():with_desc("tab: Close tab"),
  ["n|<leader>to"] = map_cmd(":tabonly<CR>"):with_noremap():with_silent():with_desc("tab: Close other tabs"),
  ["n|<leader>tl"] = map_cmd(":tabnext<CR>"):with_noremap():with_silent():with_desc("tab: Next tab"),
  ["n|<leader>th"] = map_cmd(":tabprevious<CR>"):with_noremap():with_silent():with_desc("tab: Previous tab"),

  -- Split navigation (Terminal mode)
  ["t|<C-h>"] = map_cmd("<C-\\><C-n><C-w>h"):with_noremap():with_silent():with_desc("window: Focus left"),
  ["t|<C-j>"] = map_cmd("<C-\\><C-n><C-w>j"):with_noremap():with_silent():with_desc("window: Focus down"),
  ["t|<C-k>"] = map_cmd("<C-\\><C-n><C-w>k"):with_noremap():with_silent():with_desc("window: Focus up"),
  ["t|<C-l>"] = map_cmd("<C-\\><C-n><C-w>l"):with_noremap():with_silent():with_desc("window: Focus right"),
}

-- Load essential keymaps immediately (save and quit)
local essential_keymaps = {
  ["n|<leader>qs"] = builtin_map["n|<leader>qs"],
  ["n|<leader>qq"] = builtin_map["n|<leader>qq"],
  ["n|<C-s>"] = builtin_map["n|<C-s>"],
}
bind.nvim_load_mapping(essential_keymaps)

-- Defer loading of other builtin keymaps
vim.defer_fn(function()
  bind.nvim_load_mapping(builtin_map)
end, 10)

-- Snacks cache for lazy loading
local Snacks
local has_loaded_snacks = false

-- Helper function to get Snacks module
local function get_snacks()
  if not has_loaded_snacks then
    has_loaded_snacks = true
    Snacks = require("snacks")
  end
  return Snacks
end

-- Plugin keymaps to be enabled once plugins are configured
-- Add additional utility functions
local misc_map = {
  -- Plugin: smart-splits.nvim
  ["n|<A-h>"] = map_cu("SmartResizeLeft"):with_silent():with_noremap():with_desc("window: Resize -3 left"),
  ["n|<A-j>"] = map_cu("SmartResizeDown"):with_silent():with_noremap():with_desc("window: Resize -3 down"),
  ["n|<A-k>"] = map_cu("SmartResizeUp"):with_silent():with_noremap():with_desc("window: Resize +3 up"),
  ["n|<A-l>"] = map_cu("SmartResizeRight"):with_silent():with_noremap():with_desc("window: Resize +3 right"),
  ["n|<leader>wh"] = map_cu("SmartSwapLeft"):with_silent():with_noremap():with_desc("window: Move window left"),
  ["n|<leader>wj"] = map_cu("SmartSwapDown"):with_silent():with_noremap():with_desc("window: Move window down"),
  ["n|<leader>wk"] = map_cu("SmartSwapUp"):with_silent():with_noremap():with_desc("window: Move window up"),
  ["n|<leader>wl"] = map_cu("SmartSwapRight"):with_silent():with_noremap():with_desc("window: Move window right"),
  -- Folding controls
  ["n|<leader>z0"] = map_callback(function()
    if vim.o.foldlevel == 0 then
      vim.o.foldlevel = 99
    else
      vim.o.foldlevel = 0
    end
  end):with_noremap():with_silent():with_desc("Toggle level 0 folds"),
  
  ["n|<leader>z1"] = map_callback(function()
    if vim.o.foldlevel == 1 then
      vim.o.foldlevel = 99
    else
      vim.o.foldlevel = 1
    end
  end):with_noremap():with_silent():with_desc("Toggle level 1 folds"),
  
  ["n|<leader>z2"] = map_callback(function()
    if vim.o.foldlevel == 2 then
      vim.o.foldlevel = 99
    else
      vim.o.foldlevel = 2
    end
  end):with_noremap():with_silent():with_desc("Toggle level 2 folds"),
  
  -- Enhanced window management
  ["n|<leader>wm"] = map_callback(function()
    local current_win = vim.api.nvim_get_current_win()
    if vim.t.maximized_win == current_win then
      vim.cmd("wincmd =")
      vim.t.maximized_win = nil
    else
      vim.t.maximized_win = current_win
      vim.cmd("wincmd |")
      vim.cmd("wincmd _")
    end
  end):with_noremap():with_silent():with_desc("Window: Toggle maximize"),
}

-- Defer loading of miscellaneous keymaps
vim.defer_fn(function()
  bind.nvim_load_mapping(misc_map)
end, 30)

local plug_map = {
  -- Plugin: ccc (color picker)
  ["n|<leader>cp"] = map_cmd("<CMD>CccPick<CR>"):with_noremap():with_silent():with_desc("Color Picker"),
  ["i|<C-c>"] = map_cmd("<CMD>CccPick<CR>"):with_noremap():with_silent():with_desc("Color Picker"),
  
  -- Plugin: Flash
  ["nxo|s"] = map_cmd("<CMD>lua require('flash').jump()<CR>"):with_noremap():with_silent():with_desc("Flash: Jump"),
  
  -- Profiling tools
  ["n|<leader>pp"] = map_cmd("<CMD>Profile<CR>"):with_noremap():with_silent():with_desc("Generate detailed profile report"),
  ["n|<leader>ps"] = map_cmd("<CMD>ProfileSummary<CR>"):with_noremap():with_silent():with_desc("Show profile summary"),
  ["n|<leader>pL"] = map_cmd("<CMD>ProfileLogs<CR>"):with_noremap():with_silent():with_desc("List profile logs"),
  ["n|<leader>pa"] = map_cmd("<CMD>ProfilePlugins<CR>"):with_noremap():with_silent():with_desc("Analyze plugin performance"),
  ["n|<leader>pc"] = map_cmd("<CMD>ProfileClean<CR>"):with_noremap():with_silent():with_desc("Clean up profile logs"),
  
  -- Plugin: mini.surround keybindings
  ["n|<leader>ua"] = map_callback(function()
    require("mini.surround").add("normal")
  end):with_noremap():with_silent():with_desc("Surround: Add"),
  
  ["n|<leader>ud"] = map_callback(function()
    require("mini.surround").delete()
  end):with_noremap():with_silent():with_desc("Surround: Delete"),
  
  ["n|<leader>ur"] = map_callback(function()
    require("mini.surround").replace()
  end):with_noremap():with_silent():with_desc("Surround: Replace"),
  
  -- File explorer using Snacks Explorer
  ["n|<leader>e"] = map_callback(function()
    ---@diagnostic disable-next-line: missing-fields
    get_snacks().explorer({ cwd = vim.fs.root(0, { ".git" }) })
  end):with_noremap():with_silent():with_desc("explorer: Toggle file explorer"),
  
  ["n|<C-e>"] = map_callback(function()
    ---@diagnostic disable-next-line: missing-fields
    get_snacks().explorer({ cwd = vim.fs.root(0, { ".git" }) })
  end):with_noremap():with_silent():with_desc("explorer: Toggle file explorer"),
  
  -- Fuzzy finder (depends on your fuzzy finder of choice)
  ["n|<leader>ff"] = map_cmd("<Cmd>Telescope find_files<CR>"):with_noremap():with_silent():with_desc("find: Files"),
  ["n|<leader>fg"] = map_cmd("<Cmd>Telescope live_grep<CR>"):with_noremap():with_silent():with_desc("find: Text in files"),
  ["n|<leader>fb"] = map_cmd("<Cmd>Telescope buffers<CR>"):with_noremap():with_silent():with_desc("find: Buffers"),
  ["n|<leader>fh"] = map_cmd("<Cmd>Telescope help_tags<CR>"):with_noremap():with_silent():with_desc("find: Help tags"),
  
  -- Git integration (for lazygit, fugitive, etc.)
  ["n|<leader>gg"] = map_callback(function()
    local snacks = get_snacks()
    local git = require("utils.git")
    if git.is_git_repo() then
      ---@diagnostic disable-next-line: missing-fields
      snacks.lazygit({ cwd = git.get_git_root() })
    elseif vim.bo.filetype == "snacks_dashboard" then
      ---@diagnostic disable-next-line: missing-fields
      snacks.lazygit({ cwd = vim.fn.stdpath("config") })
    else
      print("You're not in a git repository")
    end
  end):with_noremap():with_silent():with_desc("Lazygit"),
  
  ["n|<leader>gl"] = map_callback(function()
    local snacks = get_snacks()
    local git = require("utils.git")
    if git.is_git_repo() then
      ---@diagnostic disable-next-line: missing-fields
      snacks.lazygit.log({ cwd = git.get_git_root() })
    elseif vim.bo.filetype == "snacks_dashboard" then
      ---@diagnostic disable-next-line: missing-fields
      snacks.lazygit.log({ cwd = vim.fn.stdpath("config") })
    else
      print("You're not in a git repository")
    end
  end):with_noremap():with_silent():with_desc("Lazygit log"),
  
  -- LSP related keymaps
  ["n|gd"] = map_cmd("<Cmd>lua vim.lsp.buf.definition()<CR>"):with_noremap():with_silent():with_desc("lsp: Go to definition"),
  ["n|gD"] = map_cmd("<Cmd>lua vim.lsp.buf.declaration()<CR>"):with_noremap():with_silent():with_desc("lsp: Go to declaration"),
  ["n|gr"] = map_cmd("<Cmd>lua vim.lsp.buf.references()<CR>"):with_noremap():with_silent():with_desc("lsp: Find references"),
  ["n|gi"] = map_cmd("<Cmd>lua vim.lsp.buf.implementation()<CR>"):with_noremap():with_silent():with_desc("lsp: Go to implementation"),
  ["n|K"] = map_cmd("<Cmd>lua vim.lsp.buf.hover()<CR>"):with_noremap():with_silent():with_desc("lsp: Hover documentation"),
  ["n|<leader>ca"] = map_cmd("<Cmd>lua require('actions-preview').code_actions()<CR>"):with_noremap():with_silent():with_desc("Code Actions"),
  ["n|<leader>rn"] = map_cmd("<Cmd>lua vim.lsp.buf.rename()<CR>"):with_noremap():with_silent():with_desc("lsp: Rename"),
  ["n|<leader>D"] = map_cmd("<Cmd>lua vim.lsp.buf.type_definition()<CR>"):with_noremap():with_silent():with_desc("lsp: Type definition"),
  ["n|<leader>f"] = map_cmd("<Cmd>lua vim.lsp.buf.format()<CR>"):with_noremap():with_silent():with_desc("lsp: Format code"),
  
  -- Diagnostics
  ["n|<leader>d"] = map_cmd("<Cmd>lua vim.diagnostic.open_float()<CR>"):with_noremap():with_silent():with_desc("lsp: Show diagnostics"),
  ["n|[d"] = map_cmd("<Cmd>lua vim.diagnostic.goto_prev()<CR>"):with_noremap():with_silent():with_desc("lsp: Previous diagnostic"),
  ["n|]d"] = map_cmd("<Cmd>lua vim.diagnostic.goto_next()<CR>"):with_noremap():with_silent():with_desc("lsp: Next diagnostic"),
  
  -- Trouble diagnostics
  ["n|<leader>xw"] = map_cmd("<CMD>Trouble diagnostics toggle<CR>")
    :with_noremap()
    :with_silent()
    :with_desc("Trouble: workspace diagnostics"),
  ["n|<leader>xx"] = map_cmd("<CMD>Trouble diagnostics toggle filter.buf=0<CR>")
    :with_noremap()
    :with_silent()
    :with_desc("Trouble: document diagnostics"),
  ["n|<leader>xq"] = map_cmd("<CMD>Trouble quickfix toggle<CR>")
    :with_noremap()
    :with_silent()
    :with_desc("Trouble: quickfix list"),
  
  -- Terminal integration
  ["n|<leader>t"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("terminal: Toggle"),
  ["t|<Esc>"] = map_cmd("<C-\\><C-n>"):with_noremap():with_silent():with_desc("terminal: Exit terminal mode"),
}

-- Defer loading of plugin keymaps
vim.defer_fn(function()
  bind.nvim_load_mapping(plug_map)
end, 20)

-- Set up which-key integration with comprehensive icons
vim.defer_fn(function()
  -- Use pcall to handle when which-key isn't available
  local status, wk = pcall(require, "which-key")
  if not status then
    return
  end
  
  -- Main keymaps with icons
  wk.add({
    mode = "n",
    -- Explorer
    { "<leader>e", desc = "Explorer", icon = "" },
    
    -- Telescope
    { "<leader>ff", desc = "Find files", icon = "" },
    { "<leader>fg", desc = "Find text", icon = "" },
    { "<leader>fb", desc = "Find buffers", icon = "" },
    { "<leader>fh", desc = "Find help", icon = "" },
    
    -- Profiling
    { "<leader>p", group = "Profiling", icon = "⏱️" },
    { "<leader>pp", desc = "Generate profile report", icon = "📊" },
    { "<leader>ps", desc = "Show profile summary", icon = "📈" },
    { "<leader>pL", desc = "List profile logs", icon = "📋" },
    { "<leader>pa", desc = "Analyze plugin performance", icon = "🔍" },
    { "<leader>pc", desc = "Clean up profile logs", icon = "🗑️" },
    
    -- Git
    { "<leader>gg", desc = "Lazygit", icon = "󰒲" },
    { "<leader>gl", desc = "Lazygit log", icon = "" },
    
    -- LSP
    { "<leader>ca", desc = "Code Actions", icon = "" },
    { "<leader>rn", desc = "Rename", icon = "" },
    { "<leader>f", desc = "Format code", icon = "" },
    
    -- Trouble diagnostics
    { "<leader>xw", desc = "Trouble: workspace diagnostics", icon = "" },
    { "<leader>xx", desc = "Trouble: document diagnostics", icon = "" },
    { "<leader>xq", desc = "Trouble: quickfix list", icon = "" },
    
    -- Terminal
    { "<leader>t", desc = "Toggle terminal", icon = "" },
    
    -- Buffer navigation
    { "<leader><tab>", desc = "Buffer: Switch back & forth", icon = "" },
    { "<leader>bn", desc = "New buffer", icon = "+" },
    { "<leader>bw", desc = "Close buffer (safe)", icon = "󰅖" },
    { "<leader>bo", desc = "Close all buffers except current", icon = "󰆐" },
    
    -- Window management
    { "<leader>wm", desc = "Toggle maximize window", icon = "󰆟" },
    { "<leader>wh", desc = "Move window left", icon = "←" },
    { "<leader>wj", desc = "Move window down", icon = "↓" },
    { "<leader>wk", desc = "Move window up", icon = "↑" },
    { "<leader>wl", desc = "Move window right", icon = "→" },
    { "<leader>sv", desc = "Split vertically", icon = "│" },
    { "<leader>sh", desc = "Split horizontally", icon = "─" },
    { "<leader>sx", desc = "Close window", icon = "✗" },
    { "<leader>so", desc = "Close other windows", icon = "󰝦" },
    
    -- Tabs
    { "<leader>tn", desc = "New tab", icon = "+" },
    { "<leader>tc", desc = "Close tab", icon = "✗" },
    { "<leader>to", desc = "Close other tabs", icon = "󰝦" },
    { "<leader>tl", desc = "Next tab", icon = "→" },
    { "<leader>th", desc = "Previous tab", icon = "←" },
    
    -- File operations
    { "<leader>qs", desc = "Save file", icon = "💾" },
    { "<leader>qq", desc = "Save and quit", icon = "🚪" },
    { "<leader>qf", desc = "Force quit all", icon = "🔴" },
    { "<leader>qx", desc = "Save all and quit", icon = "📁" },
    { "<leader>qz", desc = "Force quit", icon = "󰝥" },
    
    -- Folding controls
    { "<leader>z0", desc = "Toggle level 0 folds", icon = "󰈔" },
    { "<leader>z1", desc = "Toggle level 1 folds", icon = "󰈕" },
    { "<leader>z2", desc = "Toggle level 2 folds", icon = "󰈖" },
    
    -- Surround operations
    { "<leader>ua", desc = "Surround: Add", icon = "" },
    { "<leader>ud", desc = "Surround: Delete", icon = "" },
    { "<leader>ur", desc = "Surround: Replace", icon = "󰏫" },
    
    -- Color Picker
    { "<leader>cp", desc = "Color Picker", icon = "󰏘" },
    
    -- Flash
    { "s", desc = "Flash: Jump", icon = "󰸱" },
  })
end, 30)

-- Load user keymaps if available
pcall(require, "user.keymaps")