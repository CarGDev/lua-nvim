-- Auto-load all plugin files from the plugins directory
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
