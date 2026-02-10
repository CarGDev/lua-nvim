--- Database keymaps (vim-dadbod, MongoDB, Redis).
--- Uses `<leader>D` prefix to avoid conflicts with DAP keymaps (`<leader>d`).
--- Covers DBUI toggle, connections, query execution/saving, buffer management,
--- and quick-connect shortcuts for PostgreSQL Docker, MongoDB, and Redis.
--- @module keymaps.database

local keymap = vim.keymap

-- =============================================================================
-- DATABASE KEYMAPS (vim-dadbod)
-- =============================================================================

--- Toggle the vim-dadbod Database UI panel.
keymap.set("n", "<leader>Du", "<cmd>DBUIToggle<CR>", { desc = "Toggle Database UI" })

--- Add a new database connection interactively.
keymap.set("n", "<leader>Da", "<cmd>DBUIAddConnection<CR>", { desc = "Add DB Connection" })

--- Find a DBUI query buffer (useful when multiple query buffers are open).
keymap.set("n", "<leader>Df", "<cmd>DBUIFindBuffer<CR>", { desc = "Find DB Buffer" })

--- Execute a SQL query (full buffer in normal mode, selection in visual mode).
keymap.set("n", "<leader>De", "<Plug>(DBUI_ExecuteQuery)", { desc = "Execute Query" })
keymap.set("v", "<leader>De", "<Plug>(DBUI_ExecuteQuery)", { desc = "Execute Selected Query" })

--- Save the current query buffer to disk.
keymap.set("n", "<leader>Dw", "<Plug>(DBUI_SaveQuery)", { desc = "Save Query" })

--- Rename the current DBUI query buffer.
keymap.set("n", "<leader>Dr", "<Plug>(DBUI_RenameBuf)", { desc = "Rename DB Buffer" })

-- =============================================================================
-- QUICK CONNECTIONS
-- =============================================================================

--- Connect to a PostgreSQL instance running in Docker (default port 5432).
keymap.set("n", "<leader>Dp", "<cmd>DBPostgresDocker<CR>", { desc = "Connect PostgreSQL Docker" })

-- =============================================================================
-- MONGODB
-- =============================================================================

--- Open a local MongoDB shell.
keymap.set("n", "<leader>Dm", "<cmd>MongoDB<CR>", { desc = "Open MongoDB Shell" })

--- Open a MongoDB shell inside a Docker container.
keymap.set("n", "<leader>DM", "<cmd>MongoDBDocker<CR>", { desc = "MongoDB Docker Shell" })

-- =============================================================================
-- REDIS
-- =============================================================================

--- Open a local Redis CLI session.
keymap.set("n", "<leader>Di", "<cmd>Redis<CR>", { desc = "Open Redis CLI" })

--- Open a Redis CLI session inside a Docker container.
keymap.set("n", "<leader>DI", "<cmd>RedisDocker<CR>", { desc = "Redis Docker CLI" })
