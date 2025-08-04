-- Leet keymaps
local keymap = vim.keymap

keymap.set("n", "<leader>lr", ":Leet test<CR>", { desc = "Test the leet current problem code" })
keymap.set("n", "<leader>ls", ":Leet submit<CR>", { desc = "Submit the leet solution" })
keymap.set("n", "<leader>lls", ":Leet last_submit<CR>", { desc = "Brings the latest submition from leetcode" })
