-- ============================================================================
-- SURROUND: Add/change/delete surroundings
-- ============================================================================
-- Easily add, change, or delete surrounding pairs (quotes, brackets, tags, etc.)
-- Use ys{motion}{char} to add, cs{old}{new} to change, ds{char} to delete.
-- Works with text objects: ysiw" surrounds word with quotes, cs"' changes " to '.
-- ============================================================================

return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  config = true,
}
