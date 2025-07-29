-- Main keymaps loader
-- This file loads all keymap files from the keymaps/ folder

-- =============================================================================
-- KEYMAPS LOADER
-- =============================================================================

-- Load all keymap files from the keymaps folder
local function load_keymaps()
  local keymaps_path = vim.fn.stdpath("config") .. "/lua/cargdev/core/keymaps"
  local scan = vim.fn.globpath(keymaps_path, "*.lua", false, true)

  for _, file in ipairs(scan) do
    local module_name = "cargdev.core.keymaps." .. file:match("([^/]+)%.lua$")
    local success, err = pcall(require, module_name)

    if not success then
      vim.notify("Error loading keymap module: " .. module_name .. "\n" .. err, vim.log.levels.ERROR)
    end
  end
end

-- Load all keymaps
load_keymaps()
