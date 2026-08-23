-- ============================================================================
-- C: Compile/run keymaps
-- ============================================================================
-- Buffer-local keymaps for the "C: Build" and "C: Compile & Run" overseer
-- templates registered in lua/cargdev/plugins/overseer.lua. Those templates
-- auto-detect a Makefile (walking up from the current file) and use it when
-- present, otherwise compile the current file directly with clang.
-- Debugging (breakpoints/step-through) uses the generic <leader>d* keymaps
-- from lua/cargdev/plugins/dap.lua, powered by codelldb (mason-nvim-dap).
-- LSP intelligence (autocomplete, auto-include on completion, diagnostics)
-- comes from clangd, configured in lua/cargdev/plugins/lsp/lspconfig.lua.
-- ============================================================================

local bufnr = vim.api.nvim_get_current_buf()
local function opts(desc)
  return { buffer = bufnr, desc = desc }
end

vim.keymap.set("n", "<leader>cc", function()
  require("overseer").run_task({ name = "C: Build" })
end, opts("C: Build"))

vim.keymap.set("n", "<leader>cr", function()
  require("overseer").run_task({ name = "C: Compile & Run" })
end, opts("C: Compile & Run"))
