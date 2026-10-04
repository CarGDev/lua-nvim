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
-- Compile/upload/monitor run arduino-cli in a terminal split (see
-- lua/cargdev/core/term_run.lua). Board and port default to an Uno on
-- /dev/cu.usbmodem3112401; override with vim.g.arduino_fqbn, vim.g.arduino_port
-- and vim.g.arduino_baud (e.g. after replugging the board).
-- Example: <leader>ac compiles, <leader>au uploads, <leader>am opens the monitor.
-- ============================================================================
vim.treesitter.language.register("cpp", "arduino")

local bufnr = vim.api.nvim_get_current_buf()
local function opts(desc)
  return { buffer = bufnr, desc = desc }
end

local term = require("cargdev.core.term_run")

local function fqbn()
  return vim.g.arduino_fqbn or "arduino:avr:uno"
end
local function port()
  return vim.g.arduino_port or "/dev/cu.usbmodem3112401"
end
local function baud()
  return tostring(vim.g.arduino_baud or 9600)
end

vim.keymap.set("n", "<leader>ac", function()
  term.run({ "arduino-cli", "compile", "--fqbn", fqbn(), "." }, vim.fn.expand("%:p:h"))
end, opts("Arduino: Compile"))

vim.keymap.set("n", "<leader>au", function()
  term.run(
    { "arduino-cli", "compile", "--upload", "-p", port(), "--fqbn", fqbn(), "." },
    vim.fn.expand("%:p:h")
  )
end, opts("Arduino: Compile & Upload"))

vim.keymap.set("n", "<leader>am", function()
  term.run({ "arduino-cli", "monitor", "-p", port(), "-c", "baudrate=" .. baud() }, vim.fn.expand("%:p:h"))
end, opts("Arduino: Serial Monitor"))
