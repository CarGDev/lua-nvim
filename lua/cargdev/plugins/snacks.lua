-- ============================================================================
-- SNACKS: Collection of small QoL plugins by folke
-- ============================================================================
-- All-in-one plugin with: dashboard (start screen), bufdelete (smart buffer
-- close), bigfile (disable features for large files), notifier, input/select
-- UI, lazygit integration, terminal, and more. Has BufDelete/BufWipeout
-- autocmds to show dashboard when last buffer closes.
-- ============================================================================
return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local dashboard_config = require("cargdev.core.dashboard_config")
    require("snacks").setup({
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      dashboard = {
        enabled = true,
        width = 40,
        row = nil,
        col = nil,
        pane_gap = 2,
        autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
        preset = {
          keys = dashboard_config.get_snacks_keys(),
          header = dashboard_config.get_header_string(),
        },
        formats = {
          key = function(item)
            return { { item.key, hl = "SnacksDashboardKey" } }
          end,
        },
        sections = {
          { padding = 4 },
          { section = "header" },
          { padding = 2 },
          { section = "keys", gap = 1, padding = 0 },
          { padding = 1 },
          { section = "startup" },
        },
      },
      explorer = { enabled = false },
      image = {
        enabled = true,
        terminal = nil,
      },
      input = { enabled = true },
      lazygit = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
        style = "minimal",
        top_down = false,
        margin = { top = 0, right = 1, bottom = 1 },
      },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      terminal = { enabled = true },
      toggle = { enabled = true },
      words = {
        enabled = true,
        lsp = { enabled = false },
        hl = { enabled = true },
      },
    })

    vim.schedule(function()
      vim.ui.input = require("snacks.input").input
      vim.ui.select = require("snacks.picker").select
    end)
  end,
}
