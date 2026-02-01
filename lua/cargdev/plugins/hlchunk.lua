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
        enable = true,
        priority = 10,
        style = { { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") } },
        use_treesitter = false,
        chars = { "│" },
        ahead_lines = 5,
        delay = 100,
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
