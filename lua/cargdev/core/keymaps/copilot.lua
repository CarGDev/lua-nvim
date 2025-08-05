-- Copilot Chat keymaps
local keymap = vim.keymap

keymap.set("v", "<leader>zn", ":CopilotChatRename<CR>", { desc = "Rename variable (Copilot Chat)" })
keymap.set("n", "<leader>zc", ":CopilotChat<CR>", { desc = "Open Copilot Chat" })
keymap.set("v", "<leader>ze", ":CopilotChatExplain<CR>", { desc = "Explain code (Copilot Chat)" })
keymap.set("v", "<leader>zr", ":CopilotChatReview<CR>", { desc = "Review code (Copilot Chat)" })
keymap.set("v", "<leader>zf", ":CopilotChatFix<CR>", { desc = "Fix code issues (Copilot Chat)" })
keymap.set("v", "<leader>zo", ":CopilotChatOptimize<CR>", { desc = "Optimize code (Copilot Chat)" })
keymap.set("v", "<leader>zd", ":CopilotChatDocs<CR>", { desc = "Generate docs (Copilot Chat)" })
keymap.set("n", "<leader>cp", ":Copilot panel<CR>", { desc = "Copilot: Open copilot panel" })
keymap.set("n", "<leader>cd", ":Copilot disable<CR>", { desc = "Copilot: Disabled" })
keymap.set("n", "<leader>cs", ":Copilot status<CR>", { desc = "Copilot: Status" })
