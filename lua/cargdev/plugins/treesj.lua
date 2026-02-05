-- ============================================================================
-- TREESJ: Split/join code blocks
-- ============================================================================
-- Treesitter-powered splitting and joining of code blocks (arrays, objects, args).
-- Toggle between single-line and multi-line formats with smart formatting.
-- Keymaps: <leader>tj toggle, <leader>ts split, <leader>tJ join.
-- ============================================================================

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
