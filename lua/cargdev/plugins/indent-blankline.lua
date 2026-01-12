return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  config = function()
    local hooks = require("ibl.hooks")

    -- Rainbow indent colors (subtle)
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#292e42" })
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#7aa2f7" })
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#3b3052" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#3b3939" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#2a3a52" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#3b3339" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#2a3b39" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#3a2a52" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#2a3b4a" })
    end)

    require("ibl").setup({
      indent = {
        char = "│",
        tab_char = "│",
        highlight = "IblIndent",
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        highlight = "IblScope",
        include = {
          node_type = {
            ["*"] = { "return_statement", "table_constructor" },
            lua = { "return_statement", "table_constructor", "function", "if_statement" },
            python = { "function_definition", "class_definition", "if_statement", "for_statement" },
            javascript = { "function_declaration", "arrow_function", "if_statement", "for_statement" },
            typescript = { "function_declaration", "arrow_function", "if_statement", "for_statement" },
          },
        },
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "snacks_dashboard",
          "neo-tree",
          "NvimTree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        buftypes = { "terminal", "nofile", "quickfix", "prompt" },
      },
    })
  end,
}
