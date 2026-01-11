
-- =============================================================================
-- cargdev/core/init.lua
-- Main core initialization for cargdev Neovim config
-- =============================================================================

-- 0. Setup LuaRocks path for rest.nvim dependencies (Lua 5.1 - Neovim uses LuaJIT)
local function setup_luarocks_path()
  local luarocks_path = vim.fn.system("luarocks path --lr-path --lua-version=5.1 --local 2>/dev/null"):gsub("\n", "")
  if luarocks_path and luarocks_path ~= "" then
    package.path = package.path .. ";" .. luarocks_path
  end
end
setup_luarocks_path()

-- 1. Compatibility Layer
require("cargdev.core.compatibility").setup()

-- 2. Core Options and Keymaps
require("cargdev.core.options")
require("cargdev.core.keymaps")

-- 3. Utility: Load all Lua files inside `cargdev/core/function/` AFTER plugins are loaded
local function load_functions()
  local function_path = vim.fn.stdpath("config") .. "/lua/cargdev/core/function"
  local scan = vim.fn.globpath(function_path, "*.lua", false, true)
  for _, file in ipairs(scan) do
    local module_name = "cargdev.core.function." .. file:match("([^/]+)%.lua$")
    local success, err = pcall(require, module_name)
    if not success then
      vim.notify("Error loading function module: " .. module_name .. "\n" .. err, vim.log.levels.ERROR)
    end
  end
end

-- 4. Fix: Force filetype detection on BufRead (fix for nvim-tree/plain text issue)
-- Only run if filetype is not already detected to avoid redundant calls
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "" then
      vim.cmd("silent filetype detect")
    end
  end,
})

-- 5. Load functions on VimEnter to ensure plugins are loaded first
-- Using a flag to prevent double-loading
local functions_loaded = false
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if not functions_loaded then
      vim.defer_fn(function()
        load_functions()
        functions_loaded = true
      end, 200)
    end
  end,
  once = true,
})

-- 6. Diagnostic float on hover (show diagnostics when cursor holds)
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})

-- 7. Configuration validation on startup
local function validate_config()
  local warnings = {}

  -- Check Neovim version (require 0.9+)
  if vim.fn.has("nvim-0.9") == 0 then
    table.insert(warnings, "Neovim 0.9+ is recommended for this configuration")
  end

  -- Check for required executables
  local required_executables = { "git", "rg", "node" }
  for _, exe in ipairs(required_executables) do
    if vim.fn.executable(exe) == 0 then
      table.insert(warnings, string.format("'%s' not found in PATH", exe))
    end
  end

  -- Display warnings if any
  if #warnings > 0 then
    vim.defer_fn(function()
      for _, warning in ipairs(warnings) do
        vim.notify("Config Warning: " .. warning, vim.log.levels.WARN)
      end
    end, 1000)
  end
end

-- Run validation on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = validate_config,
  once = true,
})

-- 8. Custom health check command
vim.api.nvim_create_user_command("CheckConfig", function()
  vim.cmd("checkhealth")
end, { desc = "Run Neovim health check" })
