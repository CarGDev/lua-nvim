return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    local api = vim.api
    local keymap = vim.keymap

    lint.linters.dbml = {
      cmd = "dbml",
      args = { "lint" },
      stdin = false,
      stream = "stdout",
      ignore_exitcode = true,
      parser = function(output, bufnr)
        local diagnostics = {}
        for line in output:gmatch("[^\r\n]+") do
          local lnum, col, msg = line:match("(%d+):(%d+):%s*(.*)")
          if lnum and msg then
            table.insert(diagnostics, {
              bufnr = bufnr,
              lnum = tonumber(lnum) - 1,
              col = tonumber(col) - 1,
              message = msg,
              severity = vim.diagnostic.severity.WARN,
            })
          end
        end
        return diagnostics
      end,
    }

    lint.linters.sqlfluff = {
      cmd = "sqlfluff",
      args = { "lint", "--format", "json" },
      stdin = false,
      stream = "stdout",
      ignore_exitcode = true,
      parser = function(output, bufnr)
        local diagnostics = {}
        local parsed = vim.fn.json_decode(output)
        if parsed and parsed[1] and parsed[1].violations then
          for _, issue in ipairs(parsed[1].violations) do
            table.insert(diagnostics, {
              bufnr = bufnr,
              lnum = issue.line_no - 1,
              col = issue.line_pos - 1,
              message = issue.description,
              severity = vim.diagnostic.severity.WARN,
            })
          end
        end
        return diagnostics
      end,
    }

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
      dbml = { "dbml" },
      sql = { "sqlfluff" },
      html = { "htmlhint" },
      java = { "checkstyle" },
      tex = { "chktex" },
    }

    -- Set full path for chktex (TeX binaries may not be in Neovim's PATH)
    lint.linters.chktex.cmd = "/Library/TeX/texbin/chktex"

    local lint_augroup = api.nvim_create_augroup("lint", { clear = true })

    api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
