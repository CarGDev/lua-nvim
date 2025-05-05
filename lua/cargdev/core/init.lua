require("cargdev.core.options")
require("cargdev.core.keymaps")

-- Load all Lua files inside `cargdev/core/function/`
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


--[[ vim.api.nvim_create_autocmd("BufReadPost", {
  once = true,
  callback = function()
    require("cargdev.core.project_config").bootstrap_config()
  end
})
 ]]
load_functions()
