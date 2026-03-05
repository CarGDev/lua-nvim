-- This ftplugin is currently configured for macOS (Homebrew + Apple Silicon).
-- Skip on Linux until Linux paths are configured.
if vim.fn.has("mac") ~= 1 then
  return
end

local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name
local keymap = vim.keymap.set

-- JDTLS requires JDK 21+ to run; use JDK 25 for the server process
local jdtls_java = "/opt/homebrew/Cellar/openjdk/25.0.2/libexec/openjdk.jdk/Contents/Home/bin/java"

local status, jdtls = pcall(require, "jdtls")

if not status then
  return
end

-- Ensure DAP is loaded before setting up Java debugging
local dap_ok, _ = pcall(require, "dap")
if not dap_ok then
  vim.notify("nvim-dap not loaded yet. Debug features may not work.", vim.log.levels.WARN)
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Build bundles for java-debug-adapter and java-test
local bundles = {}

-- Add java-debug-adapter
local debug_jar = vim.fn.glob(
  home .. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
  true
)
if debug_jar ~= "" then
  table.insert(bundles, debug_jar)
end

-- Add java-test jars
local test_jars = vim.split(
  vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-test/extension/server/*.jar", true),
  "\n"
)
for _, jar in ipairs(test_jars) do
  if jar ~= "" then
    table.insert(bundles, jar)
  end
end

local config = {
  cmd = {
    jdtls_java,
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
    home .. "/.local/share/nvim/mason/packages/jdtls/config_mac_arm",
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
        enabled = true,
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = "/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home",
          },
          {
            name = "JavaSE-25",
            path = "/opt/homebrew/Cellar/openjdk/25.0.2/libexec/openjdk.jdk/Contents/Home",
            default = true,
          },
        },
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
    -- Ensure DAP is loaded
    local dap_loaded, dap = pcall(require, "dap")
    if not dap_loaded then
      vim.notify("DAP not available for Java debugging", vim.log.levels.WARN)
      return
    end

    -- Setup DAP with hot code replace
    require("jdtls").setup_dap({ hotcodereplace = "auto" })

    -- Defer main class config discovery to allow JDTLS to fully initialize
    vim.defer_fn(function()
      local ok, err = pcall(function()
        require("jdtls.dap").setup_dap_main_class_configs()
      end)
      if not ok then
        vim.notify("Failed to setup Java DAP main configs: " .. tostring(err), vim.log.levels.DEBUG)
      end
    end, 2000)
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
