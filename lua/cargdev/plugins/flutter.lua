-- ============================================================================
-- FLUTTER-TOOLS.NVIM: Flutter development tools
-- ============================================================================
-- Provides Flutter and Dart development support in Neovim.
-- Features: Flutter commands, hot reload, device selection, and integration
-- with Dart LSP for code intelligence.
-- ============================================================================
return {
  "akinsho/flutter-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  config = true,
}
