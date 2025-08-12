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

-- Save and quit (additional)
keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all" })
