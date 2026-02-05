-- ============================================================================
-- SSR.NVIM: Structural Search and Replace
-- ============================================================================
-- Provides syntax-aware search and replace using Treesitter for intelligent
-- code transformations. Unlike regex-based search/replace, it understands
-- code structure and can match patterns based on AST nodes.
--
-- Keymaps:
--   <leader>sR - Open structural search/replace (normal and visual mode)
--   q          - Close the SSR window
--   n/N        - Navigate to next/previous match
--   <cr>       - Confirm replacement
--   <leader><cr> - Replace all matches
-- ============================================================================
return {
  "cshuaimin/ssr.nvim",
  keys = {
    {
      "<leader>sR",
      function()
        require("ssr").open()
      end,
      mode = { "n", "x" },
      desc = "Structural search/replace",
    },
  },
  opts = {
    border = "rounded",
    min_width = 50,
    min_height = 5,
    max_width = 120,
    max_height = 25,
    adjust_window = true,
    keymaps = {
      close = "q",
      next_match = "n",
      prev_match = "N",
      replace_confirm = "<cr>",
      replace_all = "<leader><cr>",
    },
  },
}
