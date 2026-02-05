-- ============================================================================
-- COMMENTS: Smart code commenting with treesitter support
-- ============================================================================
-- Toggle comments with gc (line) or gb (block). Uses treesitter to detect
-- the correct comment style for embedded languages (e.g., JS inside HTML,
-- CSS inside JSX). Works with tsx, jsx, svelte, and other mixed-language files.
-- ============================================================================
return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- import comment plugin safely
    local comment = require("Comment")

    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    -- enable comment

    comment.setup({
      -- for commenting tsx, jsx, svelte, html files
      pre_hook = ts_context_commentstring.create_pre_hook(),
    })
  end,
}
