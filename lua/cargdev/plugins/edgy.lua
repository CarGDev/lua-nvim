return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  opts = {
    left = {
      {
        ft = "NvimTree",
        size = { width = 35 },
      },
    },
    right = {
      {
        ft = "Outline",
        size = { width = 30 },
      },
    },
    bottom = {
      {
        ft = "snacks_terminal",
        size = { height = 0.25 },
      },
      {
        ft = "trouble",
        size = { height = 0.25 },
      },
      {
        ft = "qf",
        size = { height = 0.2 },
      },
    },
    animate = { enabled = false },
    exit_when_last = true,
    wo = {
      winbar = false,
      winfixwidth = true,
      winfixheight = false,
      signcolumn = "no",
    },
  },
}
