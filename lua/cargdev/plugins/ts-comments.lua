-- ============================================================================
-- TS-COMMENTS: Treesitter-based comment string detection
-- ============================================================================
-- Enhances Neovim's native commenting by using treesitter to detect the correct
-- comment style based on the current context (e.g., JSX vs JavaScript).
-- Works seamlessly with Neovim's built-in gc/gcc comment operators.
-- ============================================================================

return {
  "folke/ts-comments.nvim",
  event = "VeryLazy",
  opts = {},
}
