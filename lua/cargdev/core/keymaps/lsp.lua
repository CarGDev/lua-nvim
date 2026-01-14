-- LSP and function navigation keymaps
local keymap = vim.keymap

-- =============================================================================
-- LSP NAVIGATION (FUNCTION NAVIGATION) - Using fzf-lua
-- =============================================================================

-- Primary LSP navigation
keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { desc = "Go to definition" })
keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<cr>", { desc = "Go to implementation" })
keymap.set("n", "gr", "<cmd>FzfLua lsp_references<cr>", { desc = "Show references" })
keymap.set("n", "gt", "<cmd>FzfLua lsp_typedefs<cr>", { desc = "Go to type definition" })

-- Symbol search
keymap.set("n", "<leader>ds", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Document symbols" })
keymap.set("n", "<leader>lw", "<cmd>FzfLua lsp_workspace_symbols<cr>", { desc = "LSP: Workspace symbols" })

-- Code actions and documentation
keymap.set("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", { desc = "Code actions" })
keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename" })
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Hover documentation" })

-- Diagnostics
keymap.set("n", "<leader>D", "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "Show diagnostics" })
keymap.set("n", "<leader>dd", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Line diagnostics" })
keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Previous diagnostic" })
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next diagnostic" }) 