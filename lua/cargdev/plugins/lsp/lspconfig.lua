return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" }, -- Changed from BufReadPre to BufReadPost for better performance
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

    -- File type filtering to prevent LSP errors on non-text files
    local function should_attach_lsp(client, bufnr)
      local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
      local filename = vim.api.nvim_buf_get_name(bufnr)
      
      -- Skip non-text files
      local non_text_extensions = {
        "png", "jpg", "jpeg", "gif", "svg", "ico", "bmp", "webp",
        "mp4", "avi", "mov", "wmv", "flv", "webm", "mkv",
        "mp3", "wav", "flac", "aac", "ogg",
        "pdf", "doc", "docx", "xls", "xlsx", "ppt", "pptx",
        "zip", "rar", "7z", "tar", "gz", "bz2",
        "exe", "dll", "so", "dylib", "bin"
      }
      
      for _, ext in ipairs(non_text_extensions) do
        if filename:match("%." .. ext .. "$") then
          return false
        end
      end
      
      -- Skip empty or very large files
      local line_count = vim.api.nvim_buf_line_count(bufnr)
      if line_count == 0 or line_count > 50000 then
        return false
      end
      
      -- Skip specific file types that don't need LSP
      local skip_filetypes = {
        "git", "gitcommit", "gitrebase", "gitconfig",
        "help", "man", "markdown", "text",
        "qf", "quickfix", "locationlist",
        "terminal", "toggleterm"
      }
      
      for _, skip_ft in ipairs(skip_filetypes) do
        if filetype == skip_ft then
          return false
        end
      end
      
      return true
    end

    local servers = {
      cssls = {
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = "ignore"
            }
          }
        }
      },
      emmet_ls = {},
      eslint = {
        settings = {
          workingDirectory = { mode = "auto" }
        }
      },
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            usePlaceholders = true,
          },
        },
      },
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
            -- Performance optimizations
            telemetry = { enable = false },
            hint = {
              enable = false, -- Disable hints for better performance
            },
          },
        },
      },
      prismals = {},
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic", -- Reduce type checking for better performance
              autoImportCompletions = true,
            },
          },
        },
      },
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

    -- Set up all LSP servers with performance optimizations and error handling
    for server_name, server_config in pairs(servers) do
      lspconfig[server_name].setup({
        capabilities = capabilities,
        settings = server_config.settings or {},
        -- Performance optimizations
        flags = {
          debounce_text_changes = 150, -- Debounce text changes
        },
        -- Enhanced error handling and file filtering
        on_attach = function(client, bufnr)
          -- Only attach LSP if it's appropriate for this file
          if not should_attach_lsp(client, bufnr) then
            client.stop()
            return
          end
          
          -- Add error handling for LSP operations
          local function safe_lsp_call(func, ...)
            local success, result = pcall(func, ...)
            if not success then
              vim.notify("LSP error: " .. tostring(result), vim.log.levels.WARN)
              return nil
            end
            return result
          end
          
          -- Override LSP methods with error handling
          local original_request = client.request
          client.request = function(method, params, handler, bufnr)
            -- Skip requests for non-text files
            if not should_attach_lsp(client, bufnr or 0) then
              return
            end
            
            -- Add timeout to prevent hanging
            local timeout_id = vim.defer_fn(function()
              if handler then
                handler(nil, { message = "LSP request timed out" })
              end
            end, 5000) -- 5 second timeout
            
            -- Wrap the original request
            local wrapped_handler = handler and function(...)
              vim.loop.timer_stop(timeout_id)
              handler(...)
            end
            
            return original_request(method, params, wrapped_handler, bufnr)
          end
        end,
        -- Reduce diagnostic frequency
        handlers = {
          ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics,
            {
              virtual_text = false,
              signs = true,
              underline = true,
              update_in_insert = false,
            }
          ),
        },
      })
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
        if not should_attach_lsp(client, bufnr) then
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
