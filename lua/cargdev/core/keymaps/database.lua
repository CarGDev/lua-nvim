-- Database keymaps
-- Using <leader>D prefix to avoid conflicts with DAP keymaps (<leader>d)
local keymap = vim.keymap

-- =============================================================================
-- DATABASE KEYMAPS (vim-dadbod)
-- =============================================================================

-- Toggle database UI
keymap.set("n", "<leader>Du", "<cmd>DBUIToggle<CR>", { desc = "Toggle Database UI" })

-- Add a new database connection
keymap.set("n", "<leader>Da", "<cmd>DBUIAddConnection<CR>", { desc = "Add DB Connection" })

-- Find buffer (useful when you have multiple query buffers)
keymap.set("n", "<leader>Df", "<cmd>DBUIFindBuffer<CR>", { desc = "Find DB Buffer" })

-- Execute query (works in sql buffers)
keymap.set("n", "<leader>De", "<Plug>(DBUI_ExecuteQuery)", { desc = "Execute Query" })
keymap.set("v", "<leader>De", "<Plug>(DBUI_ExecuteQuery)", { desc = "Execute Selected Query" })

-- Save query
keymap.set("n", "<leader>Dw", "<Plug>(DBUI_SaveQuery)", { desc = "Save Query" })

-- Rename buffer
keymap.set("n", "<leader>Dr", "<Plug>(DBUI_RenameBuf)", { desc = "Rename DB Buffer" })

-- =============================================================================
-- QUICK CONNECTIONS
-- =============================================================================

-- PostgreSQL Docker (default: 5432 postgres postgres postgres)
keymap.set("n", "<leader>Dp", "<cmd>DBPostgresDocker<CR>", { desc = "Connect PostgreSQL Docker" })

-- =============================================================================
-- MONGODB
-- =============================================================================

-- Open MongoDB shell (local)
keymap.set("n", "<leader>Dm", "<cmd>MongoDB<CR>", { desc = "Open MongoDB Shell" })

-- Open MongoDB in Docker container
keymap.set("n", "<leader>DM", "<cmd>MongoDBDocker<CR>", { desc = "MongoDB Docker Shell" })

-- =============================================================================
-- REDIS
-- =============================================================================

-- Open Redis CLI (local)
keymap.set("n", "<leader>Di", "<cmd>Redis<CR>", { desc = "Open Redis CLI" })

-- Open Redis in Docker container
keymap.set("n", "<leader>DI", "<cmd>RedisDocker<CR>", { desc = "Redis Docker CLI" })
