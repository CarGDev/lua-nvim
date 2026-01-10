-- Copilot keymaps
local keymap = vim.keymap

-- Copilot panel and status
keymap.set("n", "<leader>cp", ":Copilot panel<CR>", { desc = "Copilot: Open copilot panel" })
keymap.set("n", "<leader>cd", ":Copilot disable<CR>", { desc = "Copilot: Disable" })
keymap.set("n", "<leader>ce", ":Copilot enable<CR>", { desc = "Copilot: Enable" })
keymap.set("n", "<leader>cs", ":Copilot status<CR>", { desc = "Copilot: Status" })

-- Copilot suggestion navigation (insert mode)
-- These are configured in copilot.lua but documented here for reference:
-- <leader>] - Next suggestion
-- <leader>[ - Previous suggestion
-- <M-l> - Accept suggestion
-- <C-]> - Dismiss suggestion

-- CodeCompanion keymaps
keymap.set("n", "<leader>cc", ":CodeCompanion<CR>", { desc = "CodeCompanion: Open CodeCompanion" })
