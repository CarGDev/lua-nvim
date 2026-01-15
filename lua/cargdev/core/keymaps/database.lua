-- Database keymaps
local keymap = vim.keymap

-- =============================================================================
-- DATABASE KEYMAPS (vim-dadbod)
-- =============================================================================

-- Toggle database UI
keymap.set("n", "<leader>du", "<cmd>DBUIToggle<CR>", { desc = "Toggle Database UI" })

-- Add a new database connection
keymap.set("n", "<leader>da", "<cmd>DBUIAddConnection<CR>", { desc = "Add DB Connection" })

-- Find buffer (useful when you have multiple query buffers)
keymap.set("n", "<leader>df", "<cmd>DBUIFindBuffer<CR>", { desc = "Find DB Buffer" })

-- Execute query (works in sql buffers)
keymap.set("n", "<leader>de", "<Plug>(DBUI_ExecuteQuery)", { desc = "Execute Query" })
keymap.set("v", "<leader>de", "<Plug>(DBUI_ExecuteQuery)", { desc = "Execute Selected Query" })

-- Save query
keymap.set("n", "<leader>dw", "<Plug>(DBUI_SaveQuery)", { desc = "Save Query" })

-- Rename buffer
keymap.set("n", "<leader>dr", "<Plug>(DBUI_RenameBuf)", { desc = "Rename DB Buffer" })

-- =============================================================================
-- QUICK CONNECTIONS
-- =============================================================================

-- PostgreSQL Docker (default: 5432 postgres postgres postgres)
keymap.set("n", "<leader>dp", "<cmd>DBPostgresDocker<CR>", { desc = "Connect PostgreSQL Docker" })

-- =============================================================================
-- MONGODB
-- =============================================================================

-- Open MongoDB shell (local)
keymap.set("n", "<leader>dm", "<cmd>MongoDB<CR>", { desc = "Open MongoDB Shell" })

-- Open MongoDB in Docker container
keymap.set("n", "<leader>dM", "<cmd>MongoDBDocker<CR>", { desc = "MongoDB Docker Shell" })

-- =============================================================================
-- REDIS
-- =============================================================================

-- Open Redis CLI (local)
keymap.set("n", "<leader>di", "<cmd>Redis<CR>", { desc = "Open Redis CLI" })

-- Open Redis in Docker container
keymap.set("n", "<leader>dI", "<cmd>RedisDocker<CR>", { desc = "Redis Docker CLI" })
