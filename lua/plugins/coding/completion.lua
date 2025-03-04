-- plugins/coding/completion.lua

local sources_default = {
  "lsp",
  "path",
  "buffer",
  "snippets",
}

local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

return {
  "saghen/blink.cmp",
  event = { "InsertEnter" },
  dependencies = {
    "saghen/blink.compat",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
  },
  version = "*",
  -- Removed monkey patching of blink.cmp window functions
  -- This is a better approach than patching someone else's code
  lazy = true,
  opts = {
    -- don't show completions or signature help for these filetypes
    enabled = function()
      local ignore_filetypes = { "TelescopePrompt", "norg" }
      return not vim.tbl_contains(ignore_filetypes, vim.bo.filetype)
    end,
    keymap = {
      preset = "default", -- "default" | "enter" | "super-tab"
      ["<CR>"] = { "accept", "fallback" },
      ["<C-p>"] = { "show", "select_prev", "fallback" },
      ["<C-n>"] = { "show", "select_next", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
    },

    appearance = {
      nerd_font_variant = "normal",
      kind_icons = {
        Array = "  ",
        Boolean = " 󰨙 ",
        Class = " 󰯳 ",
        Codeium = " 󰘦 ",
        Color = " 󰰠 ",
        Control = "  ",
        Collapsed = " > ",
        Constant = " 󰯱 ",
        Constructor = "  ",
        Copilot = "  ",
        Enum = " 󰯹 ",
        EnumMember = "  ",
        Event = "  ",
        Field = "  ",
        File = "  ",
        Folder = "  ",
        Function = " 󰡱 ",
        Interface = " 󰰅 ",
        Key = "  ",
        Keyword = " 󱕴 ",
        Method = " 󰰑 ",
        Module = " 󰆼 ",
        Namespace = " 󰰔 ",
        Null = "  ",
        Number = " 󰰔 ",
        Object = " 󰲟 ",
        Operator = "  ",
        Package = " 󰰚 ",
        Property = " 󰲽 ",
        Reference = " 󰰠 ",
        Snippet = "  ",
        String = "  ",
        Struct = " 󰰣 ",
        TabNine = " 󰏚 ",
        Text = " 󱜥 ",
        TypeParameter = " 󰰦 ",
        Unit = " 󱜥 ",
        Value = "  ",
        Variable = " 󰫧 ",
      },
    },

    completion = {
      accept = { auto_brackets = { enabled = true } },
      documentation = {
        auto_show = true,
        window = { border = border },
      },
      list = { selection = { preselect = false, auto_insert = false } },
      menu = {
        auto_show = true,
        border = border,
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "source_name" },
          },
          treesitter = { "lsp" },
        },
      },
    },

    signature = {
      enabled = true,
      window = { border = border },
    },

    snippets = { preset = "luasnip" },

    cmdline = {
      sources = {},
    },

    sources = {
      default = sources_default,

      providers = {
        lsp = {
          name = "lsp",
          module = "blink.cmp.sources.lsp",
          fallbacks = { "buffer" },
        },
        path = {
          name = "path",
          module = "blink.cmp.sources.path",
          fallbacks = { "buffer", "snippets" },
        },
        buffer = {
          name = "buffer",
          module = "blink.cmp.sources.buffer",
        },
        snippets = {
          name = "snippets",
          module = "blink.cmp.sources.snippets",
        },
        cmdline_history_cmd = {
          name = "cmdline_history",
          module = "blink.compat.source",
          max_items = 5,
          score_offset = -2,
          opts = {
            history_type = "cmd",
          },
        },
        cmdline_history_search = {
          name = "cmdline_history",
          module = "blink.compat.source",
          max_items = 5,
          score_offset = -2,
          opts = {
            history_type = "search",
          },
        },
      },
    },
  },

  opts_extend = { "sources.default" },
}