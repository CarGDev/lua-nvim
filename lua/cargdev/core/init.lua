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
local function setup_luarocks_path()
  local luarocks_path = vim.fn.system("luarocks path --lr-path --lua-version=5.1 --local"):gsub("\n", "")
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
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
  callback = function()
    vim.cmd("filetype detect")
  end,
})

-- 5. Load functions immediately
load_functions()

-- 6. Fallback: also try to load on VimEnter if LazyDone doesn't fire
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Wait a bit for plugins to load
    vim.defer_fn(function()
      load_functions()
    end, 200)
  end,
  once = true,
})

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
