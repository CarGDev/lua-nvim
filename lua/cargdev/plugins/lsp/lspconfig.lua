return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
    { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim" } }
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    mason_lspconfig.setup({
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
        "tsserver"
      }
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Define signs for diagnostics
    vim.diagnostic.config({
      signs = {
        severity = {
          min = vim.diagnostic.severity.WARN
        },
        icons = {
          Error = " ",
          Warn = " ",
          Hint = "󰠠 ",
          Info = " "
        }
      }
    })

    local servers = {
      cssls = {},
      emmet_ls = {},
      eslint = {},
      gopls = {},
      graphql = {},
      html = {},
      jdtls = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false
            }
          }
        }
      },
      prismals = {},
      pyright = {},
      svelte = {},
      tailwindcss = {},
      tsserver = {}
    }

    for server, config in pairs(servers) do
      config.capabilities = capabilities
      lspconfig[server].setup(config)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local mappings = {
          ["gR"] = { "<cmd>Telescope lsp_references<CR>", "Show LSP references" },
          ["gD"] = { vim.lsp.buf.declaration, "Go to declaration" },
          ["gd"] = { "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions" },
          ["gi"] = { "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations" },
          ["gt"] = { "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions" },
          ["<leader>ca"] = { vim.lsp.buf.code_action, "See available code actions" },
          ["<leader>rn"] = { vim.lsp.buf.rename, "Smart rename" },
          ["<leader>D"] = { "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics" },
          ["<leader>dd"] = { vim.diagnostic.open_float, "Show line diagnostics" },
          ["[d"] = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
          ["]d"] = { vim.diagnostic.goto_next, "Go to next diagnostic" },
          ["K"] = { vim.lsp.buf.hover, "Show documentation for cursor" },
          ["<leader>rs"] = { ":LspRestart<CR>", "Restart LSP" }
        }

        for key, map in pairs(mappings) do
          keymap.set("n", key, map[1], { desc = map[2], silent = true })
        end

        vim.api.nvim_create_autocmd("CursorHold", {
          buffer = ev.buf,
          callback = function()
            vim.diagnostic.open_float(nil, { focusable = false })
          end
        })

        vim.o.updatetime = 250
      end
    })
  end
}
