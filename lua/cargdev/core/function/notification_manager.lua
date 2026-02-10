--- Custom notification manager to handle overlapping and improve UX.
--- Provides a centralized notification system that prevents overlapping,
--- supports dashboard-aware notifications, and integrates with nvim-notify
--- when available, falling back to cmd echo otherwise.
--- @module notification_manager
local M = {}
local log = vim.log
local api = vim.api
local cmd = vim.cmd
local o = vim.o
local loop = vim.loop
local opt = vim.opt
local deferFn = vim.defer_fn

--- List of currently displayed notifications (each entry has win, message, timestamp).
--- @type table[]
local active_notifications = {}

--- Show a notification without overlapping existing ones.
--- Uses nvim-notify if available; otherwise falls back to echo.
--- Automatically detects the alpha dashboard and delegates to
--- `show_dashboard_notification` when appropriate.
--- @param message string The notification message to display.
--- @param level number|nil Log level from log.levels (default: INFO).
--- @param opts table|nil Optional overrides (timeout, title, render, position, etc.).
--- @return number|nil notification_id The nvim-notify notification id, or nil on fallback.
function M.show_notification(message, level, opts)
  level = level or log.levels.INFO
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
  local current_buf = api.nvim_get_current_buf()
  local current_ft = api.nvim_buf_get_option(current_buf, "filetype")

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
      local col = o.columns - 60

      -- Adjust position if there are other notifications
      for _, notif in ipairs(active_notifications) do
        if notif.win and api.nvim_win_is_valid(notif.win) then
          row = row + 10 -- Stack notifications vertically
        end
      end

      -- Ensure notification doesn't go off-screen
      if row > o.lines - 15 then
        row = 2
        col = col - 20
      end

      api.nvim_win_set_config(win, {
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
        timestamp = loop.now(),
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
    if level == log.levels.ERROR then
      icon = "❌"
    elseif level == log.levels.WARN then
      icon = "⚠️"
    elseif level == log.levels.INFO then
      icon = "ℹ️"
    end

    -- Use echo for fallback notifications
    cmd("echo '" .. icon .. " " .. message .. "'")

    -- Clear message after a delay
    deferFn(function()
      cmd("echo ''")
    end, opts.timeout or 3000)
  end
end

--- Show a minimal notification tailored for the alpha dashboard.
--- Truncates messages longer than 50 characters and uses echo
--- to avoid interfering with the dashboard layout.
--- @param message string The notification message to display.
--- @param level number|nil Log level from log.levels.
--- @param opts table|nil Optional overrides (timeout, etc.).
function M.show_dashboard_notification(message, level, opts)
  -- In dashboard, show minimal notifications
  local icon = "💬"
  if level == log.levels.ERROR then
    icon = "❌"
  elseif level == log.levels.WARN then
    icon = "⚠️"
  elseif level == log.levels.INFO then
    icon = "ℹ️"
  end

  -- Show message in status line or use echo
  local short_message = message:sub(1, 50)
  if #message > 50 then
    short_message = short_message .. "..."
  end

  -- Use echo for dashboard notifications to avoid overlapping
  cmd("echo '" .. icon .. " " .. short_message .. "'")

  -- Clear message after a delay
  deferFn(function()
    cmd("echo ''")
  end, opts.timeout or 3000)
end

--- Close and clear all active notifications.
--- Iterates through `active_notifications`, closes any valid windows,
--- and resets the tracking list.
function M.clear_all_notifications()
  for _, notif in ipairs(active_notifications) do
    if notif.win and api.nvim_win_is_valid(notif.win) then
      api.nvim_win_close(notif.win, true)
    end
  end
  active_notifications = {}
end

--- Show a performance-related notification with a chart icon prefix.
--- @param message string The performance message to display.
--- @param level number|nil Log level from log.levels.
function M.show_performance_notification(message, level)
  M.show_notification("📊 " .. message, level, {
    title = "Performance Monitor",
    timeout = 4000,
    position = "top_right",
  })
end

--- Show an LSP status notification with a wrench icon prefix.
--- @param message string The LSP status message to display.
--- @param level number|nil Log level from log.levels.
function M.show_lsp_notification(message, level)
  M.show_notification("🔧 " .. message, level, {
    title = "LSP Status",
    timeout = 3000,
    position = "top_right",
  })
end

--- Show a file operation notification with a folder icon prefix.
--- @param message string The file operation message to display.
--- @param level number|nil Log level from log.levels.
function M.show_file_notification(message, level)
  M.show_notification("📁 " .. message, level, {
    title = "File Operation",
    timeout = 2500,
    position = "top_right",
  })
end

--- Show a plugin manager notification with a sloth icon prefix.
--- @param message string The plugin-related message to display.
--- @param level number|nil Log level from log.levels.
function M.show_plugin_notification(message, level)
  M.show_notification("🦥 " .. message, level, {
    title = "Plugin Manager",
    timeout = 3000,
    position = "top_right",
  })
end

--- Show a startup notification with a rocket icon prefix and a short timeout.
--- @param message string The startup message to display.
--- @param level number|nil Log level from log.levels.
function M.show_startup_notification(message, level)
  M.show_notification("🚀 " .. message, level, {
    title = "Startup",
    timeout = 2000,
    position = "top_right",
  })
end

--- Aggressively suppress startup messages and "Press ENTER" prompts.
--- Configures `shortmess` with all relevant flags, sets `cmdheight` to 0,
--- disables `showmode`, and schedules deferred redraws to clear any
--- lingering messages.
function M.handle_startup_messages()
  -- Clear any existing messages immediately
  cmd("redraw!")
  cmd("echo ''")

  -- Suppress all startup messages
  opt.shortmess = opt.shortmess + "I" -- No intro message
  opt.shortmess = opt.shortmess + "c" -- No completion messages
  opt.shortmess = opt.shortmess + "F" -- No file info message
  opt.shortmess = opt.shortmess + "W" -- No "written" message
  opt.shortmess = opt.shortmess + "A" -- No attention message
  opt.shortmess = opt.shortmess + "o" -- No overwrite messages
  opt.shortmess = opt.shortmess + "t" -- No truncation messages
  opt.shortmess = opt.shortmess + "T" -- No truncation messages
  opt.shortmess = opt.shortmess + "f" -- No file info messages
  opt.shortmess = opt.shortmess + "i" -- No intro messages
  opt.shortmess = opt.shortmess + "l" -- No line number messages
  opt.shortmess = opt.shortmess + "m" -- No modification messages
  opt.shortmess = opt.shortmess + "n" -- No line number messages
  opt.shortmess = opt.shortmess + "r" -- No read messages
  opt.shortmess = opt.shortmess + "s" -- No search messages
  opt.shortmess = opt.shortmess + "x" -- No truncation messages
  opt.shortmess = opt.shortmess + "O" -- No overwrite messages

  -- Disable command line messages
  opt.cmdheight = 0
  opt.showmode = false

  -- Clear any existing messages
  cmd("echo ''")

  -- Force clear any pending messages
  deferFn(function()
    cmd("redraw!")
    cmd("echo ''")
  end, 100)
end

--- Eliminate "Press ENTER" prompts by overriding `cmd.echo` and
--- installing autocmds that forcibly clear messages on VimEnter and
--- BufReadPost events.
function M.eliminate_enter_prompts()
  -- Override the message display to prevent "Press ENTER" prompts
  local original_echo = cmd.echo
  cmd.echo = function(msg)
    local msg_str = tostring(msg)
    -- Block any messages that might cause "Press ENTER" prompts
    if
      msg_str:match("Press ENTER")
      or msg_str:match("lazyredraw")
      or msg_str:match("You have enabled")
      or msg_str:match("This is only meant")
      or msg_str:match("You'll experience issues")
    then
      return -- Don't show these messages
    end
    -- Allow other messages
    original_echo(msg)
  end

  -- Create autocmd to handle any remaining prompts
  api.nvim_create_autocmd("VimEnter", {
    callback = function()
      -- Clear any startup messages immediately
      cmd("redraw!")
      cmd("echo ''")

      -- Force clear any pending messages multiple times
      for i = 1, 5 do
        deferFn(function()
          cmd("redraw!")
          cmd("echo ''")
        end, i * 50)
      end
    end,
    once = true,
  })

  -- Create autocmd to handle message events - use valid events
  api.nvim_create_autocmd("BufReadPost", {
    callback = function()
      -- Clear messages that might cause prompts
      cmd("redraw!")
    end,
  })
end

--- Initialize the notification system.
--- Registers VimEnter and FileType autocmds to handle startup messages
--- and dashboard transitions, and calls `eliminate_enter_prompts`.
--- Called automatically when the module is first required.
function M.setup()
  -- Create autocmd to handle startup messages
  api.nvim_create_autocmd("VimEnter", {
    callback = function()
      M.handle_startup_messages()
    end,
    once = true,
  })

  -- Create autocmd to handle alpha dashboard
  api.nvim_create_autocmd("FileType", {
    pattern = "alpha",
    callback = function()
      M.handle_startup_messages()
    end,
  })

  -- Eliminate "Press ENTER" prompts
  M.eliminate_enter_prompts()

  -- Don't override vim.notify here to avoid circular dependency
  -- Let the system handle notifications naturally
end

--- Initialize notification manager on require.
M.setup()

return M
