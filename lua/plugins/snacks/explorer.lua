-- lua/plugins/snacks/explorer.lua

return {
  "snacks.nvim",
  opts = {
    explorer = {
      replace_netrw = false,
    },
    picker = {
      sources = {
        explorer = {
          auto_close = false,
          hidden = true,
        },
      },
    },
  },
}