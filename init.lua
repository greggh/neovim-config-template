-- init.lua
-- Entry point for Neovim configuration

-- Load profiling module with error handling
local profile_module
pcall(function()
  profile_module = require("utils.profile").setup()

  -- Register global access to profiling module for easier debugging
  _G.profile_module = profile_module

  -- Record events if profiling is enabled
  if os.getenv("NVIM_PROFILE") then
    profile_module.record_event("profile_module_loaded")
    profile_module.record_event("init_start")
  end
end)

-- Track startup time with more granular logging
local startup_time = os.clock()
local module_timing = {}

-- Set leader key before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Function to track module load times
local function track(name)
  local start = os.clock()
  local module = require(name)
  local duration = os.clock() - start
  table.insert(module_timing, { name = name, time = duration })

  -- Record in profile module if profiling is enabled
  if os.getenv("NVIM_PROFILE") and profile_module then
    pcall(function()
      profile_module.record_event("load_" .. name)
      profile_module.record_plugin(name, duration)
    end)
  end

  return module
end

-- Use a single table to track timing information
local timing = {
  start = startup_time,
  modules = {},
  events = {},
}

-- Track timing for a named event
local function mark_event(name)
  local now = os.clock()
  local duration = now - timing.start
  timing.events[name] = {
    time = duration,
    timestamp = now,
  }

  -- Record in profile module if profiling is enabled
  if os.getenv("NVIM_PROFILE") and profile_module then
    pcall(function()
      profile_module.record_event(name)
    end)
  end

  return now
end

-- Load core configuration modules
track("config.options")    -- Vim/Neovim options
track("config.keymaps")    -- Key mappings
track("config.autocmd")    -- Auto commands
track("config.lazy")       -- Plugin management with lazy.nvim

-- Mark event after core modules are loaded
mark_event("core_modules_loaded")

-- Register UI Enter event
vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    mark_event("ui_enter")
  end,
  once = true,
})

-- Register lazy.nvim events
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    mark_event("lazy_done")
  end,
  once = true,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    mark_event("very_lazy")
  end,
  once = true,
})

-- Report startup time - enhanced with module timing when NVIM_PROFILE is set
if os.getenv("NVIM_PROFILE") then
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      local end_time = os.clock()
      mark_event("vim_enter")
      local total_time = (end_time - startup_time) * 1000

      -- Create log file paths - one with timestamp for history, one latest
      local timestamp = os.date("%Y%m%d_%H%M%S")
      local log_path = vim.fn.stdpath("cache") .. "/nvim_startup_" .. timestamp .. ".log"
      local latest_log_path = vim.fn.stdpath("cache") .. "/nvim_startup.log"

      -- Generate log content
      local log_content = string.format("Neovim Startup: %.2f ms total\n\n", total_time)

      -- Log events timing
      log_content = log_content .. "Events:\n"
      local sorted_events = {}
      for event, _ in pairs(timing.events) do
        table.insert(sorted_events, event)
      end
      table.sort(sorted_events)

      for _, event in ipairs(sorted_events) do
        local time_ms = timing.events[event].time * 1000
        log_content = log_content .. string.format("- %s: %.2f ms\n", event, time_ms)
      end

      -- Module loading times
      log_content = log_content .. "\nModule loading times:\n"
      for _, mod in ipairs(module_timing) do
        local time_ms = mod.time * 1000
        log_content = log_content .. string.format("- %s: %.2f ms\n", mod.name, time_ms)
      end

      -- System information for comparison
      log_content = log_content .. "\nSystem Information:\n"
      log_content = log_content .. string.format("- Neovim Version: %s\n", vim.version())

      -- Memory usage
      local memory_info = vim.loop.resident_set_memory()
      log_content = log_content .. string.format("- Memory Usage: %.2f MB\n", memory_info / 1024 / 1024)

      -- Write to timestamped log file
      local log_file = io.open(log_path, "w")
      if log_file then
        log_file:write(log_content)
        log_file:close()
      end

      -- Also write to latest log file
      local latest_log_file = io.open(latest_log_path, "w")
      if latest_log_file then
        latest_log_file:write(log_content)
        latest_log_file:close()

        print(string.format("Startup Time: %.2f ms (details in %s)", total_time, latest_log_path))
      else
        print(string.format("Startup Time: %.2f ms", total_time))
      end

      -- Run our separate profiler too (for more details)
      vim.defer_fn(function()
        if profile_module then
          pcall(function()
            profile_module.write_profile_log()
          end)
        end
      end, 1000) -- Wait a bit to ensure everything is loaded
    end,
  })

  -- Set up profiling keymaps after startup
  vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
      vim.defer_fn(function()
        if profile_module then
          -- Update keymaps for profiling
          local keymap_cmd = vim.keymap.set
          keymap_cmd("n", "<leader>pp", "<cmd>Profile<CR>", { silent = true, desc = "Generate profile report" })
          keymap_cmd("n", "<leader>ps", "<cmd>ProfileSummary<CR>", { silent = true, desc = "Show profile summary" })
          keymap_cmd("n", "<leader>pL", "<cmd>ProfileLogs<CR>", { silent = true, desc = "List profile logs" })
          keymap_cmd("n", "<leader>pa", "<cmd>ProfilePlugins<CR>", { silent = true, desc = "Analyze plugin performance" })
          keymap_cmd("n", "<leader>pc", "<cmd>ProfileClean<CR>", { silent = true, desc = "Clean up profile logs" })
        end
      end, 500) -- Short delay to ensure everything is loaded
    end,
    once = true,
  })
end

-- User configuration can be placed in lua/user directory
-- This allows for user-specific configuration without modifying core files
pcall(require, "user.init")