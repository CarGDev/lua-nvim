-- Telescope keymaps
local keymap = vim.keymap

-- =============================================================================
-- TELESCOPE NAVIGATION
-- =============================================================================

-- File navigation
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Grep string" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

-- Buffer and session management
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Find marks" })
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
keymap.set("n", "<leader>fC", "<cmd>Telescope commands<cr>", { desc = "Find commands" })

-- Git
keymap.set("n", "<leader>fg", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
keymap.set("n", "<leader>fG", "<cmd>Telescope git_bcommits<cr>", { desc = "Git buffer commits" })
keymap.set("n", "<leader>fb", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
keymap.set("n", "<leader>fs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })

-- Todos
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" }) 