local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name
local keymap = vim.keymap.set

local status, jdtls = pcall(require, "jdtls")
local dap_ok, dap = pcall(require, "dap")

if not status then
  return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local bundles = {
  vim.fn.glob(
    home
      .. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
    true
  ),
}

vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-test/extension/server/*.jar", true), "\n")
)

local jdtls_java_home = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"

local config = {
  cmd = {
    jdtls_java_home .. "/bin/java",
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

  cmd_env = {
    JAVA_HOME = jdtls_java_home,
    PATH = jdtls_java_home .. "/bin:" .. vim.env.PATH,
  },
}
require("jdtls").start_or_attach(config)

if dap_ok then
  require("jdtls").setup_dap({ hotcodereplace = "auto" })

  local attach_config = {
    type = "java",
    request = "attach",
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  }
  dap.configurations.java = dap.configurations.java or {}
  table.insert(dap.configurations.java, attach_config)
end

local bufnr = vim.api.nvim_get_current_buf()
local opts = function(desc)
  return { buffer = bufnr, desc = desc }
end

keymap("n", "<leader>jo", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts("Java: Organize Imports"))
keymap("n", "<leader>jrv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts("Java: Extract Variable"))
keymap("n", "<leader>jrc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts("Java: Extract Constant"))
keymap("n", "<leader>jrm", "<Cmd>lua require('jdtls').extract_method(true)<CR>", opts("Java: Extract Method"))

if dap_ok then
  keymap("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts("Java: Debug Test Class"))
  keymap("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts("Java: Debug Nearest Test"))
end
