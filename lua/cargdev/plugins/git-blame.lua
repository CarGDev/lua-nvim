return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  opts = {
    enabled = false, -- Start disabled, toggle with <leader>gB
    message_template = " <author> • <date> • <summary>",
    date_format = "%Y-%m-%d",
    virtual_text_column = 80, -- Push to column 80 to avoid overlap
    highlight_group = "Comment",
    set_extmark_options = {
      priority = 1, -- Lower priority so diagnostics show on top
    },
    display_virtual_text = true,
    ignored_filetypes = { "NvimTree", "neo-tree", "lazy", "mason", "help" },
    delay = 500,
    message_when_not_committed = "",
  },
  keys = {
    { "<leader>gB", "<cmd>GitBlameToggle<cr>", desc = "Toggle git blame" },
    { "<leader>gbc", "<cmd>GitBlameCopySHA<cr>", desc = "Copy commit SHA" },
    { "<leader>gbo", "<cmd>GitBlameOpenCommitURL<cr>", desc = "Open commit URL" },
    { "<leader>gbf", "<cmd>GitBlameOpenFileURL<cr>", desc = "Open file URL" },
  },
}
