-- plugins/coding/cmdline.lua

return {
  "saghen/blink.cmp",
  dependencies = { "saghen/blink.compat" },
  event = { "CmdlineEnter" },
  init = function()
    local blink = require("blink.cmp")
    
    -- Command-line configuration for '/' (search mode)
    vim.api.nvim_create_autocmd("CmdlineEnter", {
      pattern = "/,?",
      callback = function()
        blink.show_cmdline({
          sources = {
            "cmdline_history_search",
            "buffer",
          },
        })
      end,
    })
    
    -- Command-line configuration for ':' (command mode)
    vim.api.nvim_create_autocmd("CmdlineEnter", {
      pattern = ":",
      callback = function()
        blink.show_cmdline({
          sources = {
            "cmdline_history_cmd",
            "path",
          },
        })
      end,
    })
  end,
}