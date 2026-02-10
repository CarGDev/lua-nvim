--- Terminal-mode keymaps.
--- Provides shortcuts for navigating out of terminal buffers and closing them.
--- - `Ctrl+H` — switch to the left window from terminal mode.
--- - `Ctrl+T` — close the terminal window.
--- - `Ctrl+\ Ctrl+\` — escape to normal mode from terminal mode.
--- @module keymaps.openterminal

local keymap = vim.keymap

--- Switch to the left window from terminal mode.
keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { buffer = true })

--- Close the terminal window.
keymap.set("t", "<C-t>", "<C-\\><C-n>:q<CR>", { buffer = true })

--- Escape terminal mode to normal mode.
keymap.set("t", "<C-\\><C-\\>", "<C-\\><C-n>", { buffer = true })
