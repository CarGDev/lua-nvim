-- ============================================================================
-- CONFORM.NVIM: Code formatting on save and on demand
-- ============================================================================
-- Lightweight formatter plugin that supports multiple formatters per filetype.
-- Configured with format-on-save and custom formatters for SQL, XML, and more.
-- Provides <leader>mp keymap for manual formatting of selection or buffer.
-- ============================================================================

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
          stdin = true,
          cwd = require("conform.util").root_file({ ".git" }),
        },
        xmllint = {
          command = "xmllint",
          args = { "--format", "-" },
          stdin = true,
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
        xml = { "xmllint" },
        tex = { "latexindent" },
        lua = { "stylua" },
        python = { "isort", "black" },
        sql = { "sqlfluff" }, -- SQL formatting
        java = { "google-java-format" },
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
