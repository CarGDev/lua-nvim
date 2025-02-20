return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "nvim-neotest/nvim-nio", lazy = false }, -- Ensure `nvim-nio` loads first
    "rcarriga/nvim-dap-ui",
    "jay-babu/mason-nvim-dap.nvim",
    "mfussenegger/nvim-dap-python",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-telescope/telescope-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- UI Setup
    dapui.setup()

    -- Mason Debugger Installer
    require("mason-nvim-dap").setup({
      ensure_installed = { "node2", "chrome", "firefox" },
      automatic_setup = true,
    })

    -- Automatically open DAP UI when debugging starts
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Enable virtual text for debugging
    require("nvim-dap-virtual-text").setup({})

    -- Keymaps for debugging
    local keymap = vim.keymap.set
    keymap("n", "<leader>dc", "<Cmd>lua require'dap'.continue()<CR>", { desc = "Start Debugging" })

    keymap("n", "<leader>do", function()
      dap.step_over()
    end, { desc = "Step Over" })

    keymap("n", "<leader>di", function()
      dap.step_into()
    end, { desc = "Step Into" })

    keymap("n", "<leader>dot", function()
      dap.step_out()
    end, { desc = "Step Out" })

    keymap("n", "<leader>db", function()
      dap.toggle_breakpoint()
    end, { desc = "Toggle Breakpoint" })

    keymap("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Conditional Breakpoint" })

    keymap("n", "<leader>dr", function()
      dap.repl.open()
    end, { desc = "Open REPL" })

    keymap("n", "<leader>dl", function()
      dap.run_last()
    end, { desc = "Run Last Debug Session" })

    keymap("n", "<leader>du", function()
      dapui.toggle()
    end, { desc = "Toggle DAP UI" })

    keymap("n", "<leader>dq", "<Cmd>lua require'dap'.terminate()<CR>", { desc = "Stop Debugging" })

    -- Java DAP Configuration
    dap.adapters.java = function(callback)
      callback({
        type = "server",
        host = "127.0.0.1",
        port = { port }, -- Port JDTLS uses for debugging
      })
    end

    dap.configurations.java = {
      {
        name = "Attach to running Java process",
        type = "java",
        request = "attach",
        hostName = "127.0.0.1",
        port = { port },
      },
    }

    -- Node.js Adapter Configuration for NestJS
    dap.adapters.node2 = {
      type = "executable",
      command = "node",
      args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodedebug.js" },
    }

    dap.configurations.typescript = {
      {
        name = "Launch NestJS",
        type = "node2",
        request = "launch",
        program = "${workspaceFolder}/dist/main.js",
        args = {},
        console = "integratedTerminal",
        outFiles = { "${workspaceFolder}/dist/**/*.js" },
        sourceMaps = true,
        protocol = "inspector",
        cwd = vim.fn.getcwd(),
        runtimeArgs = { "--inspect-brk" }, -- 🚀 Ensures debugging starts properly
        restart = true,
      },
      {
        name = "Attach to Process",
        type = "node2",
        request = "attach",
        processId = require("dap.utils").pick_process,
      },
    }

    -- dap.configurations.typescript = {
    --   {
    --     name = "Launch NestJS",
    --     type = "node2",
    --     request = "launch",
    --     program = "${workspaceFolder}/dist/main.js", -- ⚠️ Ensure this is correct!
    --     args = {},
    --     console = "integratedTerminal",
    --     outFiles = { "${workspaceFolder}/dist/**/*.js" },
    --     sourceMaps = true,
    --     protocol = "inspector",
    --     cwd = vim.fn.getcwd(),
    --     runtimeArgs = { "--nolazy" },
    --   },
    --   {
    --     name = "Attach to Process",
    --     type = "node2",
    --     request = "attach",
    --     processId = require("dap.utils").pick_process,
    --   },
    -- }

    -- dap.adapters.chrome = {
    --   type = "executable",
    --   command = "node",
    --   args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
    -- }
    --
    -- dap.configurations.typescript = {
    --   {
    --     name = "Attach to Chrome",
    --     type = "chrome",
    --     request = "attach",
    --     program = "${file}",
    --     cwd = vim.fn.getcwd(),
    --     port = 9222, -- 🚀 Chrome debugging port
    --     webRoot = "${workspaceFolder}",
    --     sourceMaps = true,
    --     skipFiles = { "<node_internals>/**", "webpack://_N_E/./node_modules/**" },
    --   },
    --   {
    --     name = "Launch Chrome with DevTools",
    --     type = "chrome",
    --     request = "launch",
    --     url = "http://localhost:4000", -- Your React app runs on this port
    --     webRoot = "${workspaceFolder}",
    --     runtimeArgs = { "--remote-debugging-port=9222" },
    --     sourceMaps = true,
    --     skipFiles = { "<node_internals>/**", "webpack://_N_E/./node_modules/**" },
    --   },
    -- }
    --
    -- dap.configurations.javascript = {
    --   {
    --     name = "Attach to Chrome",
    --     type = "chrome",
    --     request = "attach",
    --     program = "${file}",
    --     cwd = vim.fn.getcwd(),
    --     port = 9222, -- 🚀 Default Chrome Debug Port
    --     webRoot = "${workspaceFolder}",
    --     sourceMaps = true,
    --     skipFiles = { "<node_internals>/**", "webpack://_N_E/./node_modules/**" },
    --   },
    -- }
  end,
}
