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
      format_on_save = function(bufnr)
        -- Disable autoformat for certain filetypes
        local ignore_filetypes = { "sql", "markdown" }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        -- Disable for files in certain paths
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/node_modules/") then
          return
        end
        return {
          timeout_ms = 2000,
          lsp_fallback = true,
        }
      end,
    })

    vim.keymap.set({ "n", "v" }, "<leader>mm", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 2000,
      })
    end, { desc = "Format: File or range (in visual mode)" })

    -- Toggle auto-format on save
    vim.api.nvim_create_user_command("FormatToggle", function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      if vim.g.disable_autoformat then
        vim.notify("Auto-format on save disabled", vim.log.levels.INFO)
      else
        vim.notify("Auto-format on save enabled", vim.log.levels.INFO)
      end
    end, { desc = "Toggle auto-format on save" })
  end,
}
