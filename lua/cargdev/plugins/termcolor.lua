-- ============================================================================
-- LOG-HIGHLIGHT.NVIM: Syntax Highlighting for Log Files
-- ============================================================================
-- Provides syntax highlighting for various log file formats. Automatically
-- detects and highlights log levels (INFO, WARN, ERROR, DEBUG, etc.),
-- timestamps, and other common log patterns for improved readability.
-- ============================================================================
return {
  "fei6409/log-highlight.nvim",
  config = function()
    require("log-highlight").setup({})
  end,
}
