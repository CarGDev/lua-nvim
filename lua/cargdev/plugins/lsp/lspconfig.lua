-- ============================================================================
-- LSPCONFIG: Language Server Protocol configuration
-- ============================================================================
-- Configures LSP servers for code intelligence (completions, diagnostics,
-- go-to-definition, etc.). Sets up servers for CSS, Emmet, ESLint, Go, GraphQL,
-- HTML, Lua, Prisma, Python, Svelte, Tailwind, and TypeScript (using vtsls).
-- Includes smart buffer attachment logic to skip binary files and large files.
-- Integrates with cmp-nvim-lsp for completion capabilities. Disables virtual
-- text diagnostics in favor of tiny-inline-diagnostic plugin. Has LspAttach
-- autocmd for client-specific configuration.
-- ============================================================================
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
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
        "lua_ls",
        "php",
        "prettierd",
        "prismals",
        "rust_analyzer",
        "pyright",
        "svelte",
        "tailwindcss",
        "vtsls", -- VSCode TypeScript Language Server - better moduleResolution support
      },
      -- Prevent ts_ls from auto-starting (we use vtsls instead)
      handlers = {
        ["ts_ls"] = function() end, -- noop handler to skip ts_ls
      },
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Enhanced error handling for LSP diagnostics
    -- NOTE: tiny-inline-diagnostic handles the display, so we disable virtual_text and float here
    vim.diagnostic.config({
      signs = true,
      update_in_insert = false,
      virtual_text = false,
      underline = true,
      severity_sort = true,
      float = false, -- Disabled - use <leader>sl for manual diagnostic float
    })

    -- Only attach to sensible buffers
    local function should_attach_lsp(bufnr)
      if type(bufnr) ~= "number" or bufnr == 0 then 
        bufnr = vim.api.nvim_get_current_buf() 
      end
      local ft = vim.bo[bufnr].filetype
      local name = vim.api.nvim_buf_get_name(bufnr)

      -- skip binaries / media
      local exts = { 
        "png", "jpg", "jpeg", "gif", "svg", "ico", "bmp", "webp",
        "mp4", "avi", "mov", "wmv", "flv", "webm", "mkv",
        "mp3", "wav", "flac", "aac", "ogg",
        "pdf", "doc", "docx", "xls", "xlsx", "ppt", "pptx",
        "zip", "rar", "7z", "tar", "gz", "bz2", "exe", "dll", "so", "dylib", "bin" 
      }
      for _, e in ipairs(exts) do 
        if name:match("%." .. e .. "$") then 
          return false 
        end 
      end

      local lines = vim.api.nvim_buf_line_count(bufnr)
      if lines == 0 or lines > 50000 then 
        return false 
      end

      local skip_ft = { 
        git = true, gitcommit = true, gitrebase = true, gitconfig = true,
        help = true, man = true, qf = true, quickfix = true, terminal = true, toggleterm = true 
      }
      if skip_ft[ft] then 
        return false 
      end

      return true
    end

    -- Shared on_attach
    local function on_attach(client, bufnr)
      if not should_attach_lsp(bufnr) then
        -- Detach politely; don't override client.request
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(bufnr) then
            vim.lsp.buf_detach_client(bufnr, client.id)
          else
            client.stop()
          end
        end)
        return
      end
      -- your normal keymaps/etc here
    end

    local servers = {
      cssls = { 
        settings = { 
          css = { 
            validate = true, 
            lint = { unknownAtRules = "ignore" } 
          } 
        } 
      },
      emmet_ls = {
        filetypes = { "html", "css", "sass", "scss", "less", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
      },
      eslint = { 
        settings = { workingDirectory = { mode = "auto" } } 
      },
      gopls = { 
        settings = { 
          gopls = { 
            analyses = { unusedparams = true }, 
            staticcheck = true, 
            usePlaceholders = true 
          } 
        } 
      },
      graphql = {
        filetypes = { "graphql", "gql", "typescript", "javascript", "typescriptreact", "javascriptreact" },
      }, 
      html = {
        filetypes = { "html" },
      },
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { 
              library = vim.api.nvim_get_runtime_file("", true), 
              checkThirdParty = false 
            },
            telemetry = { enable = false },
            hint = { enable = false },
          },
        },
      },
      prismals = {
        filetypes = { "prisma" },
      },
      php_ls = {},
      prettierd = {
        filetypes = {
          "css", "scss", "less", "html", "javascript", "javascriptreact",
          "typescript", "typescriptreact", "json", "jsonc", "yaml", "markdown",
          "mdx", "graphql", "sql", "rust",
        },
        settings = {
          prettier = {
            singleQuote = true,
            semi = false,
            tabWidth = 2,
            trailingComma = "all",
            printWidth = 100,
          },
        },
      },
      pyright = { 
        settings = { 
          python = { 
            analysis = { 
              typeCheckingMode = "basic", 
              autoImportCompletions = true 
            } 
          } 
        } 
      },
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--", "-W", "clippy::all" },
            },
            procMacro = { enable = true },
            inlayHints = {
              bindingModeHints = { enable = true },
              closingBraceHints = { enable = true, minLines = 25 },
              closureCaptureHints = { enable = true },
              closureReturnTypeHints = { enable = "always" },
              discriminantHints = { enable = "always" },
              expressionAdjustmentHints = { enable = "always" },
              implicitDrops = { enable = true },
              lifetimeElisionHints = { enable = "always" },
              reborrowHints = { enable = "always" },
              typeHints = { enable = true },
            },
          },
        },
      },
      svelte = {
        filetypes = { "svelte" },
      },
      tailwindcss = {
        filetypes = { "html", "css", "sass", "scss", "less", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
        init_options = {
          userLanguages = {
            html = "html",
            css = "css",
            javascript = "javascript",
            typescript = "typescript",
            javascriptreact = "javascriptreact",
            typescriptreact = "typescriptreact",
            vue = "vue",
            svelte = "svelte",
          },
        },
      },
      -- vtsls - VSCode TypeScript Language Server (better support for moduleResolution: "bundler")
      vtsls = {
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = false },
              variableTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = false },
              functionLikeReturnTypes = { enabled = false },
              enumMemberValues = { enabled = true },
            },
            suggest = {
              completeFunctionCalls = true,
            },
            updateImportsOnFileMove = { enabled = "always" },
          },
          javascript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = false },
              variableTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = false },
              functionLikeReturnTypes = { enabled = false },
              enumMemberValues = { enabled = true },
            },
            suggest = {
              completeFunctionCalls = true,
            },
            updateImportsOnFileMove = { enabled = "always" },
          },
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
        },
      },
      -- sqls = { settings = { sqls = { connections = { /* …your dbs… */ } } } }, -- optional
    }

    -- Set up all LSP servers with performance optimizations and error handling
    for name, cfg in pairs(servers) do
      local server_config = {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = { debounce_text_changes = 150 },
        handlers = {
          ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics,
            { virtual_text = false, signs = true, underline = true, update_in_insert = false }
          ),
        },
      }
      
      -- Add settings if present
      if cfg.settings then
        server_config.settings = cfg.settings
      end
      
      -- Add filetypes if present
      if cfg.filetypes then
        server_config.filetypes = cfg.filetypes
      end
      
      -- Add init_options if present
      if cfg.init_options then
        server_config.init_options = cfg.init_options
      end
      
      lspconfig[name].setup(server_config)
    end

    -- Set up additional LSP servers that might not be in mason-lspconfig
    lspconfig.css_variables.setup({
      capabilities = capabilities,
    })

    lspconfig.cssmodules_ls.setup({
      capabilities = capabilities,
    })

    -- Global LSP error handling
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = "rounded" }
    )
    
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = "rounded" }
    )
    
    -- Handle LSP errors gracefully
    vim.lsp.set_log_level("warn") -- Reduce log verbosity
    
    -- Add autocmd to handle LSP errors
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
          -- Add error handling for this client
          client.notify("workspace/didChangeConfiguration", {
            settings = {
              -- Add any client-specific error handling settings here
            }
          })
        end
      end,
    })
  end,
}
