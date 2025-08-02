return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "nvim-neotest/nvim-nio", lazy = false },
    "rcarriga/nvim-dap-ui",
    "jay-babu/mason-nvim-dap.nvim",
    "mfussenegger/nvim-dap-python",
    "theHamsta/nvim-dap-virtual-text",
    "Weissle/persistent-breakpoints.nvim",
    {
      "nvim-neotest/neotest",
      dependencies = {
        "nvim-neotest/neotest-jest",
        "nvim-neotest/neotest-python",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
      },
      config = function()
        require("neotest").setup({
          adapters = {
            require("neotest-jest")({}),
            require("neotest-python")({}),
          },
        })
      end,
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local widgets = require("dap.ui.widgets")
    local api, fn = vim.api, vim.fn
    local keymap = vim.keymap.set

    -- 🎯 Fixed Layout UI (no floating)
    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40, -- width (left)
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 10, -- height (bottom)
          position = "bottom",
        },
      },
      controls = {
        enabled = true,
        element = "repl",
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⤵",
          step_over = "⏭",
          step_out = "⤴",
          step_back = "⏮",
          run_last = "🔁",
          terminate = "⏹",
        },
      },
      floating = { border = "rounded", mappings = { close = { "q", "<Esc>" } } },
      windows = { indent = 1 },
    })

    -- 🧠 Mason DAP
    require("mason-nvim-dap").setup({
      ensure_installed = { "js-debug-adapter", "firefox" },
      automatic_setup = true,
    })

    -- 🔍 Virtual Text
    require("nvim-dap-virtual-text").setup({
      commented = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
      virt_text_pos = "eol",
      all_frames = true,
    })

    -- 💾 Persistent Breakpoints
    require("persistent-breakpoints").setup({
      load_breakpoints_event = { "BufReadPost" },
    })
    
    api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        local ok, pb = pcall(require, "persistent-breakpoints.api")
        if ok and type(pb.save_breakpoints) == "function" then
          pb.save_breakpoints()
        end
      end,
    })

    -- 🔁 Auto-open/close UI on debug events
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- 🎮 Keymaps
    keymap("n", "<leader>dc", dap.continue, { desc = "▶ Start Debugging" })
    keymap("n", "<leader>do", dap.step_over, { desc = "⏭ Step Over" })
    keymap("n", "<leader>di", dap.step_into, { desc = "⤵ Step Into" })
    keymap("n", "<leader>dot", dap.step_out, { desc = "⤴ Step Out" })
    keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "🔴 Toggle Breakpoint" })
    keymap("n", "<leader>dB", function()
      dap.set_breakpoint(fn.input("Breakpoint condition: "))
    end, { desc = "⚠ Conditional Breakpoint" })
    keymap("n", "<leader>dr", dap.repl.open, { desc = "💬 Open REPL" })
    keymap("n", "<leader>dl", dap.run_last, { desc = "🔁 Run Last Debug" })
    keymap("n", "<leader>du", dapui.toggle, { desc = "🧩 Toggle DAP UI" })
    keymap("n", "<leader>dq", dap.terminate, { desc = "⛔ Stop Debugging" })

    -- 🧼 Reset UI
    keymap("n", "<leader>drt", function()
      dap.terminate()
      dapui.close()
      vim.defer_fn(function()
        dapui.open()
      end, 200)
    end, { desc = "🧼 Reset DAP UI Layout" })

    -- 🧿 Sign Icons
    for name, icon in pairs({
      DapBreakpoint = "🔴",
      DapBreakpointCondition = "⚠️",
      DapBreakpointRejected = "🚫",
      DapLogPoint = "💬",
      DapStopped = "▶",
    }) do
      fn.sign_define(name, { text = icon, texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
    end

    -- 🔁 NestJS Smart Watcher (optional)
    api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.ts",
      callback = function()
        if fn.filereadable(".nvim/project.lua") == 1 then
          local config = loadfile(".nvim/project.lua")()
          if config and config.run and config.run:match("nest") then
            -- Your custom logic here
          end
        end
      end,
    })

    -- ☕ Java Debug Adapter
    dap.adapters.java = function(callback)
      callback({ type = "server", host = "127.0.0.1", port = { port } })
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

    -- 🧠 Node.js (NestJS / TypeScript) - Using js-debug-adapter
    dap.adapters.node = {
      type = "executable",
      command = "node",
      args = {
        os.getenv("HOME") .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
        "${port}",
      },
    }

    dap.configurations.typescript = {
      {
        name = "Launch NestJS",
        type = "node",
        request = "launch",
        program = "${workspaceFolder}/dist/main.js",
        args = {},
        console = "integratedTerminal",
        outFiles = { "${workspaceFolder}/dist/**/*.js" },
        sourceMaps = true,
        protocol = "inspector",
        cwd = fn.getcwd(),
        runtimeArgs = { "--inspect-brk" },
        restart = true,
      },
      {
        name = "Attach to NestJS (start:debug)",
        type = "node",
        request = "attach",
        port = 9229,
        protocol = "inspector",
        cwd = fn.getcwd(),
        sourceMaps = true,
        outFiles = { "${workspaceFolder}/dist/**/*.js" },
        skipFiles = { "<node_internals>/**" },
      },
    }

    -- Also add JavaScript configurations
    dap.configurations.javascript = dap.configurations.typescript
  end,
}
