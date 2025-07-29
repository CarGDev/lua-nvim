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
    }

    for server, config in pairs(servers) do
      config.capabilities = capabilities
      lspconfig[server].setup(config)
    end

    -- ✅ Correct way to setup typescript-tools
    require("typescript-tools").setup({
      capabilities = capabilities,
      -- optional settings:
      -- settings = {
      --   tsserver_plugins = {},
      --   tsserver_max_memory = 4096,
      -- }
    })

    -- LSP keymaps are now handled in the main keymaps.lua file
    -- This ensures consistent keymaps across all file types
  end,
}
