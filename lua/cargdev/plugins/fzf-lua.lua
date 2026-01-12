return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({
      "default",
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = "rounded",
        preview = {
          layout = "flex",
          flip_columns = 120,
          scrollbar = "float",
        },
      },
      keymap = {
        builtin = {
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        },
      },
      lsp = {
        async_or_timeout = 5000,
        jump_to_single_result = true,
        ignore_current_line = true,
      },
      diagnostics = {
        severity_limit = vim.diagnostic.severity.HINT,
      },
    })
  end,
}
