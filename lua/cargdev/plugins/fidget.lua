return {
  "j-hui/fidget.nvim",
  opts = {
    notification = {
      window = {
        winblend = 0,
        border = "rounded",
        align = "bottom",
        avoid = { "NvimTree" },
      },
      view = {
        stack_upwards = true,
      },
      filter = vim.log.levels.INFO,
      override_vim_notify = false,
    },
  },
}
