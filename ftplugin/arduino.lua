-- ============================================================================
-- ARDUINO: Treesitter highlighting + compile/upload/monitor for .ino/.pde
-- ============================================================================
-- There is no dedicated tree-sitter grammar for Arduino sketches. Since the
-- language is effectively C++ (with the Arduino core headers/macros), reuse
-- the already-installed `cpp` parser for the `arduino` filetype so highlight,
-- indent, and incremental selection all work as expected.
-- LSP intelligence (autocomplete + diagnostics) is provided separately by
-- arduino_language_server (wraps clangd), configured in
-- lua/cargdev/plugins/lsp/lspconfig.lua.
-- Compile/upload/monitor tasks (arduino-cli) are registered as overseer.nvim
-- templates in lua/cargdev/plugins/overseer.lua; the keymaps below run them
-- directly using their default params (edit port/fqbn via <leader>or instead
-- if they change, e.g. after unplugging/replugging the board).
-- ============================================================================
vim.treesitter.language.register("cpp", "arduino")

local bufnr = vim.api.nvim_get_current_buf()
local function opts(desc)
  return { buffer = bufnr, desc = desc }
end

vim.keymap.set("n", "<leader>ac", function()
  require("overseer").run_task({ name = "Arduino: Compile" })
end, opts("Arduino: Compile"))

vim.keymap.set("n", "<leader>au", function()
  require("overseer").run_task({ name = "Arduino: Compile & Upload" })
end, opts("Arduino: Compile & Upload"))

vim.keymap.set("n", "<leader>am", function()
  require("overseer").run_task({ name = "Arduino: Serial Monitor" })
end, opts("Arduino: Serial Monitor"))
