-- =============================================================================
-- cargdev/core/init.lua
-- Main core initialization for cargdev Neovim config
-- =============================================================================
--- 0. Load Local configuration (gitignored, contains personal paths)
local function load_local_config()
  local ok, local_config = pcall(require, "cargdev.core.local")
  if ok then
    vim.g.cargdev_local = local_config
    return local_config
  else
    vim.g.cargdev_local = {}
    return {}
  end
end

load_local_config()

-- 0. Setup LuaRocks path for rest.nvim dependencies (Lua 5.1 - Neovim uses LuaJIT)
-- The `luarocks path` shell call is slow, so its result is cached on disk.
-- Delete the cache file to refresh it (e.g. after installing new rocks).
local function setup_luarocks_path()
  local cache_file = vim.fn.stdpath("cache") .. "/luarocks_path"
  local luarocks_path = ""

  local f = io.open(cache_file, "r")
  if f then
    luarocks_path = f:read("*a") or ""
    f:close()
  end

  if luarocks_path == "" then
    luarocks_path = vim.fn.system("luarocks path --lr-path --lua-version=5.1 --local"):gsub("\n", "")
    if vim.v.shell_error == 0 and luarocks_path ~= "" then
      vim.fn.mkdir(vim.fn.fnamemodify(cache_file, ":h"), "p")
      local out = io.open(cache_file, "w")
      if out then
        out:write(luarocks_path)
        out:close()
      end
    else
      luarocks_path = ""
    end
  end

  if luarocks_path ~= "" then
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

-- 5. Load functions immediately
load_functions()

-- lua/core/autocmds.lua
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "/Users/carlos/Documents/projects/nvim.plugins/cargdevschemecolor.nvim/**/*.lua",
  callback = function()
    for name, _ in pairs(package.loaded) do
      if name:match("^cargdev%-cyberpunk") then
        package.loaded[name] = nil
      end
    end
    vim.cmd("colorscheme cargdev-cyberpunk")
    vim.notify("cargdev-cyberpunk reloaded", vim.log.levels.INFO)
  end,
})
