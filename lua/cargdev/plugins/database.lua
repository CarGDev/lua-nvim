return {
  -- =============================================================================
  -- DATABASE PLUGINS
  -- =============================================================================

  -- Modern database client for Neovim (replaces vim-dadbod)
  {
    "kndndrj/nvim-dbee",
    build = function()
      -- Install the Go binary
      require("dbee").install()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("dbee").setup({
        -- Sources for database connections
        sources = {
          -- Load connections from memory (only guaranteed working connections)
          require("dbee.sources").MemorySource:new({
            -- PostgreSQL (confirmed working)
            {
              name = "mock_api",
              type = "postgres",
              url = "postgres://localhost:5432/mock_api?sslmode=disable",
            },
          }),
          -- Load connections from environment variable (for dynamic connections)
          require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
          -- Load connections from file (persistent storage - user-added connections)
          require("dbee.sources").FileSource:new(vim.fn.stdpath("cache") .. "/dbee/persistence.json"),
        },
        
        -- UI Configuration
        ui = {
          -- Layout configuration
          layout = {
            -- Drawer (left panel) width
            drawer_width = 30,
            -- Result buffer height
            result_height = 15,
            -- Editor buffer height
            editor_height = 10,
          },
        },
        
        -- Database configuration
        database = {
          -- Default page size for results
          page_size = 100,
          -- Connection timeout in seconds
          timeout = 30,
          -- Maximum number of connections
          max_connections = 5,
        },
        
        -- Logging configuration
        log = {
          -- Log level: "debug", "info", "warn", "error"
          level = "info",
          -- Log file path
          file = vim.fn.stdpath("cache") .. "/dbee/dbee.log",
        },
      })
    end,
  },

  -- SQL formatting and syntax highlighting
  {
    "b4winckler/vim-objc",
    ft = { "sql", "mysql", "postgresql", "oracle" },
  },

  -- SQL formatting with sqlparse
  {
    "b4winckler/vim-objc",
    ft = { "sql" },
    config = function()
      vim.g.sqlformat_command = "sqlformat"
      vim.g.sqlformat_options = "-r -k upper"
    end,
  },



  -- MongoDB syntax highlighting (without LSP)
  {
    "neovim/nvim-lspconfig",
    ft = { "javascript", "json" },
    config = function()
      -- Enable MongoDB syntax highlighting for .js files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "javascript", "json" },
        callback = function()
          vim.bo.filetype = "javascript"
        end,
      })
    end,
  },

  -- Redis syntax highlighting
  {
    "neovim/nvim-lspconfig",
    ft = { "redis" },
    config = function()
      -- Enable Redis syntax highlighting
      vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
        pattern = "*.redis",
        callback = function()
          vim.bo.filetype = "redis"
        end,
      })
    end,
  },

  -- CQL (Cassandra Query Language) syntax highlighting
  {
    "neovim/nvim-lspconfig",
    ft = { "cql" },
    config = function()
      -- Enable CQL syntax highlighting
      vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
        pattern = "*.cql",
        callback = function()
          vim.bo.filetype = "cql"
        end,
      })
    end,
  },
}

