-- plugins/which-key/init.lua

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = vim.o.timeoutlen,
    triggers = {
      { "<auto>", mode = "nixso" },
    },
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        motions = false,
        operators = false,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    win = {
      border = "rounded",
      padding = { 1, 2 },
      wo = { winblend = 0 },
    },
    expand = 1,
    spec = {
      { "<leader>b", group = "Buffers", icon = "" },
      { "<leader>c", group = "Code & Commands", icon = "" },
      { "<leader>d", group = "Diagnostics", icon = "" },
      { "<leader>f", group = "Files", icon = "" },
      { "<leader>g", group = "Git", icon = "" },
      { "<leader>l", group = "LSP", icon = "󱜙" },
      { "<leader>p", group = "Packages & Profiling", icon = "" },
      { "<leader>q", group = "Quit & Save", icon = "" },
      { "<leader>s", group = "Split/Sessions", icon = "" },
      { "<leader>t", group = "Terminal/Tabs", icon = "" },
      { "<leader>u", group = "Surround", icon = "󰰑" },
      { "<leader>w", group = "Windows", icon = "荒" },
      { "<leader>x", group = "Trouble/Diagnostics", icon = "" },
      { "<leader>z", group = "Folds", icon = "󰈔" },
    },
  },
}