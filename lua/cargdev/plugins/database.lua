-- Temporarily disabled to fix database error
-- return {
--   -- =============================================================================
--   -- DATABASE PLUGINS
--   -- =============================================================================

--   -- Database client for Neovim
--   {
--     "tpope/vim-dadbod",
--     dependencies = {
--       "kristijanhusak/vim-dadbod-ui",
--       "kristijanhusak/vim-dadbod-completion",
--     },
--     config = function()
--       -- Dadbod UI configuration
--       vim.g.db_ui_use_nerd_fonts = 1
--       vim.g.db_ui_winwidth = 30
--       vim.g.db_ui_winposition = "right"
--       vim.g.db_ui_show_help = 0
--       vim.g.db_ui_auto_execute_table_helpers = 1
      
--       -- Disable auto-connection to prevent errors
--       vim.g.db_ui_auto_execute_table_helpers = 0
--       vim.g.db_ui_show_database_icon = 0
--       vim.g.db_ui_winwidth = 30
--       vim.g.db_ui_winposition = "right"
--       vim.g.db_ui_use_nerd_fonts = 1
--       vim.g.db_ui_show_help = 0
      
--       -- Disable automatic database loading
--       vim.g.db_ui_auto_execute_table_helpers = 0
--       vim.g.db_ui_show_database_icon = 0
--       vim.g.db_ui_auto_execute_table_helpers = 0
--       vim.g.db_ui_show_database_icon = 0
      
--       vim.g.db_ui_table_helpers = {
--         sqlite = {
--           count = "SELECT COUNT(*) FROM {table}",
--           explain = "EXPLAIN QUERY PLAN {last_query}",
--           indexes = "PRAGMA index_list({table})",
--           show = "PRAGMA table_info({table})",
--           size = "SELECT page_count * page_size as size FROM pragma_page_count(), pragma_page_size() WHERE name = '{table}'",
--         },
--         mysql = {
--           count = "SELECT COUNT(*) FROM {table}",
--           explain = "EXPLAIN {last_query}",
--           indexes = "SHOW INDEX FROM {table}",
--           show = "SHOW CREATE TABLE {table}",
--           size = "SELECT ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)' FROM information_schema.TABLES WHERE table_schema = '{database}' AND table_name = '{table}'",
--         },
--         postgresql = {
--           count = "SELECT COUNT(*) FROM {table}",
--           explain = "EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON) {last_query}",
--           indexes = "SELECT indexname, indexdef FROM pg_indexes WHERE tablename = '{table}'",
--           show = "\\d {table}",
--           size = "SELECT pg_size_pretty(pg_total_relation_size('{table}'))",
--         },
--         redis = {
--           count = "LLEN {table}",
--           explain = "SLOWLOG GET 10",
--           indexes = "KEYS *",
--           show = "TYPE {table}",
--           size = "MEMORY USAGE {table}",
--         },
--       }

--       -- Dadbod completion
--       vim.g.vim_dadbod_completion_mark = "📊"
      
--       -- Configure database adapters
--       vim.g.db_adapter_sqlite = 'sqlite3'
--       vim.g.db_adapter_mysql = 'mysql'
--       vim.g.db_adapter_postgresql = 'psql'
--       vim.g.db_adapter_redis = 'redis-cli'
      
--       -- Disable automatic database connections
--       vim.g.db_ui_auto_execute_table_helpers = 0
--       vim.g.db_ui_show_database_icon = 0
--     end,
--   },

--   -- SQL formatting and syntax highlighting
--   {
--     "b4winckler/vim-objc",
--     ft = { "sql", "mysql", "postgresql" },
--   },

--   -- SQL formatting with sqlparse
--   {
--     "b4winckler/vim-objc",
--     ft = { "sql" },
--     config = function()
--       vim.g.sqlformat_command = "sqlformat"
--       vim.g.sqlformat_options = "-r -k upper"
--     end,
--   },
-- }

-- Return empty table to prevent errors
return {
  -- =============================================================================
  -- DATABASE PLUGINS
  -- =============================================================================

  -- Database client for Neovim
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      -- Disable all automatic database operations
      vim.g.db_ui_auto_execute_table_helpers = 0
      vim.g.db_ui_show_database_icon = 0
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_winwidth = 30
      vim.g.db_ui_winposition = "right"
      vim.g.db_ui_show_help = 0
      
      -- Disable automatic database loading completely
      vim.g.db_ui_auto_execute_table_helpers = 0
      vim.g.db_ui_show_database_icon = 0
      
      -- Configure table helpers (only used when manually triggered)
      vim.g.db_ui_table_helpers = {
        sqlite = {
          count = "SELECT COUNT(*) FROM {table}",
          explain = "EXPLAIN QUERY PLAN {last_query}",
          indexes = "PRAGMA index_list({table})",
          show = "PRAGMA table_info({table})",
          size = "SELECT page_count * page_size as size FROM pragma_page_count(), pragma_page_size() WHERE name = '{table}'",
        },
        mysql = {
          count = "SELECT COUNT(*) FROM {table}",
          explain = "EXPLAIN {last_query}",
          indexes = "SHOW INDEX FROM {table}",
          show = "SHOW CREATE TABLE {table}",
          size = "SELECT ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)' FROM information_schema.TABLES WHERE table_schema = '{database}' AND table_name = '{table}'",
        },
        postgresql = {
          count = "SELECT COUNT(*) FROM {table}",
          explain = "EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON) {last_query}",
          indexes = "SELECT indexname, indexdef FROM pg_indexes WHERE tablename = '{table}'",
          show = "\\d {table}",
          size = "SELECT pg_size_pretty(pg_total_relation_size('{table}'))",
        },
        redis = {
          count = "LLEN {table}",
          explain = "SLOWLOG GET 10",
          indexes = "KEYS *",
          show = "TYPE {table}",
          size = "MEMORY USAGE {table}",
        },
      }

      -- Dadbod completion
      vim.g.vim_dadbod_completion_mark = "📊"
      
      -- Configure database adapters
      vim.g.db_adapter_sqlite = 'sqlite3'
      vim.g.db_adapter_mysql = 'mysql'
      vim.g.db_adapter_postgresql = 'psql'
      vim.g.db_adapter_redis = 'redis-cli'
      
      -- Ensure no automatic connections
      vim.g.db_ui_auto_execute_table_helpers = 0
      vim.g.db_ui_show_database_icon = 0
    end,
  },

  -- SQL formatting and syntax highlighting
  {
    "b4winckler/vim-objc",
    ft = { "sql", "mysql", "postgresql" },
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
} 