return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
    options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
    pre_save = nil,
    save_empty = false,
  },
  keys = {
    { "<leader>ss", function() require("persistence").load() end, desc = "Restore session" },
    { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
    { "<leader>sd", function() require("persistence").stop() end, desc = "Don't save session" },
  },
}
