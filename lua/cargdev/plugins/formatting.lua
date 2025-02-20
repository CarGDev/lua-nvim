return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters = {
        sqlfluff = {
          command = "sqlfluff",
          args = { "format", "--dialect", "postgres", "-" },
          stdin = true, -- Ensure it uses stdin
          cwd = require("conform.util").root_file({ ".git" }),
        },
      },
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
        dbml = { "dbml" }, -- DBML formatting
        sql = { "sqlfluff" }, -- SQL formatting
      },
      format_on_save = false, -- Set to true if you want auto-formatting on save
    })

    vim.keymap.set({ "n", "v" }, "<leader>mm", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 2000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
