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
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  opts = {
    -- enable syntax highlighting
    highlight = {
      enable = true,
      -- Performance optimizations
      use_languagetree = true,
      additional_vim_regex_highlighting = false,
    },
    -- enable indentation
    indent = { enable = true },
    -- enable autotagging (w/ nvim-ts-autotag plugin)
    autotag = {
      enable = true,
    },
    -- ensure these language parsers are installed
    ensure_installed = {
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
      "latex",
      "norg",
      "typst",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    -- Performance optimizations
    playground = {
      enable = false, -- Disable playground for better performance
    },
    query_linter = {
      enable = false, -- Disable query linter for better performance
    },
  },
}
