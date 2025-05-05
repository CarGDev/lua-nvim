local M = {}

local function ask_input(prompt, default)
  vim.fn.inputsave()
  local result = vim.fn.input(prompt .. " [" .. default .. "]: ")
  vim.fn.inputrestore()
  return result ~= "" and result or default
end

local function detect_project_type()
  if vim.fn.filereadable("pom.xml") == 1 then
    return "java"
  elseif vim.fn.filereadable("angular.json") == 1 then
    return "angular"
  elseif vim.fn.filereadable("package.json") == 1 then
    local pkg = vim.fn.readfile("package.json")
    for _, line in ipairs(pkg) do
      if line:match("nestjs") then return "node" end
      if line:match("react") then return "react" end
    end
    return "node"
  end
  return "custom"
end

M.bootstrap_config = function()
  local config_file = ".nvim/project.lua"
  if vim.fn.filereadable(config_file) == 1 then return end

  vim.fn.mkdir(".nvim", "p")

  local type = detect_project_type()
  vim.notify("Detected project type: " .. type, vim.log.levels.INFO)

  -- Ask user for run/debug commands
  local run = ask_input("Enter run command", type == "java" and "./mvnw spring-boot:run" or "yarn start")
  local debug = ask_input("Enter debug command", type == "java"
    and "./mvnw spring-boot:run -Dspring-boot.run.jvmArguments='-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005'"
    or "node --inspect-brk dist/main.js")

  -- Write to file
  local f = io.open(config_file, "w")
  if f then
    f:write("return {\n")
    f:write("  type = '" .. type .. "',\n")
    f:write("  run = [[" .. run .. "]],\n")
    f:write("  debug = [[" .. debug .. "]],\n")
    f:write("}\n")
    f:close()
    vim.notify("Project configuration written to " .. config_file, vim.log.levels.INFO)
  else
    vim.notify("Failed to write config file", vim.log.levels.ERROR)
  end
end

return M

