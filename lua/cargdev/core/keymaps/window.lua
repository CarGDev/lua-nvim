--- Window and tab management keymaps.
--- Provides split creation/closing, tab navigation, and Ctrl-based
--- resize shortcuts for both vertical and horizontal splits.
--- @module keymaps.window

local keymap = vim.keymap

--- Split management — vertical, horizontal, equalize, and close.
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

--- Tab management — new, close, next, previous, and open buffer in new tab.
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>cx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tt", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

--- Resize splits — Ctrl+H/L for width, Ctrl+K/J for height (step of 5).
keymap.set("n", "<C-l>", ":vertical resize -5<CR>", { noremap = true, silent = true })
keymap.set("n", "<C-h>", ":vertical resize +5<CR>", { noremap = true, silent = true })
keymap.set("n", "<C-k>", ":resize +5<CR>", { noremap = true, silent = true })
keymap.set("n", "<C-j>", ":resize -5<CR>", { noremap = true, silent = true })
