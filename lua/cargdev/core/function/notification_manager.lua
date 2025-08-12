-- Custom notification manager to handle overlapping and improve UX
local M = {}

-- Track active notifications to prevent overlapping
local active_notifications = {}
local notification_queue = {}

-- Function to show a notification without overlapping
function M.show_notification(message, level, opts)
  level = level or vim.log.levels.INFO
  opts = opts or {}
  
  -- Default options
  local default_opts = {
    timeout = 3000,
    title = "CarGDev Neovim",
    render = "minimal",
    stages = "fade_in_slide_out",
    position = "top_right",
    max_width = 50,
    max_height = 8,
    background_colour = "#000000",
    border_style = "rounded",
  }
  
  -- Merge options
  for k, v in pairs(default_opts) do
    if opts[k] == nil then
      opts[k] = v
    end
  end
  
  -- Check if we're in alpha dashboard
  local current_buf = vim.api.nvim_get_current_buf()
  local current_ft = vim.api.nvim_buf_get_option(current_buf, "filetype")
  
  if current_ft == "alpha" then
    -- If in dashboard, use a different approach
    M.show_dashboard_notification(message, level, opts)
    return
  end
  
  -- Use nvim-notify if available
  local notify_available = pcall(require, "notify")
  if notify_available then
    local notify = require("notify")
    
    -- Position notification to avoid overlapping
    opts.on_open = function(win)
      -- Calculate position to avoid overlapping with other notifications
      local row = 2
      local col = vim.o.columns - 60
      
      -- Adjust position if there are other notifications
      for _, notif in ipairs(active_notifications) do
        if notif.win and vim.api.nvim_win_is_valid(notif.win) then
          row = row + 10 -- Stack notifications vertically
        end
      end
      
      -- Ensure notification doesn't go off-screen
      if row > vim.o.lines - 15 then
        row = 2
        col = col - 20
      end
      
      vim.api.nvim_win_set_config(win, {
        row = row,
        col = col,
        relative = "editor",
        width = opts.max_width,
        height = opts.max_height,
      })
      
      -- Track this notification
      table.insert(active_notifications, {
        win = win,
        message = message,
        timestamp = vim.loop.now(),
      })
    end
    
    opts.on_close = function(win)
      -- Remove from active notifications
      for i, notif in ipairs(active_notifications) do
        if notif.win == win then
          table.remove(active_notifications, i)
          break
        end
      end
    end
    
    -- Show notification
    local notification_id = notify(message, level, opts)
    return notification_id
  else
    -- Fallback to echo instead of vim.notify to avoid circular dependency
    local icon = "💬"
    if level == vim.log.levels.ERROR then
      icon = "❌"
    elseif level == vim.log.levels.WARN then
      icon = "⚠️"
    elseif level == vim.log.levels.INFO then
      icon = "ℹ️"
    end
    
    -- Use echo for fallback notifications
    vim.cmd("echo '" .. icon .. " " .. message .. "'")
    
    -- Clear message after a delay
    vim.defer_fn(function()
      vim.cmd("echo ''")
    end, opts.timeout or 3000)
  end
end

-- Function to show notifications specifically for dashboard
function M.show_dashboard_notification(message, level, opts)
  -- In dashboard, show minimal notifications
  local icon = "💬"
  if level == vim.log.levels.ERROR then
    icon = "❌"
  elseif level == vim.log.levels.WARN then
    icon = "⚠️"
  elseif level == vim.log.levels.INFO then
    icon = "ℹ️"
  end
  
  -- Show message in status line or use echo
  local short_message = message:sub(1, 50)
  if #message > 50 then
    short_message = short_message .. "..."
  end
  
  -- Use echo for dashboard notifications to avoid overlapping
  vim.cmd("echo '" .. icon .. " " .. short_message .. "'")
  
  -- Clear message after a delay
  vim.defer_fn(function()
    vim.cmd("echo ''")
  end, opts.timeout or 3000)
end

-- Function to clear all notifications
function M.clear_all_notifications()
  for _, notif in ipairs(active_notifications) do
    if notif.win and vim.api.nvim_win_is_valid(notif.win) then
      vim.api.nvim_win_close(notif.win, true)
    end
  end
  active_notifications = {}
end

-- Function to show performance notification
function M.show_performance_notification(message, level)
  M.show_notification("📊 " .. message, level, {
    title = "Performance Monitor",
    timeout = 4000,
    position = "top_right",
  })
end

-- Function to show LSP notification
function M.show_lsp_notification(message, level)
  M.show_notification("🔧 " .. message, level, {
    title = "LSP Status",
    timeout = 3000,
    position = "top_right",
  })
end

-- Function to show file operation notification
function M.show_file_notification(message, level)
  M.show_notification("📁 " .. message, level, {
    title = "File Operation",
    timeout = 2500,
    position = "top_right",
  })
end

-- Function to show plugin notification
function M.show_plugin_notification(message, level)
  M.show_notification("🦥 " .. message, level, {
    title = "Plugin Manager",
    timeout = 3000,
    position = "top_right",
  })
end

-- Function to show startup notification
function M.show_startup_notification(message, level)
  M.show_notification("🚀 " .. message, level, {
    title = "Startup",
    timeout = 2000,
    position = "top_right",
  })
end

-- Function to handle startup messages aggressively
function M.handle_startup_messages()
  -- Clear any existing messages immediately
  vim.cmd("redraw!")
  vim.cmd("echo ''")
  
  -- Suppress all startup messages
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
  vim.opt.shortmess = vim.opt.shortmess + "O" -- No overwrite messages
  
  -- Disable command line messages
  vim.opt.cmdheight = 0
  vim.opt.showmode = false
  
  -- Clear any existing messages
  vim.cmd("echo ''")
  
  -- Force clear any pending messages
  vim.defer_fn(function()
    vim.cmd("redraw!")
    vim.cmd("echo ''")
  end, 100)
end

-- Function to eliminate "Press ENTER" prompts completely
function M.eliminate_enter_prompts()
  -- Override the message display to prevent "Press ENTER" prompts
  local original_echo = vim.cmd.echo
  vim.cmd.echo = function(msg)
    local msg_str = tostring(msg)
    -- Block any messages that might cause "Press ENTER" prompts
    if msg_str:match("Press ENTER") or 
       msg_str:match("lazyredraw") or
       msg_str:match("You have enabled") or
       msg_str:match("This is only meant") or
       msg_str:match("You'll experience issues") then
      return -- Don't show these messages
    end
    -- Allow other messages
    original_echo(msg)
  end
  
  -- Create autocmd to handle any remaining prompts
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      -- Clear any startup messages immediately
      vim.cmd("redraw!")
      vim.cmd("echo ''")
      
      -- Force clear any pending messages multiple times
      for i = 1, 5 do
        vim.defer_fn(function()
          vim.cmd("redraw!")
          vim.cmd("echo ''")
        end, i * 50)
      end
    end,
    once = true,
  })
  
  -- Create autocmd to handle message events - use valid events
  vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
      -- Clear messages that might cause prompts
      vim.cmd("redraw!")
    end,
  })
end

-- Function to setup notification system
function M.setup()
  -- Create autocmd to handle startup messages
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      M.handle_startup_messages()
    end,
    once = true,
  })
  
  -- Create autocmd to handle alpha dashboard
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "alpha",
    callback = function()
      M.handle_startup_messages()
    end,
  })
  
  -- Eliminate "Press ENTER" prompts
  M.eliminate_enter_prompts()
  
  -- Don't override vim.notify here to avoid circular dependency
  -- Let the system handle notifications naturally
  
  print("Notification manager initialized")
end

-- Initialize notification manager
M.setup()

return M
