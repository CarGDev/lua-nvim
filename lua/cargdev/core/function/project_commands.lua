vim.api.nvim_create_user_command("RunProject", function()
  local config_path = ".nvim/project.lua"
  if vim.fn.filereadable(config_path) == 0 then
    vim.notify("No project config found. Run `:e` on any file to generate it.", vim.log.levels.WARN)
    return
  end
  local config = loadfile(config_path)()
  if config and config.run then
    vim.cmd("vsplit | terminal " .. config.run)
  else
    vim.notify("Run command not found in project config.", vim.log.levels.ERROR)
  end
end, {})

vim.api.nvim_create_user_command("DebugProject", function()
  local config_path = ".nvim/project.lua"
  if vim.fn.filereadable(config_path) == 0 then
    vim.notify("No project config found. Run `:e` on any file to generate it.", vim.log.levels.WARN)
    return
  end
  local config = loadfile(config_path)()
  if config and config.debug then
    vim.cmd("vsplit | terminal " .. config.debug)
  else
    vim.notify("Debug command not found in project config.", vim.log.levels.ERROR)
  end
end, {})
