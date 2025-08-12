return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- import comment plugin safely
    local comment = require("Comment")

    -- Check if treesitter context commentstring is available
    local ok, ts_context_commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
    
    -- enable comment with safe configuration
    comment.setup({
      -- for commenting tsx, jsx, svelte, html files
      pre_hook = ok and ts_context_commentstring.create_pre_hook() or nil,
      -- Add explicit commentstring fallbacks
      opleader = {
        line = "gc",
        block = "gb",
      },
      toggler = {
        line = "gcc",
        block = "gbc",
      },
      extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
      },
      mappings = {
        basic = true,
        extra = true,
        extended = false,
      },
    })
  end,
}
