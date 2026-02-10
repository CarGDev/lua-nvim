--- Project-level user commands for running and debugging.
--- Reads a per-project configuration file at `.nvim/project.lua` that should
--- return a table with `run` and/or `debug` keys containing shell commands.
--- Registers the `:RunProject` and `:DebugProject` user commands.
--- @module project_commands

local api = vim.api
local fn = vim.fn
local notify = vim.notify

--- Run the project using the `run` command from `.nvim/project.lua`.
--- Opens a vertical split terminal with the configured run command.
--- Notifies the user if the config file or run command is missing.
api.nvim_create_user_command("RunProject", function()
  local config_path = ".nvim/project.lua"
  if fn.filereadable(config_path) == 0 then
    notify("No project config found. Run `:e` on any file to generate it.", vim.log.levels.WARN)
    return
  end
  local config = loadfile(config_path)()
  if config and config.run then
    vim.cmd("vsplit | terminal " .. config.run)
  else
    notify("Run command not found in project config.", vim.log.levels.ERROR)
  end
end, {})

--- Debug the project using the `debug` command from `.nvim/project.lua`.
--- Opens a vertical split terminal with the configured debug command.
--- Notifies the user if the config file or debug command is missing.
api.nvim_create_user_command("DebugProject", function()
  local config_path = ".nvim/project.lua"
  if fn.filereadable(config_path) == 0 then
    notify("No project config found. Run `:e` on any file to generate it.", vim.log.levels.WARN)
    return
  end
  local config = loadfile(config_path)()
  if config and config.debug then
    vim.cmd("vsplit | terminal " .. config.debug)
  else
    notify("Debug command not found in project config.", vim.log.levels.ERROR)
  end
end, {})
