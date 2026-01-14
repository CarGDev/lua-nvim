-- Git Conflict keymaps
local keymap = vim.keymap

keymap.set("n", "]x", "<Plug>(git-conflict-next-conflict)", { desc = "Go to next git conflict" })
keymap.set("n", "[x", "<Plug>(git-conflict-prev-conflict)", { desc = "Go to previous git conflict" })
keymap.set("n", "<leader>gco", "<Plug>(git-conflict-ours)", { desc = "Choose ours (git conflict)" })
keymap.set("n", "<leader>gct", "<Plug>(git-conflict-theirs)", { desc = "Choose theirs (git conflict)" })
keymap.set("n", "<leader>gcb", "<Plug>(git-conflict-both)", { desc = "Choose both (git conflict)" })
keymap.set("n", "<leader>gc0", "<Plug>(git-conflict-none)", { desc = "Choose none (git conflict)" })
keymap.set("n", "<leader>gcl", "<Plug>(git-conflict-list)", { desc = "List all git conflicts" })
