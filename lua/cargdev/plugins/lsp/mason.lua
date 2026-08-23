-- ============================================================================
-- MASON: LSP/DAP/Linter/Formatter package manager
-- ============================================================================
-- Manages installation of LSP servers, debuggers, linters, and formatters.
-- Uses mason-lspconfig for LSP server management and mason-tool-installer
-- for additional tools. Ensures commonly used language servers are installed:
-- Arduino, CSS, Emmet, ESLint, Go, GraphQL, HTML, Java, Lua, Prisma, Python,
-- Svelte, Tailwind, and TypeScript (vtsls). Also installs formatters (prettier, stylua,
-- black, isort) and debuggers (debugpy, java-debug-adapter, js-debug-adapter).
-- ============================================================================
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "arduino_language_server",
        "clangd",
        "cssls",
        "emmet_ls",
        "eslint",
        "gopls",
        "graphql",
        "html",
        "jdtls",
        "lua_ls",
        "phpactor",
        "prismals",
        "pyright",
        "svelte",
        "tailwindcss",
        "vtsls", -- VSCode TypeScript Language Server
      },
      -- mason-lspconfig v2: exclude servers from vim.lsp.enable()
      automatic_enable = {
        exclude = { "jdtls", "ts_ls", "lua_ls" }, -- jdtls: ftplugin/java.lua; ts_ls: we use vtsls
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint",
        "eslint_d",
        "clang-format", -- C/C++ formatter
        "tree-sitter-cli", -- required for nvim-treesitter parser compilation
        "java-debug-adapter", -- Java debugger
        "java-test", -- Java test runner
        "debugpy", -- Python debugger
        "js-debug-adapter", -- Node.js/TypeScript debugger
      },
    })
  end,
}
