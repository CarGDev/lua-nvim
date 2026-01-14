local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name
local keymap = vim.keymap.set

local status, jdtls = pcall(require, "jdtls")

if not status then
  return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local bundles = {
  vim.fn.glob(
    home .. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
    true
  ),
}
vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-test/extension/server/*.jar", true), "\n")
)

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
    "-jar",
    vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    home .. "/.local/share/nvim/mason/packages/jdtls/config_mac",
    "-data",
    workspace_dir,
  },
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

  settings = {
    java = {
      signatureHelp = { enabled = true },
      extendedClientCapabilities = extendedClientCapabilities,
      maven = {
        downloadSources = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all", -- literals, all, none
        },
      },
      format = {
        enabled = false,
      },
    },
  },

  init_options = {
    bundles = bundles,
  },
}

-- Callback to setup DAP after JDTLS attaches
local function jdtls_on_attach(client, bufnr)
  -- Setup DAP after language server is ready
  if #bundles > 0 then
    require("jdtls").setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()
  end
end

config.on_attach = jdtls_on_attach

require("jdtls").start_or_attach(config)

-- Java code actions
keymap("n", "<leader>co", "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = "Organize Imports" })
keymap("n", "<leader>crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = "Extract Variable" })
keymap("v", "<leader>crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { desc = "Extract Variable" })
keymap("n", "<leader>crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = "Extract Constant" })
keymap("v", "<leader>crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { desc = "Extract Constant" })
keymap("v", "<leader>crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = "Extract Method" })

-- Java Debug & Run
keymap("n", "<leader>jt", "<Cmd>lua require('jdtls').test_class()<CR>", { desc = "Test Class" })
keymap("n", "<leader>jn", "<Cmd>lua require('jdtls').test_nearest_method()<CR>", { desc = "Test Nearest Method" })
keymap("n", "<leader>jd", "<Cmd>lua require('jdtls').debug_class()<CR>", { desc = "Debug Class (DAP)" })
keymap("n", "<leader>jr", function()
  -- Run Java main class without debugger
  local main_class = vim.fn.expand("%:t:r")
  local cmd = string.format("java %s", main_class)
  vim.cmd("split | terminal " .. cmd)
end, { desc = "Run Java File" })
keymap("n", "<leader>jm", function()
  -- Run with Maven
  vim.cmd("split | terminal mvn compile exec:java")
end, { desc = "Run Maven Project" })
keymap("n", "<leader>jg", function()
  -- Run with Gradle
  vim.cmd("split | terminal ./gradlew run")
end, { desc = "Run Gradle Project" })
