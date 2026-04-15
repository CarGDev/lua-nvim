-- ============================================================================
-- NOICE: centered cmdline popup only
-- ============================================================================
-- Minimal setup: renders `:` and `/` in a floating box in the middle of the
-- screen. Messages, popupmenu, and LSP progress are left to native Vim +
-- snacks.notifier + fidget (no overlap).
-- ============================================================================
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
    },
    views = {
      cmdline_popup = {
        position = { row = "50%", col = "50%" },
        size = { width = 60, height = "auto" },
        border = { style = "rounded" },
      },
      cmdline_popupmenu = {
        relative = "editor",
        position = { row = "50%", col = "50%" },
        size = { width = 60, height = 10 },
        border = { style = "rounded" },
      },
    },
    messages = { enabled = false },
    popupmenu = { enabled = false },
    notify = { enabled = false },
    lsp = {
      progress = { enabled = false },
      hover = { enabled = false },
      signature = { enabled = false },
      message = { enabled = false },
    },
    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = false,
      inc_rename = false,
      lsp_doc_border = false,
    },
  },
}
