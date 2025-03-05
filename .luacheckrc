-- .luacheckrc
-- Luacheck configuration for Neovim config

-- Global objects defined by Neovim
globals = {
  "vim",
}

-- Exclude these files from checks
exclude_files = {
  "tests/fixtures/*",
  ".luarocks/*",
  ".install/*",
}

-- Special configuration for scripts
files["scripts/**/*.lua"] = {
  globals = {
    "print", "arg",
  },
}

-- Ignore unused variables for scripts
unused_secondaries = false
unused = false

-- Ignore these warnings
ignore = {
  "212", -- Unused argument (useful for callbacks)
  "631", -- Line is too long (handled by StyLua)
}

-- Max line length check
max_line_length = 120

-- Redefine these globals to avoid warnings
read_globals = {
  "describe",
  "it",
  "before_each",
  "after_each",
  "teardown",
  "pending",
  "assert",
}