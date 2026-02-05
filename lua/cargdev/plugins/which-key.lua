-- ============================================================================
-- WHICH-KEY: Keybinding popup helper
-- ============================================================================
-- Shows available keybindings in a popup when you start a key sequence.
-- Press <leader> and wait to see all leader mappings. Helps discover and
-- remember keybindings. Also shows marks, registers, and spelling suggestions.
-- ============================================================================
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
      { "<leader>q", group = "Quit" },
      { "<leader>s", group = "Session/Split/Substitute" },
      { "<leader>t", group = "Tab/Terminal/Text" },
      { "<leader>w", group = "Save" },
      { "<leader>x", group = "Trouble/Quickfix" },
      { "<leader>z", group = "Copilot Chat" },
    })
  end,
}
