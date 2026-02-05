-- ============================================================================
-- MASON: LSP/DAP/Linter/Formatter package manager
-- ============================================================================
-- Manages installation of LSP servers, debuggers, linters, and formatters.
-- Uses mason-lspconfig for LSP server management and mason-tool-installer
-- for additional tools. Ensures commonly used language servers are installed:
-- CSS, Emmet, ESLint, Go, GraphQL, HTML, Java, Lua, Prisma, Python, Svelte,
-- Tailwind, and TypeScript (vtsls). Also installs formatters (prettier, stylua,
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
        "cssls",
        "emmet_ls",
        "eslint",
        "gopls",
        "graphql",
        "html",
        "jdtls",
        "lua_ls",
        "prismals",
        "pyright",
        "svelte",
        "tailwindcss",
        "vtsls", -- VSCode TypeScript Language Server
      },
      -- Prevent ts_ls from auto-starting (we use vtsls instead)
      handlers = {
        ["ts_ls"] = function() end, -- noop handler to skip ts_ls
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
        "tree-sitter-cli", -- required for nvim-treesitter parser compilation
        "java-debug-adapter", -- Java debugger
        "java-test", -- Java test runner
        "debugpy", -- Python debugger
        "js-debug-adapter", -- Node.js/TypeScript debugger
      },
    })
  end,
}
