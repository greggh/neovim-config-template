-- plugins/colorscheme/catppuccin.lua

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Load early
  lazy = false,    -- Load at startup
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        snacks = true,
        treesitter = true,
        notify = true,
        which_key = true,
      },
    })
    
    -- Apply colorscheme
    vim.cmd.colorscheme("catppuccin")
  end,
}