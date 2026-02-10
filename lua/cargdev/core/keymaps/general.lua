--- General-purpose keymaps.
--- Provides essential editor-wide shortcuts: insert-mode escape (`jj`),
--- search highlight clearing, and quit-all.
--- @module keymaps.general

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- =============================================================================
-- GENERAL KEYMAPS
-- =============================================================================

--- Exit insert mode by pressing `jj` (chosen over `jk` to avoid
--- conflicts when typing words containing "j" followed by other letters).
keymap.set("i", "jj", "<ESC>", opts)

--- Clear search highlights.
keymap.set("n", "<leader>nh", ":nohl<CR>", opts)

--- Quit all open buffers and windows without saving.
keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all" })
