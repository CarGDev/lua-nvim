-- ============================================================================
-- MODICATOR: Cursor line number mode indicator
-- ============================================================================
-- A plugin that changes the color of the cursor line number based on the
-- current Vim mode (normal, insert, visual, etc.). Provides visual feedback
-- for mode changes directly in the line number column.
--
-- Features:
--   - Color-coded line numbers by mode
--   - Lualine integration for consistent theming
--   - Bold highlighting for better visibility
--
-- Requirements: cursorline and number options are enabled automatically.
-- ============================================================================
return {
  "mawkler/modicator.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.cursorline = true
    vim.o.number = true
  end,
  opts = {
    show_warnings = false,
    highlights = {
      defaults = {
        bold = true,
      },
    },
    integration = {
      lualine = {
        enabled = true,
        mode_section = nil,
        highlight = "bg",
      },
    },
  },
}
