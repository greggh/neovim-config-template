-- lua/plugins/snacks/init.lua

return {
  "folke/snacks.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", {
      -- Snacks core configuration
      pin_hover_to_cursor = true,
      hover_width = 80,
      hover_min_width = 40,
      hover_markdown = true,
      hover_wrap = true,
      border = "rounded",
      blur = false,
    }, opts or {})
  end,
}