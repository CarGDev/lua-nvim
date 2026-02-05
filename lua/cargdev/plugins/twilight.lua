-- ============================================================================
-- TWILIGHT: Focus mode with dimming for distraction-free coding
-- ============================================================================
-- Dims inactive portions of code to help focus on the current context.
-- Uses treesitter to intelligently expand functions, methods, tables, and
-- if statements. Configurable dimming with alpha and color settings.
-- Keymaps:
--   <leader>zt - Toggle Twilight focus mode
-- ============================================================================

return {
  "folke/twilight.nvim",
  cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  keys = {
    { "<leader>zt", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
  },
  opts = {
    dimming = {
      alpha = 0.25,
      color = { "Normal", "#ffffff" },
      term_bg = "#000000",
      inactive = false,
    },
    context = 10,
    treesitter = true,
    expand = {
      "function",
      "method",
      "table",
      "if_statement",
    },
    exclude = {},
  },
}
