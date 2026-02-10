-- ============================================================================
-- hlchunk: Chunk/scope highlighting
-- ============================================================================
-- Highlights code chunks and indentation levels with visual guides and lines.
-- Uses treesitter to accurately identify scope boundaries for the current chunk.
-- Draws connecting lines to show which code blocks belong together visually.
-- ============================================================================

return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
        priority = 15,
        style = {
          { fg = "#806d9c" },
          { fg = "#c21f30" },
        },
        use_treesitter = true,
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = ">",
        },
        textobject = "",
        max_file_size = 1024 * 1024,
        error_sign = true,
        duration = 200,
        delay = 300,
      },
      indent = {
        enable = false, -- Disabled: indent-blankline already handles indent guides
      },
      line_num = {
        enable = true,
        priority = 10,
        style = "#806d9c",
        use_treesitter = false,
      },
      blank = {
        enable = false,
        priority = 9,
        chars = { "․" },
        style = { { bg = "cursorline" }, { bg = "", fg = "" } },
      },
    })
  end,
}
