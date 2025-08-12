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
    -- Fallback to vim.notify
    vim.notify(message, level, opts)
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

-- Function to handle startup messages
function M.handle_startup_messages()
  -- Clear any existing messages
  vim.cmd("redraw!")
  
  -- Suppress startup messages
  vim.opt.shortmess = vim.opt.shortmess + "I" -- No intro message
  vim.opt.shortmess = vim.opt.shortmess + "c" -- No completion messages
  vim.opt.shortmess = vim.opt.shortmess + "F" -- No file info message
  vim.opt.shortmess = vim.opt.shortmess + "W" -- No "written" message
  vim.opt.shortmess = vim.opt.shortmess + "A" -- No attention message
  vim.opt.shortmess = vim.opt.shortmess + "o" -- No overwrite messages
  
  -- Clear any existing messages
  vim.cmd("echo ''")
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
  
  -- Override vim.notify to use our custom system
  local original_notify = vim.notify
  vim.notify = function(msg, level, opts)
    M.show_notification(msg, level, opts)
  end
  
  print("Notification manager initialized")
end

-- Initialize notification manager
M.setup()

return M
