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
    keymap("n", "<F5>", function()
      dap.continue()
    end, { desc = "Start Debugging" })
    keymap("n", "<F10>", function()
      dap.step_over()
    end, { desc = "Step Over" })
    keymap("n", "<F11>", function()
      dap.step_into()
    end, { desc = "Step Into" })
    keymap("n", "<F12>", function()
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

    -- Node.js Adapter Configuration for NestJS
    dap.adapters.node2 = {
      type = "executable",
      command = "node",
      args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodedebug.js" },
    }

    -- Debug Configuration for NestJS
    dap.configurations.typescript = {
      {
        name = "Launch NestJS",
        type = "node2",
        request = "launch",
        program = "${workspaceFolder}/node_modules/.bin/nest",
        args = { "start", "--debug", "--watch" },
        console = "integratedTerminal",
        outFiles = { "${workspaceFolder}/dist/**/*.js" },
        sourceMaps = true,
        protocol = "inspector",
        cwd = vim.fn.getcwd(),
        restart = true,
        runtimeArgs = { "--nolazy" },
      },
      {
        name = "Attach to Process",
        type = "node2",
        request = "attach",
        processId = require("dap.utils").pick_process,
      },
    }
  end,
}
