-- Startup performance optimizations
local M = {}

-- Function to optimize startup performance
function M.optimize_startup()
  -- Record startup time
  local start_time = vim.loop.hrtime()
  
  -- Disable unused providers
  vim.g.loaded_python3_provider = 0
  vim.g.loaded_node_provider = 0
  vim.g.loaded_ruby_provider = 0
  vim.g.loaded_perl_provider = 0
  
  -- Disable unused builtin plugins
  local disabled_builtins = {
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
  }
  
  for _, plugin in pairs(disabled_builtins) do
    vim.g["loaded_" .. plugin] = 1
  end
  
  -- Optimize filetype detection
  vim.g.do_filetype_lua = 1
  vim.g.did_load_filetypes = 0
  
  -- Reduce redraw frequency during startup
  vim.opt.lazyredraw = true
  
  -- Optimize completion settings
  vim.opt.completeopt = "menuone,noselect"
  vim.opt.pumheight = 10 -- Limit completion menu height
  
  -- Optimize search settings
  vim.opt.hlsearch = false
  vim.opt.incsearch = true
  
  -- Optimize syntax highlighting
  vim.opt.synmaxcol = 240
  vim.opt.redrawtime = 1500
  
  -- Optimize folding
  vim.opt.foldmethod = "manual"
  vim.opt.foldlevel = 99
  
  -- Record end time and calculate duration
  local end_time = vim.loop.hrtime()
  local duration = (end_time - start_time) / 1000000
  
  -- Store startup time for performance monitoring
  vim.g.startup_time = duration
  
  print("Startup optimizations applied in " .. string.format("%.2f", duration) .. "ms")
end

-- Function to defer heavy operations
function M.defer_heavy_operations()
  -- Defer treesitter loading
  vim.defer_fn(function()
    if vim.fn.exists(":TSBufEnable") > 0 then
      vim.cmd("TSBufEnable highlight")
    end
  end, 100)
  
  -- Defer LSP setup for non-critical buffers
  vim.defer_fn(function()
    -- Enable LSP for current buffer if it's a supported filetype
    local supported_ft = {
      "lua", "javascript", "typescript", "python", "java", "cpp", "c", "rust", "go",
      "html", "css", "json", "yaml", "markdown"
    }
    
    local current_ft = vim.bo.filetype
    if vim.tbl_contains(supported_ft, current_ft) then
      vim.cmd("LspStart")
    end
  end, 200)
  
  -- Defer completion setup
  vim.defer_fn(function()
    if vim.fn.exists(":CmpStatus") > 0 then
      vim.cmd("CmpStatus")
    end
  end, 300)
end

-- Function to check if we're in a large repository
function M.check_repo_size()
  local cwd = vim.fn.getcwd()
  local git_dir = cwd .. "/.git"
  
  if vim.fn.isdirectory(git_dir) > 0 then
    -- Check if this is a large repository
    local file_count = tonumber(vim.fn.system("git ls-files | wc -l")) or 0
    
    if file_count > 10000 then
      -- Large repository detected, apply additional optimizations
      vim.opt.tags = "" -- Disable tag loading
      vim.opt.cursorline = false -- Disable cursor line
      vim.opt.relativenumber = false -- Disable relative numbers
      
      print("Large repository detected (" .. file_count .. " files). Applied additional optimizations.")
    end
  end
end

-- Initialize startup optimizations
M.optimize_startup()
M.defer_heavy_operations()
M.check_repo_size()

return M
