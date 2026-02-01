return {
  "mawkler/modicator.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.cursorline = true
    vim.o.number = true
  end,
  opts = {
    show_warnings = false,
    highlights = {
      defaults = {
        bold = true,
      },
    },
    integration = {
      lualine = {
        enabled = true,
        mode_section = nil,
        highlight = "bg",
      },
    },
  },
}
