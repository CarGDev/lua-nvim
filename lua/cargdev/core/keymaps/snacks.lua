--- Snacks.nvim picker keymaps (replacing Telescope for most navigation).
--- Uses snacks.picker for file, grep, buffer, marks, keymaps, and command
--- searching. Falls back to Telescope for git operations and TODO search
--- where Snacks pickers are not yet available.
--- @module keymaps.snacks

local keymap = vim.keymap

-- =============================================================================
-- SNACKS NAVIGATION
-- =============================================================================

--- File navigation — find files, live grep, grep string, recent files.
keymap.set("n", "<leader>ff", "<cmd>lua require('snacks.picker').files()<cr>", { desc = "Find files" })
keymap.set("n", "<leader>fs", "<cmd>lua require('snacks.picker').grep()<cr>", { desc = "Live grep" })
keymap.set("n", "<leader>fc", "<cmd>lua require('snacks.picker').grep_string()<cr>", { desc = "Grep string" })
keymap.set("n", "<leader>fr", "<cmd>lua require('snacks.picker').oldfiles()<cr>", { desc = "Recent files" })

--- Buffer and session management — buffers, help tags, marks, keymaps, commands.
keymap.set("n", "<leader>fb", "<cmd>lua require('snacks.picker').buffers()<cr>", { desc = "Find buffers" })
keymap.set("n", "<leader>fh", "<cmd>lua require('snacks.picker').help_tags()<cr>", { desc = "Help tags" })
keymap.set("n", "<leader>fm", "<cmd>lua require('snacks.picker').marks()<cr>", { desc = "Find marks" })
keymap.set("n", "<leader>fk", "<cmd>lua require('snacks.picker').keymaps()<cr>", { desc = "Find keymaps" })
keymap.set("n", "<leader>fC", "<cmd>lua require('snacks.picker').commands()<cr>", { desc = "Find commands" })

--- Git — commits, buffer commits, branches, and status (via Telescope fallback).
keymap.set("n", "<leader>fG", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
keymap.set("n", "<leader>fB", "<cmd>Telescope git_bcommits<cr>", { desc = "Git buffer commits" })
keymap.set("n", "<leader>fg", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })

--- Search TODO/FIXME/HACK comments (via Telescope — Snacks lacks this picker).
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
