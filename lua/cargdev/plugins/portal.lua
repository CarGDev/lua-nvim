return {
  "cbochs/portal.nvim",
  dependencies = { "cbochs/grapple.nvim" },
  keys = {
    { "<leader>pj", "<cmd>Portal jumplist backward<cr>", desc = "Portal jumplist backward" },
    { "<leader>pk", "<cmd>Portal jumplist forward<cr>", desc = "Portal jumplist forward" },
    { "<leader>pc", "<cmd>Portal changelist backward<cr>", desc = "Portal changelist backward" },
    { "<leader>pq", "<cmd>Portal quickfix backward<cr>", desc = "Portal quickfix backward" },
  },
  opts = {
    escape = {
      ["<esc>"] = true,
      ["q"] = true,
    },
    window_options = {
      relative = "cursor",
      width = 80,
      height = 4,
      col = 2,
      focusable = false,
      border = "rounded",
      noautocmd = true,
    },
  },
}
