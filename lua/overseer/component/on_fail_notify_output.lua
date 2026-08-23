-- ============================================================================
-- Custom overseer.nvim component: on_fail_notify_output
-- ============================================================================
-- vim.notify's the task's last N output lines (e.g. compiler errors) when it
-- fails. Registered as part of component_aliases.default in
-- lua/cargdev/plugins/overseer.lua. Complements the "open_output" component
-- (which auto-opens+focuses the output dock on task start) by surfacing the
-- actual error text even if you've navigated away from that dock.
--
-- Custom overseer components must live at the Lua module path
-- `overseer.component.<name>` to be discoverable via require(), which is why
-- this file sits at lua/overseer/component/ rather than under lua/cargdev/.
-- ============================================================================

local util = require("overseer.util")
local constants = require("overseer.constants")

---@type overseer.ComponentFileDefinition
return {
  desc = "vim.notify the task's last output lines when it fails",
  params = {
    max_lines = {
      desc = "Number of output lines to include in the notification",
      type = "number",
      default = 15,
    },
  },
  constructor = function(params)
    return {
      on_complete = function(_, task, status)
        if status ~= constants.STATUS.FAILURE then
          return
        end
        local bufnr = task:get_bufnr()
        if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
          return
        end
        local lines = util.get_last_output_lines(bufnr, params.max_lines)
        if vim.tbl_isempty(lines) then
          return
        end
        vim.notify(table.concat(lines, "\n"), vim.log.levels.ERROR, { title = task.name .. " failed" })
      end,
    }
  end,
}
