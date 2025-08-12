-- Startup performance optimizations
local M = {}

-- Function to optimize startup performance
function M.optimize_startup()
  -- Record startup time
  local start_time = vim.loop.hrtime()
  
  -- Disable unused providers
  vim.g.loaded_python3_provider = 0
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
  
  -- Fix lazyredraw conflict with Noice - but only after LazyVim loads
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
      vim.opt.lazyredraw = false -- Disable to prevent Noice conflicts
    end,
    once = true,
  })
  
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
  
  -- Completely eliminate "Press ENTER" prompts
  vim.opt.shortmess = vim.opt.shortmess + "I" -- No intro message
  vim.opt.shortmess = vim.opt.shortmess + "c" -- No completion messages
  vim.opt.shortmess = vim.opt.shortmess + "F" -- No file info message
  vim.opt.shortmess = vim.opt.shortmess + "W" -- No "written" message
  vim.opt.shortmess = vim.opt.shortmess + "A" -- No attention message
  vim.opt.shortmess = vim.opt.shortmess + "o" -- No overwrite messages
  vim.opt.shortmess = vim.opt.shortmess + "t" -- No truncation messages
  vim.opt.shortmess = vim.opt.shortmess + "T" -- No truncation messages
  vim.opt.shortmess = vim.opt.shortmess + "f" -- No file info messages
  vim.opt.shortmess = vim.opt.shortmess + "i" -- No intro messages
  vim.opt.shortmess = vim.opt.shortmess + "l" -- No line number messages
  vim.opt.shortmess = vim.opt.shortmess + "m" -- No modification messages
  vim.opt.shortmess = vim.opt.shortmess + "n" -- No line number messages
  vim.opt.shortmess = vim.opt.shortmess + "r" -- No read messages
  vim.opt.shortmess = vim.opt.shortmess + "s" -- No search messages
  vim.opt.shortmess = vim.opt.shortmess + "x" -- No truncation messages
  
  -- Disable swap file messages completely
  vim.opt.shortmess = vim.opt.shortmess + "O" -- No overwrite messages
  
  -- Disable all startup messages
  vim.opt.cmdheight = 0 -- Reduce command line height
  vim.opt.showmode = false -- Don't show mode in command line
  
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
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
      vim.defer_fn(function()
        if vim.fn.exists(":TSBufEnable") > 0 then
          vim.cmd("TSBufEnable highlight")
        end
      end, 100)
    end,
    once = true,
  })
  
  -- Defer LSP setup for non-critical buffers
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
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
    end,
    once = true,
  })
  
  -- Defer completion setup
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
      vim.defer_fn(function()
        if vim.fn.exists(":CmpStatus") > 0 then
          vim.cmd("CmpStatus")
        end
      end, 300)
    end,
    once = true,
  })
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
      
      print("Large repository detected (" .. file_count .. " lines). Applied additional optimizations.")
    end
  end
end

-- Function to completely eliminate startup prompts
function M.eliminate_startup_prompts()
  -- Create autocmd to handle any remaining startup messages
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      -- Clear any startup messages immediately
      vim.cmd("redraw!")
      vim.cmd("echo ''")
      
      -- Force clear any pending messages
      vim.defer_fn(function()
        vim.cmd("redraw!")
        vim.cmd("echo ''")
      end, 50)
    end,
    once = true,
  })
  
  -- Create autocmd to handle any message events - use valid events
  vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
      -- Clear messages that might cause prompts
      vim.cmd("redraw!")
    end,
  })
  
  -- Override the message display to prevent prompts
  local original_echo = vim.cmd.echo
  vim.cmd.echo = function(msg)
    -- Only echo if it's not a startup message
    if not tostring(msg):match("Press ENTER") and not tostring(msg):match("lazyredraw") then
      original_echo(msg)
    end
  end
end

-- Initialize startup optimizations
M.optimize_startup()
M.defer_heavy_operations()
M.check_repo_size()
M.eliminate_startup_prompts()

return M
