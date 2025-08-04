-- Project Run/Debug keymaps
local keymap = vim.keymap

keymap.set("n", "<leader>pr", ":RunProject<CR>", { desc = "Run Project" })
keymap.set("n", "<leader>pd", ":DebugProject<CR>", { desc = "Debug Project" })
