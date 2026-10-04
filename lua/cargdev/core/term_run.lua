-- ============================================================================
-- TERM_RUN: Run a command in a terminal split
-- ============================================================================
-- Saves the current buffer, opens a split at the bottom and runs a command in
-- a terminal there, so build/run output stays visible and interactive.
-- Used by the C and Arduino ftplugins instead of a task-runner plugin.
-- Example: require("cargdev.core.term_run").run({ "make" }, "/path/to/project")
-- ============================================================================
local M = {}

--- Run `cmd` (argv list) in a bottom terminal split, with `cwd` as working dir.
--- @param cmd string[]
--- @param cwd string|nil
function M.run(cmd, cwd)
  if vim.bo.modifiable and vim.bo.modified and vim.bo.buftype == "" then
    vim.cmd("silent! write")
  end
  vim.cmd("botright 12new")
  vim.fn.jobstart(cmd, { term = true, cwd = cwd })
  vim.cmd("startinsert")
end

--- Closest directory (walking up from `start`) that contains a Makefile.
--- @param start string
--- @return string|nil
function M.find_makefile_root(start)
  local found = vim.fs.find("Makefile", { path = start, upward = true })[1]
  return found and vim.fn.fnamemodify(found, ":h") or nil
end

return M
