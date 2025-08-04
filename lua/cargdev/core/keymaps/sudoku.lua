-- Sudoku keymaps
-- WARNING: <leader>sng is mapped to two different commands below. Only the last one will take effect in Neovim.
-- Consider changing one of the mappings if you want both actions available.
local keymap = vim.keymap

keymap.set("n", "<leader>si1", ":Sudoku insert=1<CR>", { desc = "Add number 1" })
keymap.set("n", "<leader>si2", ":Sudoku insert=2<CR>", { desc = "Add number 2" })
keymap.set("n", "<leader>si3", ":Sudoku insert=3<CR>", { desc = "Add number 3" })
keymap.set("n", "<leader>si4", ":Sudoku insert=4<CR>", { desc = "Add number 4" })
keymap.set("n", "<leader>si5", ":Sudoku insert=5<CR>", { desc = "Add number 5" })
keymap.set("n", "<leader>si6", ":Sudoku insert=6<CR>", { desc = "Add number 6" })
keymap.set("n", "<leader>si7", ":Sudoku insert=7<CR>", { desc = "Add number 7" })
keymap.set("n", "<leader>si8", ":Sudoku insert=8<CR>", { desc = "Add number 8" })
keymap.set("n", "<leader>si9", ":Sudoku insert=9<CR>", { desc = "Add number 9" })
keymap.set("n", "<leader>scc", ":Sudoku clear_cell<CR>", { desc = "Clear current cell" })
keymap.set("n", "<leader>su", ":Sudoku undo<CR>", { desc = "Undo last action" })
keymap.set("n", "<leader>sng", ":Sudoku new_game<CR>", { desc = "Starts new game" })
keymap.set("n", "<leader>sng", ":Sudoku view=settings<CR>", { desc = "Display the settings" })
