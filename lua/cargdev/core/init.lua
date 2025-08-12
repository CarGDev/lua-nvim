
-- =============================================================================
-- cargdev/core/init.lua
-- Main core initialization for cargdev Neovim config
-- =============================================================================

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

--[[ vim.api.nvim_create_autocmd("BufReadPost", {
  once = true,
  callback = function()
    require("cargdev.core.project_config").bootstrap_config()
  end
})
 ]]
