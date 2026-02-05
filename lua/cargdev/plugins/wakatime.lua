-- ============================================================================
-- WAKATIME: Coding time tracking
-- ============================================================================
-- Automatically tracks your coding activity and time spent in Neovim.
-- Sends heartbeats to WakaTime dashboard for detailed metrics and insights.
-- Configured with 2-minute heartbeat frequency and buffering for performance.
-- ============================================================================

return {
  "wakatime/vim-wakatime",
  lazy = false,
  config = function()
    -- WakaTime performance optimizations
    vim.g.wakatime_HeartbeatFrequency = 2 -- Increase from default 1 minute to 2 minutes
    vim.g.wakatime_buffering_heartbeats_enabled = 1 -- Enable buffering
    vim.g.wakatime_debug = 0 -- Disable debug mode for performance
    vim.g.wakatime_redraw_setting = 'auto' -- Auto redraw setting
  end,
}
