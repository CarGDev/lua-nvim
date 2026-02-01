return {
  "gbprod/yanky.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ring = {
      history_length = 100,
      storage = "sqlite",
      sync_with_numbered_registers = true,
      cancel_event = "update",
    },
    picker = {
      select = {
        action = nil,
      },
      telescope = {
        use_default_mappings = true,
        mappings = nil,
      },
    },
    system_clipboard = {
      sync_with_ring = true,
    },
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 200,
    },
    preserve_cursor_position = {
      enabled = true,
    },
  },
  keys = {
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank" },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put after" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put before" },
    { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "GPut after" },
    { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "GPut before" },
    { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Previous yank" },
    { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Next yank" },
    { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after" },
    { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before" },
    { "<leader>yh", "<cmd>YankyRingHistory<cr>", desc = "Yank history" },
  },
}
