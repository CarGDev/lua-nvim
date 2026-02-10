--- LeetCode keymaps.
--- Bindings for testing, submitting, and retrieving solutions via the
--- leetcode.nvim plugin. All mappings use the `<leader>l` prefix.
--- @module keymaps.leet

local keymap = vim.keymap

--- LeetCode — run, submit, daily challenge, list, console, cookie, hints.
keymap.set("n", "<leader>lr", "<cmd>Leet run<CR>", { desc = "LeetCode: Run Code" })
keymap.set("n", "<leader>ls", "<cmd>Leet submit<CR>", { desc = "LeetCode: Submit Code" })
keymap.set("n", "<leader>ld", "<cmd>Leet daily<CR>", { desc = "LeetCode: Daily Challenge" })
keymap.set("n", "<leader>ll", "<cmd>Leet list<CR>", { desc = "LeetCode: List Problems" })
keymap.set("n", "<leader>lc", "<cmd>Leet console<CR>", { desc = "LeetCode: Open Console" })
keymap.set("n", "<leader>lu", "<cmd>Leet cookie update<CR>", { desc = "LeetCode: Update Cookie" })
keymap.set("n", "<leader>lh", "<cmd>Leet hints<cr>", { desc = "LeetCode: Open hints" })
keymap.set("n", "<leader>lls", "<cmd>Leet last<cr>", { desc = "LeetCode: Get latest submission" })
