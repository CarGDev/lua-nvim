return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    mason_lspconfig.setup({
      ensure_installed = {
        "cssls",
        "emmet_ls",
        "eslint",
        "gopls",
        "graphql",
        "html",
        -- "jdtls", -- uncomment if you're actively doing Java
        "lua_ls",
        "prismals",
        "pyright",
        "svelte",
        "tailwindcss",
        -- Database language servers
        "sqls", -- SQL language server
        "mongodb", -- MongoDB language server
        "redis", -- Redis language server
        "oracle", -- Oracle language server
        "cassandra", -- Cassandra language server
      },
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    vim.diagnostic.config({
      signs = {
        severity = {
          min = vim.diagnostic.severity.WARN,
        },
        icons = {
          Error = " ",
          Warn = " ",
          Hint = "󰠠 ",
          Info = " ",
        },
      },
    })

    local servers = {
      cssls = {},
      emmet_ls = {},
      eslint = {},
      gopls = {},
      graphql = {},
      html = {},
      -- jdtls = {}, -- same here
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      },
      prismals = {},
      pyright = {},
      svelte = {},
      tailwindcss = {},
      -- Database servers
      sqls = {
        settings = {
          sqls = {
            connections = {
              {
                name = "PostgreSQL",
                adapter = "postgresql",
                host = "localhost",
                port = 5432,
                database = "postgres",
                username = "postgres",
                password = "",
              },
              {
                name = "MySQL",
                adapter = "mysql",
                host = "localhost",
                port = 3306,
                database = "mysql",
                username = "root",
                password = "",
              },
            },
          },
        },
      },
      mongols = {
        settings = {
          mongols = {
            connectionString = "mongodb://localhost:27017",
            maxNumberOfProblems = 100,
          },
        },
      },
    }

    -- Set up all LSP servers
    for server_name, server_config in pairs(servers) do
      lspconfig[server_name].setup({
        capabilities = capabilities,
        settings = server_config.settings or {},
      })
    end

    -- Set up additional LSP servers that might not be in mason-lspconfig
    lspconfig.css_variables.setup({
      capabilities = capabilities,
    })

    lspconfig.cssmodules_ls.setup({
      capabilities = capabilities,
    })

    -- Set up TypeScript Tools
    require("typescript-tools").setup({
      settings = {
        tsserver_plugins = {},
        tsserver_file_preferences = {},
        tsserver_format_options = {},
      },
    })
  end,
}
