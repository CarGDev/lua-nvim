return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod" }, -- Remove lazy = true, needs to load with UI
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
    "DBUIRenameBuffer",
    "DBUILastQueryInfo",
  },
  keys = {
    { "<leader>Du", "<cmd>DBUIToggle<CR>", desc = "Toggle Database UI" },
    { "<leader>Da", "<cmd>DBUIAddConnection<CR>", desc = "Add DB Connection" },
  },
  init = function()
    -- Database UI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_force_echo_notifications = 1

    -- Save query results to a file
    vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"

    -- Use better split
    vim.g.db_ui_win_position = "left"
    vim.g.db_ui_winwidth = 40

    -- Table helpers
    vim.g.db_ui_table_helpers = {
      postgresql = {
        Count = "SELECT COUNT(*) FROM {table}",
        List = "SELECT * FROM {table} LIMIT 100",
        Schema = "\\d+ {table}",
        Indexes = "SELECT * FROM pg_indexes WHERE tablename = '{table}'",
        Size = "SELECT pg_size_pretty(pg_total_relation_size('{table}'))",
      },
      mysql = {
        Count = "SELECT COUNT(*) FROM {table}",
        List = "SELECT * FROM {table} LIMIT 100",
        Schema = "DESCRIBE {table}",
        Indexes = "SHOW INDEX FROM {table}",
      },
      sqlite = {
        Count = "SELECT COUNT(*) FROM {table}",
        List = "SELECT * FROM {table} LIMIT 100",
        Schema = ".schema {table}",
      },
    }

    -- Icons
    vim.g.db_ui_icons = {
      expanded = "▾",
      collapsed = "▸",
      saved_query = "*",
      new_query = "+",
      tables = "~",
      buffers = "»",
      connection_ok = "✓",
      connection_error = "✕",
    }

    -- Quick connect to Docker PostgreSQL
    -- Use 127.0.0.1 instead of localhost (localhost may resolve to IPv6)
    vim.api.nvim_create_user_command("DBPostgresDocker", function(opts)
      local args = opts.args
      local port = "5432"
      local user = "postgres"
      local password = "postgres"
      local database = "postgres"

      -- Parse arguments: port user password database
      local parts = vim.split(args, " ")
      if parts[1] and parts[1] ~= "" then port = parts[1] end
      if parts[2] and parts[2] ~= "" then user = parts[2] end
      if parts[3] and parts[3] ~= "" then password = parts[3] end
      if parts[4] and parts[4] ~= "" then database = parts[4] end

      local url = string.format("postgresql://%s:%s@127.0.0.1:%s/%s", user, password, port, database)
      -- Set the connection and open DBUI
      local dbs = vim.g.dbs or {}
      dbs[database] = url
      vim.g.dbs = dbs
      vim.cmd("DBUIToggle")
      vim.notify("Added PostgreSQL connection: " .. database, vim.log.levels.INFO)
    end, {
      nargs = "*",
      desc = "Connect to Docker PostgreSQL (args: port user password database)",
    })

    -- MongoDB terminal command
    vim.api.nvim_create_user_command("MongoDB", function(opts)
      local args = opts.args
      local cmd = "mongosh"
      if args and args ~= "" then
        cmd = cmd .. " " .. args
      else
        cmd = cmd .. " mongodb://127.0.0.1:27017"
      end
      vim.cmd("terminal " .. cmd)
      vim.cmd("startinsert")
    end, {
      nargs = "*",
      desc = "Open MongoDB shell (args: connection string or options)",
    })

    -- Redis terminal command
    vim.api.nvim_create_user_command("Redis", function(opts)
      local args = opts.args
      local cmd = "redis-cli"
      if args and args ~= "" then
        cmd = cmd .. " " .. args
      else
        cmd = cmd .. " -h 127.0.0.1 -p 6379"
      end
      vim.cmd("terminal " .. cmd)
      vim.cmd("startinsert")
    end, {
      nargs = "*",
      desc = "Open Redis CLI (args: host/port options)",
    })

    -- MongoDB with Docker
    vim.api.nvim_create_user_command("MongoDBDocker", function(opts)
      local container = opts.args ~= "" and opts.args or "mongodb"
      vim.cmd("terminal docker exec -it " .. container .. " mongosh")
      vim.cmd("startinsert")
    end, {
      nargs = "?",
      desc = "Open MongoDB shell in Docker container (arg: container name)",
    })

    -- Redis with Docker
    vim.api.nvim_create_user_command("RedisDocker", function(opts)
      local container = opts.args ~= "" and opts.args or "redis"
      vim.cmd("terminal docker exec -it " .. container .. " redis-cli")
      vim.cmd("startinsert")
    end, {
      nargs = "?",
      desc = "Open Redis CLI in Docker container (arg: container name)",
    })
  end,
  config = function()
    -- Setup completion for sql files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sql", "mysql", "plsql" },
      callback = function()
        local ok, cmp = pcall(require, "cmp")
        if ok then
          cmp.setup.buffer({
            sources = {
              { name = "vim-dadbod-completion" },
              { name = "buffer" },
            },
          })
        end
      end,
    })

    -- Also setup completion for dbui buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "dbui" },
      callback = function()
        -- Enable line numbers in dbui
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
      end,
    })
  end,
}
