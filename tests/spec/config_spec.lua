-- config_spec.lua
-- Tests for Neovim configuration functionality

describe("Neovim configuration", function()
  -- Basic functionality tests
  describe("basic functionality", function()
    it("has leader key set to space", function()
      assert.equal(" ", vim.g.mapleader)
    end)

    it("can access vim.o for options", function()
      assert.truthy(vim.o ~= nil)
    end)
  end)

  -- Testing Neovim API access
  describe("Neovim API", function()
    it("can access vim global", function()
      assert.truthy(vim ~= nil)
    end)

    it("can access vim.api", function()
      assert.truthy(vim.api ~= nil)
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
