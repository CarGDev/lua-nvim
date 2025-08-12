-- General keymaps
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- =============================================================================
-- GENERAL KEYMAPS
-- =============================================================================

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General keymaps
keymap.set("i", "jk", "<ESC>", opts) -- Exit insert mode with jk
keymap.set("n", "<leader>nh", ":nohl<CR>", opts) -- Clear search highlights
keymap.set("n", "x", '"_x', opts) -- Delete character without copying into register

-- Comment keymaps
keymap.set("n", "gcc", "<cmd>CommentToggle<CR>", { desc = "Toggle comment line" })
keymap.set("n", "gc", "<cmd>CommentToggle<CR>", { desc = "Toggle comment line" })
keymap.set("v", "gc", "<cmd>CommentToggle<CR>", { desc = "Toggle comment selection" })
keymap.set("n", "gbc", "<cmd>CommentToggle<CR>", { desc = "Toggle comment block" })
keymap.set("v", "gb", "<cmd>CommentToggle<CR>", { desc = "Toggle comment block" })

-- Save and quit (additional)
keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all" })

-- Performance monitoring keymaps
keymap.set("n", "<leader>pp", "<cmd>lua require('cargdev.core.function.performance_monitor').check_performance()<CR>", { desc = "Check performance" })
keymap.set("n", "<leader>po", "<cmd>lua require('cargdev.core.function.performance_monitor').check_plugin_performance()<CR>", { desc = "Check plugin performance" })
keymap.set("n", "<leader>pb", "<cmd>lua require('cargdev.core.function.performance_monitor').optimize_buffer()<CR>", { desc = "Optimize current buffer" })

-- LSP health and troubleshooting keymaps
keymap.set("n", "<leader>pl", "<cmd>lua require('cargdev.core.function.performance_monitor').check_lsp_health()<CR>", { desc = "Check LSP health" })
keymap.set("n", "<leader>pr", "<cmd>lua require('cargdev.core.function.performance_monitor').restart_lsp()<CR>", { desc = "Restart LSP" })

-- Notification management keymaps
keymap.set("n", "<leader>nc", "<cmd>lua require('cargdev.core.function.notification_manager').clear_all_notifications()<CR>", { desc = "Clear all notifications" })
keymap.set("n", "<leader>nn", "<cmd>lua require('cargdev.core.function.notification_manager').show_notification('Test notification', vim.log.levels.INFO)<CR>", { desc = "Test notification" })

-- Startup prompt management keymaps
keymap.set("n", "<leader>ns", "<cmd>redraw!<CR><cmd>echo ''<CR>", { desc = "Clear startup prompts" })
keymap.set("n", "<leader>nr", "<cmd>redraw!<CR>", { desc = "Redraw screen" }) 