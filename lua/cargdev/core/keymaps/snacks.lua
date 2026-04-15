--- Snacks.nvim picker keymaps (replacing Telescope for most navigation).
--- Uses snacks.picker for file, grep, buffer, marks, keymaps, and command
--- searching. Falls back to Telescope for git operations and TODO search
--- where Snacks pickers are not yet available.
--- @module keymaps.snacks

local keymap = vim.keymap

-- =============================================================================
-- SNACKS NAVIGATION
-- =============================================================================

--- Search TODO/FIXME/HACK comments (via fzf-lua — Snacks lacks this picker).
keymap.set("n", "<leader>ft", "<cmd>TodoFzfLua<cr>", { desc = "Find todos" })
