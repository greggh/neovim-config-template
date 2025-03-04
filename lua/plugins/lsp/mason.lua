-- plugins/lsp/mason.lua

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
    
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        -- Add other LSP servers as needed
      },
      automatic_installation = true,
    })
  end,
}