return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local dashboard_config = require("cargdev.core.dashboard_config")
    require("snacks").setup({
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        width = 60,
        row = nil,
        col = nil,
        pane_gap = 4,
        autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
        preset = {
          keys = dashboard_config.get_snacks_keys(),
          header = dashboard_config.get_header_string(),
        },
        sections = {
          { section = "header" },
          { padding = 1 },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
      explorer = { enabled = true },
      image = {
        enabled = true,
        terminal = nil,
      },
      input = { enabled = true },
      lazygit = { enabled = true },
      notifier = { enabled = true },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      terminal = { enabled = true },
      toggle = { enabled = true },
      words = {
        enabled = true,
        lsp = { enabled = false },
        hl = { enabled = true },
      },
    })

    -- Set up vim.ui.input and vim.ui.select for snacks
    vim.schedule(function()
      vim.ui.input = require("snacks.input").input
      vim.ui.select = require("snacks.picker").select
    end)
  end,
}
