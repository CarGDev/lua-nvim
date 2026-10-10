-- ============================================================================
-- NVIM-LINT: Asynchronous linting for Neovim
-- ============================================================================
-- Provides linting via external tools with support for custom linter configs.
-- Automatically triggers linting on BufEnter, BufWritePost, and InsertLeave.
-- Includes custom DBML linter and keymaps for manual lint triggers.
-- ============================================================================

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

    -- Prolog: swipl itself reports syntax errors and warnings (singletons,
    -- discontiguous clauses) while loading. NOTE: loading runs the file's
    -- directives, same as consulting it by hand.
    lint.linters.swipl = {
      cmd = "swipl",
      args = { "-q", "-t", "halt" },
      stdin = false,
      append_fname = true,
      stream = "stderr",
      ignore_exitcode = true,
      parser = function(output, bufnr)
        local diagnostics = {}
        local cur -- last "Warning: file:line:" header, followed by message lines
        for line in output:gmatch("[^\r\n]+") do
          local sev, lnum, col, msg = line:match("^(%a+): [^:]+:(%d+):(%d*):?%s*(.*)$")
          if sev and (sev == "ERROR" or sev == "Warning") then
            local severity = sev == "ERROR" and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN
            if msg ~= "" then
              table.insert(diagnostics, {
                bufnr = bufnr,
                lnum = tonumber(lnum) - 1,
                col = tonumber(col) and tonumber(col) - 1 or 0,
                message = msg,
                severity = severity,
                source = "swipl",
              })
              cur = nil
            else
              cur = { lnum = tonumber(lnum) - 1, severity = severity }
            end
          elseif cur then
            local detail = line:match("^Warning:%s+(.*)$") or line:match("^ERROR:%s+(.*)$")
            if detail then
              table.insert(diagnostics, {
                bufnr = bufnr,
                lnum = cur.lnum,
                col = 0,
                message = detail,
                severity = cur.severity,
                source = "swipl",
              })
              cur = nil
            end
          end
        end
        return diagnostics
      end,
    }

    -- JS/TS/Svelte are linted by the eslint LSP (lspconfig.lua), which uses the
    -- project's own eslint + config. eslint_d here ran from nvim's cwd with
    -- its own resolution and ignored project rules, and duplicated diagnostics.
    lint.linters_by_ft = {
      python = { "ruff" },
      -- cppcheck is optional (brew install cppcheck); clangd covers C diagnostics
      c = vim.fn.executable("cppcheck") == 1 and { "cppcheck" } or {},
      dbml = { "dbml" },
      sql = { "sqlfluff" },
      html = { "htmlhint" },
      java = { "checkstyle" },
      tex = { "chktex" },
      prolog = vim.fn.executable("swipl") == 1 and { "swipl" } or {},
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

    keymap.set("n", "<leader>lf", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
