-- ============================================================================
-- TREESITTER: Syntax parsing for better highlighting and code understanding
-- ============================================================================
-- Core plugin for modern syntax highlighting, code folding, and text objects.
-- Parses code into AST for accurate highlighting. Many plugins depend on it
-- (autopairs, comments, autotag, etc). Auto-installs parsers for languages.
-- ============================================================================
return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" }, -- Changed from BufReadPre to BufReadPost for better performance
  build = function()
    -- Install tree-sitter-cli if not available, then update parsers
    if vim.fn.executable("tree-sitter") == 0 then
      vim.notify("tree-sitter-cli not found. Please install it: npm install -g tree-sitter-cli", vim.log.levels.WARN)
    end
    vim.cmd("TSUpdate")
  end,
  -- nvim-treesitter `main` branch: it no longer reads `opts.ensure_installed`
  -- or `highlight.enable`. Parsers must be installed with `.install()` and
  -- highlighting started per buffer with `vim.treesitter.start()`.
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup({})

    -- Parsers to install (already-installed ones are skipped; compiled async
    -- with the tree-sitter CLI from mason).
    local parsers = {
      "json",
      "javascript",
      "typescript",
      "java",
      "tsx",
      "yaml",
      "html",
      "css",
      "scss",
      "prisma",
      "markdown",
      "markdown_inline",
      "svelte",
      "vue",
      "graphql",
      "sql",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
      "query",
      "vimdoc",
      "c",
      "python",
      "cpp",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "rust",
      "prolog",
      "toml",
      "latex",
      "norg",
      "typst",
    }
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
    if not vim.env.PATH:find(mason_bin, 1, true) then
      vim.env.PATH = mason_bin .. ":" .. vim.env.PATH -- so `tree-sitter` CLI is found
    end
    ts.install(parsers)

    -- Treesitter highlighting only for these filetypes, so Java/JS/TS keep
    -- their current colors. Others fall back to Vim regex syntax.
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("cargdev_ts_highlight", { clear = true }),
      pattern = { "go", "gomod", "gosum", "gowork", "rust", "python", "c", "cpp", "toml", "prolog" },
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
