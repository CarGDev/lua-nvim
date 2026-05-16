-- Compatibility layer for Lua version differences and deprecated APIs
local M = {}

-- Handle Lua version compatibility
local lua_version = _VERSION:match("%d+%.%d+")
if lua_version then
  lua_version = tonumber(lua_version)
end

-- Create compatibility functions for deprecated APIs
if not vim.iter then
  -- Fallback for older Neovim versions
  vim.iter = function(t)
    local i = 0
    local n = #t
    return function()
      i = i + 1
      if i <= n then
        return i, t[i]
      end
    end
  end
end

-- Modern vim.hl replacement for vim.highlight
if not vim.hl then
  vim.hl = function(namespace, name, val)
    if vim.fn.hlexists(name) == 1 then
      vim.api.nvim_set_hl(namespace, name, val)
    end
  end
end

-- Modern vim.validate replacement
local function modern_validate(name, value, validator, optional_or_msg)
  if type(validator) == "string" then
    -- Old style: vim.validate{name = {value, "string"}}
    if type(value) ~= validator then
      error(string.format("Expected %s to be %s, got %s", name, validator, type(value)))
    end
  elseif type(validator) == "function" then
    -- New style: vim.validate(name, value, validator, optional_or_msg)
    if not validator(value) then
      local msg = optional_or_msg or string.format("Validation failed for %s", name)
      error(msg)
    end
  end
end

if not vim.validate then
  vim.validate = modern_validate
end

-- Modern vim.tbl_flatten replacement
if not vim.tbl_flatten then
  vim.tbl_flatten = function(t)
    local result = {}
    for _, v in ipairs(t) do
      if type(v) == "table" then
        for _, sub_v in ipairs(v) do
          table.insert(result, sub_v)
        end
      else
        table.insert(result, v)
      end
    end
    return result
  end
end

-- Ensure proper Lua runtime path for Lua 5.4 compatibility
local function setup_lua_runtime()
  -- Add Lua paths for better compatibility
  local lua_paths = {
    "?.lua",
    "?/init.lua",
    "?/main.lua",
    vim.fn.stdpath("config") .. "/lua/?.lua",
    vim.fn.stdpath("config") .. "/lua/?/init.lua",
    vim.fn.stdpath("data") .. "/lazy/*/lua/?.lua",
    vim.fn.stdpath("data") .. "/lazy/*/lua/?/init.lua",
  }

  package.path = table.concat(lua_paths, ";") .. ";" .. package.path
end

-- Setup Lua language server with proper configuration
local function setup_lua_ls()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
          disable = { "missing-fields" },
        },
        runtime = {
          version = "LuaJIT",
          path = {
            "?.lua",
            "?/init.lua",
            "?/main.lua",
            vim.fn.stdpath("config") .. "/lua/?.lua",
            vim.fn.stdpath("config") .. "/lua/?/init.lua",
            vim.fn.stdpath("data") .. "/lazy/*/lua/?.lua",
            vim.fn.stdpath("data") .. "/lazy/*/lua/?/init.lua",
          },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.fn.stdpath("config") .. "/lua",
            vim.fn.stdpath("data") .. "/lazy",
            "/opt/homebrew/Cellar/neovim/0.11.3/share/nvim/runtime/lua",
          },
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })
end

-- Initialize compatibility layer
function M.setup()
  setup_lua_runtime()

  -- Setup Lua LSP when available
  local ok, _ = pcall(require, "lspconfig")
  if ok then
    setup_lua_ls()
  end

  -- Disable deprecated API warnings
  vim.deprecate = function() end

  -- Set up proper error handling for deprecated functions
  local original_error = error
  error = function(msg, level)
    if type(msg) == "string" and msg:match("deprecated") then
      return
    end
    return original_error(msg, level)
  end
end

return M

