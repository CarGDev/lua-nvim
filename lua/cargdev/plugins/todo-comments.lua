-- ============================================================================
-- TODO-COMMENTS: Highlight TODOs
-- ============================================================================
-- Highlights and searches TODO, FIXME, HACK, NOTE, and other comment keywords.
-- Jump between todos with ]t and [t. Integrates with Telescope for project-wide
-- todo searching. Each keyword type gets distinct highlighting and icons.
-- ============================================================================

return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })

    todo_comments.setup()
  end,
}
