-- Load compatibility layer first
require("cargdev.core.compatibility").setup()

-- Load startup optimizations early
require("cargdev.core.startup_optimization")

require("cargdev.core.options")
require("cargdev.core.keymaps")

-- Load all Lua files inside `cargdev/core/function/` AFTER plugins are loaded
local function load_functions()
  local function_path = vim.fn.stdpath("config") .. "/lua/cargdev/core/function"
  local scan = vim.fn.globpath(function_path, "*.lua", false, true)

  for _, file in ipairs(scan) do
    local module_name = "cargdev.core.function." .. file:match("([^/]+)%.lua$")
    -- Skip notification manager as it's loaded separately
    if module_name ~= "cargdev.core.function.notification_manager" then
      local success, err = pcall(require, module_name)

      if not success then
        vim.notify("Error loading function module: " .. module_name .. "\n" .. err, vim.log.levels.ERROR)
      end
    end
  end
end

-- Defer function loading until after plugins are loaded
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    -- Load notification manager after plugins with error handling
    local success, err = pcall(require, "cargdev.core.function.notification_manager")
    if not success then
      -- Use safe echo instead of vim.notify to avoid circular dependency
      local safe_msg = tostring(err):gsub("'", "\\'")
      vim.api.nvim_echo({{"Warning: Notification manager failed to load: " .. safe_msg, "WarningMsg"}}, false, {})
    end
    
    -- Load all other functions
    load_functions()
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
