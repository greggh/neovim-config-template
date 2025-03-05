-- config_spec.lua
-- Tests for Neovim configuration functionality

describe("Neovim configuration", function()
  -- Basic functionality tests
  describe("basic functionality", function()
    it("has leader key set to space", function()
      assert.equal(" ", vim.g.mapleader)
    end)
    
    it("has termguicolors enabled", function()
      assert.truthy(vim.opt.termguicolors:get())
    end)
  end)
  
  -- Module loading tests
  describe("module loading", function()
    it("can load core modules", function()
      -- No errors should be raised when loading these modules
      assert.has_no.errors(function()
        -- Check that we can load key configuration modules
        -- These paths should be adjusted based on your actual config structure
        require("core.options")
      end)
    end)
  end)
  
  -- This is a placeholder test that always passes
  -- Replace with actual tests based on your configuration
  describe("configuration", function()
    it("passes basic configuration test", function()
      assert.truthy(true)
    end)
  end)
end)