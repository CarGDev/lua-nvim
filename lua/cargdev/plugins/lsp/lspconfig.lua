return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
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
        "lua_ls",
        "prismals",
        "pyright",
        "svelte",
        "tailwindcss",
        "ts_ls",
      },
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Enhanced error handling for LSP diagnostics
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
      -- Performance optimizations
      update_in_insert = false, -- Don't update diagnostics in insert mode
      virtual_text = false, -- Disable virtual text for better performance
      underline = true, -- Keep underline for errors
      severity_sort = true, -- Sort diagnostics by severity
      -- Error handling
      float = {
        border = "rounded",
        source = "always",
        format = function(diagnostic)
          if diagnostic.source == "LSP" then
            return string.format("%s [%s]", diagnostic.message, diagnostic.source)
          end
          return diagnostic.message
        end,
      },
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
      ts_ls = {
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
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

    -- Set up TypeScript Tools with performance optimizations and error handling
    require("typescript-tools").setup({
      settings = {
        tsserver_plugins = {},
        tsserver_file_preferences = {},
        tsserver_format_options = {},
        -- Performance optimizations
        tsserver_max_tsc_memory = 4096, -- Limit memory usage
        tsserver_experimental_enableProjectDiagnostics = false, -- Disable project diagnostics for better performance
      },
      -- Add error handling for TypeScript Tools
      on_attach = function(client, bufnr)
        if not should_attach_lsp(bufnr) then
          client.stop()
          return
        end
      end,
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
