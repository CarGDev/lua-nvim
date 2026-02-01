return {
  "lewis6991/satellite.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    current_only = false,
    winblend = 50,
    zindex = 40,
    excluded_filetypes = {
      "NvimTree",
      "neo-tree",
      "lazy",
      "mason",
      "help",
      "terminal",
      "toggleterm",
      "TelescopePrompt",
      "alpha",
      "dashboard",
      "Outline",
      "lspsaga",
      "spectre_panel",
    },
    width = 2,
    handlers = {
      cursor = {
        enable = true,
        symbols = { "⎺", "⎻", "⎼", "⎽" },
      },
      search = {
        enable = true,
        symbols = { "━" },
      },
      diagnostic = {
        enable = true,
        signs = { "-", "=", "≡" },
        min_severity = vim.diagnostic.severity.HINT,
      },
      gitsigns = {
        enable = true,
        signs = {
          add = "│",
          change = "│",
          delete = "─",
        },
      },
      marks = {
        enable = true,
        show_builtins = false,
        key = "m",
      },
      quickfix = {
        enable = true,
        signs = { "-", "=", "≡" },
      },
    },
  },
}
