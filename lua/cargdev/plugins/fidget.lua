-- ============================================================================
-- FIDGET: LSP progress indicator in the corner
-- ============================================================================
-- Shows LSP loading/indexing progress as subtle notifications in the bottom
-- corner. Non-intrusive way to see what the language server is doing.
-- Note: noice.nvim also shows LSP progress, so this may be redundant.
-- ============================================================================
return {
  "j-hui/fidget.nvim",
  opts = {
    notification = {
      window = {
        winblend = 0,
        border = "rounded",
        align = "bottom",
        avoid = { "NvimTree" },
      },
      view = {
        stack_upwards = true,
      },
      filter = vim.log.levels.INFO,
      override_vim_notify = false,
    },
  },
}
