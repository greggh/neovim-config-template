-- plugins/snacks/lazygit.lua

return {
  "snacks.nvim",
  opts = {
    lazygit = {
      enabled = true,
      win = {
        style = {
          width = 0,
          height = 0,
        },
      },
      theme = {
        [241] = { fg = "Special" },
        defaultFgColor = { fg = "Normal" },
        activeBorderColor = { fg = "DiagnosticError", bold = true },
        inactiveBorderColor = { fg = "Comment" },
        optionsTextColor = { fg = "Function" },
        selectedLineBgColor = { bg = "Visual" },
        unstagedChangesColor = { fg = "DiagnosticError" },
        cherryPickedCommitBgColor = { bg = "default" },
        cherryPickedCommitFgColor = { fg = "Identifier" },
        searchingActiveBorderColor = { fg = "MatchParen", bold = true },
      },
    },
  },
}