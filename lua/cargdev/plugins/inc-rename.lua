-- ============================================================================
-- INC-RENAME.NVIM: Incremental LSP renaming with live preview
-- ============================================================================
-- Provides an enhanced rename experience with real-time preview of changes
-- across the buffer as you type the new name. Uses LSP rename under the hood.
-- Keymaps:
--   <leader>rn - Incremental rename (pre-fills with word under cursor)
-- ============================================================================
return {
  "smjonas/inc-rename.nvim",
  cmd = "IncRename",
  keys = {
    {
      "<leader>rn",
      function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end,
      expr = true,
      desc = "Incremental rename",
    },
  },
  opts = {
    cmd_name = "IncRename",
    hl_group = "Substitute",
    preview_empty_name = false,
    show_message = true,
    save_in_cmdline_history = true,
    input_buffer_type = nil,
    post_hook = nil,
  },
}
