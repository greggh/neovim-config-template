-- Minimal test runtime that properly mocks necessary Neovim APIs
-- Create a proper mock Neovim environment for tests
vim = vim or {}
vim.g = { mapleader = " " }
vim.o = {}
vim.api = {}
vim.fn = {}
vim.cmd = function() end

-- Proper test framework
_G.describe = function(name, fn)
  print("\nTEST GROUP: " .. name)
  fn()
end

_G.it = function(name, fn)
  local status, err = pcall(fn)
  if status then
    print("  PASS: " .. name)
  else
    print("  FAIL: " .. name .. " - " .. tostring(err))
    os.exit(1) -- Exit with error to properly report test failures
  end
end

-- Test assertion library
_G.assert = {
  equal = function(expected, actual)
    if expected ~= actual then
      error("Expected: " .. tostring(expected) .. ", got: " .. tostring(actual))
    end
    return true
  end,

  truthy = function(value)
    if not value then
      error("Expected value to be truthy, got: " .. tostring(value))
    end
    return true
  end,

  has_no = {
    errors = function(fn)
      local status, err = pcall(fn)
      if not status then
        error("Expected no errors, but got: " .. tostring(err))
      end
      return true
    end,
  },
}
