-- plugins/indent/indent-blankline.lua

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("ibl").setup({
      indent = {
        char = "│",
      },
      scope = { enabled = true },
    })
  end,
}