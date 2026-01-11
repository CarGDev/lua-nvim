return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 200 -- Reduced from 500 for faster response
  end,
  config = function()
    local wk = require("which-key")

    wk.setup({
      plugins = {
        marks = true,
        registers = true,
        spelling = { enabled = true, suggestions = 20 },
      },
      win = {
        border = "rounded",
        padding = { 2, 2, 2, 2 },
      },
    })

    -- Register group names for better organization
    wk.add({
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code/Copilot" },
      { "<leader>d", group = "Debug/DAP" },
      { "<leader>e", group = "Explorer" },
      { "<leader>f", group = "Find/Files" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "LSP/LeetCode" },
      { "<leader>m", group = "Format" },
      { "<leader>n", group = "Notifications" },
      { "<leader>p", group = "Project" },
      { "<leader>q", group = "Quickfix" },
      { "<leader>s", group = "Session/Split/Substitute" },
      { "<leader>t", group = "Tab/Terminal/Text" },
      { "<leader>x", group = "Trouble/Diagnostics" },
      { "<leader>z", group = "Copilot Chat" },
    })
  end,
}
