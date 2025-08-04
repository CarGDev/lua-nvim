-- LSP and function navigation keymaps
local keymap = vim.keymap

-- =============================================================================
-- LSP NAVIGATION (FUNCTION NAVIGATION)
-- =============================================================================

-- Primary LSP navigation
keymap.set("n", "gd", "<cmd>lua require('snacks.picker').lsp_definitions()<cr>", { desc = "Go to definition" })
keymap.set("n", "gi", "<cmd>lua require('snacks.picker').lsp_implementations()<cr>", { desc = "Go to implementation" })
keymap.set("n", "gr", "<cmd>lua require('snacks.picker').lsp_references()<cr>", { desc = "Show references" })
keymap.set("n", "gt", "<cmd>lua require('snacks.picker').lsp_type_definitions()<cr>", { desc = "Go to type definition" })

-- Symbol search
keymap.set("n", "<leader>ds", "<cmd>lua require('snacks.picker').lsp_document_symbols()<cr>", { desc = "Document symbols" })
keymap.set("n", "<leader>ws", "<cmd>lua require('snacks.picker').lsp_workspace_symbols()<cr>", { desc = "Workspace symbols" })

-- Code actions and documentation
keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code actions" })
keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Hover documentation" })

-- Diagnostics
keymap.set("n", "<leader>D", "<cmd>lua require('snacks.picker').diagnostics()<cr>", { desc = "Show diagnostics" })
keymap.set("n", "<leader>dd", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Line diagnostics" })
keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Previous diagnostic" })
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next diagnostic" }) 