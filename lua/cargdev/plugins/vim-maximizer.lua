-- ============================================================================
-- VIM-MAXIMIZER: Toggle window maximization
-- ============================================================================
-- Allows toggling a split window to full screen and back. Useful when working
-- with multiple splits but needing to temporarily focus on a single window.
-- Keymaps:
--   <leader>sm - Maximize/minimize the current split window
-- ============================================================================

return {
  "szw/vim-maximizer",
  keys = {
    { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
  },
}
