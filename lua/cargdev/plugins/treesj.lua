return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = {
    { "<leader>tj", "<cmd>TSJToggle<cr>", desc = "Toggle split/join" },
    { "<leader>ts", "<cmd>TSJSplit<cr>", desc = "Split code block" },
    { "<leader>tJ", "<cmd>TSJJoin<cr>", desc = "Join code block" },
  },
  opts = {
    use_default_keymaps = false,
    check_syntax_error = true,
    max_join_length = 120,
    cursor_behavior = "hold",
    notify = true,
    dot_repeat = true,
    on_error = nil,
  },
}
