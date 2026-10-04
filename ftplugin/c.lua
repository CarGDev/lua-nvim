-- ============================================================================
-- C: Compile/run keymaps
-- ============================================================================
-- Buffer-local keymaps that build or run the current C file in a terminal
-- split (see lua/cargdev/core/term_run.lua). A Makefile is auto-detected
-- (walking up from the current file) and used when present; otherwise the
-- current file is compiled directly with clang.
-- Example: <leader>cc builds, <leader>cr builds and runs the result.
-- Debugging (breakpoints/step-through) uses the generic <leader>d* keymaps
-- from lua/cargdev/plugins/dap.lua, powered by codelldb (mason-nvim-dap).
-- LSP intelligence (autocomplete, auto-include on completion, diagnostics)
-- comes from clangd, configured in lua/cargdev/plugins/lsp/lspconfig.lua.
-- ============================================================================

local bufnr = vim.api.nvim_get_current_buf()
local function opts(desc)
  return { buffer = bufnr, desc = desc }
end

local term = require("cargdev.core.term_run")

vim.keymap.set("n", "<leader>cc", function()
  local file, dir = vim.fn.expand("%:p"), vim.fn.expand("%:p:h")
  local root = term.find_makefile_root(dir)
  if root then
    term.run({ "make" }, root)
  else
    term.run({ "clang", "-Wall", "-Wextra", "-g", file, "-o", vim.fn.expand("%:p:r") }, dir)
  end
end, opts("C: Build"))

vim.keymap.set("n", "<leader>cr", function()
  local file, dir = vim.fn.expand("%:p"), vim.fn.expand("%:p:h")
  local root = term.find_makefile_root(dir)
  if root then
    -- After `make`, run the most recently built executable in the project root
    -- or build/ (the binary name may not match the folder name).
    local script = "make && "
      .. 'bin=$(find . build -maxdepth 1 -type f -perm +111 2>/dev/null | xargs -I{} ls -t {} 2>/dev/null | head -1); '
      .. 'if [ -n "$bin" ]; then echo "-- running: $bin"; "$bin"; '
      .. 'else echo "No executable found after build"; fi'
    term.run({ "sh", "-c", script }, root)
  else
    local out = vim.fn.expand("%:p:r")
    term.run({ "sh", "-c", string.format("clang -Wall -Wextra -g %q -o %q && %q", file, out, out) }, dir)
  end
end, opts("C: Compile & Run"))
