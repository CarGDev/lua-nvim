-- ============================================================================
-- PLUGINS INIT: Auto-load all plugin configurations
-- ============================================================================
-- Automatically discovers and loads all .lua files in the plugins directory.
-- Includes base plugins (plenary, vim-tmux-navigator) and imports all other
-- plugin configurations via lazy.nvim's import system. Excludes init.lua itself.
-- ============================================================================
local function load_all_plugins()
  local plugins = {}
  
  -- Add basic plugins
  table.insert(plugins, "nvim-lua/plenary.nvim")
  table.insert(plugins, "christoomey/vim-tmux-navigator")
  
  -- Get all .lua files in the plugins directory (excluding init.lua and lsp directory)
  local plugin_path = vim.fn.stdpath("config") .. "/lua/cargdev/plugins"
  local files = vim.fn.globpath(plugin_path, "*.lua", false, true)
  
  for _, file in ipairs(files) do
    local filename = vim.fn.fnamemodify(file, ":t:r") -- Get filename without extension
    if filename ~= "init" then -- Skip init.lua itself
      table.insert(plugins, { import = "cargdev.plugins." .. filename })
    end
  end
  
  return plugins
end

return load_all_plugins()
