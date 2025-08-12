-- Load compatibility layer first
require("cargdev.core.compatibility").setup()

require("cargdev.core.options")
require("cargdev.core.keymaps")

-- Load all Lua files inside `cargdev/core/function/` AFTER plugins are loaded
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

-- Defer function loading until after plugins are loaded
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    -- Force apply colorscheme after plugins are loaded
    vim.defer_fn(function()
      local ok, _ = pcall(vim.cmd, "colorscheme cargdev-cyberpunk")
      if not ok then
        vim.cmd("colorscheme desert")
      end
    end, 100)
    
    -- Load all functions
    load_functions()
  end,
  once = true,
})

-- Fallback: also try to load on VimEnter if LazyDone doesn't fire
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Wait a bit for plugins to load
    vim.defer_fn(function()
      -- Try to apply colorscheme
      local ok, _ = pcall(vim.cmd, "colorscheme cargdev-cyberpunk")
      if not ok then
        vim.cmd("colorscheme desert")
      end
      
      -- Load functions
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
