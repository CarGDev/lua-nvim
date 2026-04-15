-- ============================================================================
-- DAP: Debug Adapter Protocol - Interactive debugging
-- ============================================================================
-- Full debugging support with breakpoints, stepping, variable inspection.
-- Includes nvim-dap-ui for visual debugging panels, nvim-dap-python for Python,
-- persistent-breakpoints to save breakpoints across sessions, and neotest
-- for running tests. Auto-opens/closes UI on debug events.
-- ============================================================================
return {
  "mfussenegger/nvim-dap",
  event = { "VeryLazy", "FileType java" }, -- Load on VeryLazy or when opening Java files
  cmd = { "Dap", "DapUI", "DapContinue", "DapToggleBreakpoint" }, -- Load on command
  ft = { "java" }, -- Also load for Java filetype
  dependencies = {
    { "nvim-neotest/nvim-nio", lazy = false },
    "rcarriga/nvim-dap-ui",
    "jay-babu/mason-nvim-dap.nvim",
    "mfussenegger/nvim-dap-python",
    "theHamsta/nvim-dap-virtual-text",
    "Weissle/persistent-breakpoints.nvim",
    {
      "nvim-neotest/neotest",
      event = "VeryLazy",
      dependencies = {
        "nvim-neotest/neotest-jest",
        "nvim-neotest/neotest-python",
        "nvim-lua/plenary.nvim",
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
      ensure_installed = { "python", "js", "javadbg", "javatest" },
      automatic_installation = true,
      handlers = {
        firefox = function() end, -- Disable Firefox auto-config for TS/JS
      },
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
    -- Note: Java DAP is configured by nvim-jdtls in ftplugin/java.lua
    -- via jdtls.setup_dap() which automatically sets up the adapter
    -- The configurations are dynamically discovered from the project

    -- 🐍 Python (debugpy)
    local debugpy_path = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(debugpy_path)

    dap.configurations.python = {
      {
        name = "Launch File",
        type = "python",
        request = "launch",
        program = "${file}",
        console = "integratedTerminal",
        cwd = fn.getcwd(),
      },
      {
        name = "Launch File with Arguments",
        type = "python",
        request = "launch",
        program = "${file}",
        args = function()
          local args_string = vim.fn.input("Arguments: ")
          return vim.split(args_string, " +")
        end,
        console = "integratedTerminal",
        cwd = fn.getcwd(),
      },
      {
        name = "Attach Remote",
        type = "python",
        request = "attach",
        connect = {
          host = "127.0.0.1",
          port = 5678,
        },
      },
      {
        name = "Django",
        type = "python",
        request = "launch",
        program = "${workspaceFolder}/manage.py",
        args = { "runserver", "--noreload" },
        console = "integratedTerminal",
        django = true,
      },
      {
        name = "FastAPI",
        type = "python",
        request = "launch",
        module = "uvicorn",
        args = { "main:app", "--reload" },
        console = "integratedTerminal",
        cwd = fn.getcwd(),
      },
      {
        name = "Flask",
        type = "python",
        request = "launch",
        module = "flask",
        env = { FLASK_APP = "app.py", FLASK_DEBUG = "1" },
        args = { "run", "--no-debugger", "--no-reload" },
        console = "integratedTerminal",
      },
    }

    -- 🧠 Node.js (NestJS / TypeScript) - Using js-debug-adapter (pwa-node)
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = {
          os.getenv("HOME") .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
          "${port}",
        },
      },
    }

    dap.configurations.typescript = {
      {
        name = "Launch with Bun",
        type = "pwa-node",
        request = "launch",
        runtimeExecutable = "bun",
        runtimeArgs = { "--inspect-brk" },
        program = "${file}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
        console = "internalConsole",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
        attachSimplePort = 6499,
      },
      {
        name = "Launch NestJS (dist/main.js)",
        type = "pwa-node",
        request = "launch",
        program = "${workspaceFolder}/dist/main.js",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        outFiles = { "${workspaceFolder}/dist/**/*.js" },
        resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
        console = "integratedTerminal",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
      {
        name = "Launch Current File (Node)",
        type = "pwa-node",
        request = "launch",
        program = "${file}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        console = "integratedTerminal",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
      {
        name = "Launch with ts-node",
        type = "pwa-node",
        request = "launch",
        runtimeExecutable = "node",
        runtimeArgs = { "--loader", "ts-node/esm" },
        program = "${file}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        console = "integratedTerminal",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
      {
        name = "Attach to NestJS (port 9229)",
        type = "pwa-node",
        request = "attach",
        port = 9229,
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        outFiles = { "${workspaceFolder}/dist/**/*.js" },
        resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
        skipFiles = { "<node_internals>/**", "node_modules/**" },
        restart = true,
      },
      {
        name = "Attach to Process",
        type = "pwa-node",
        request = "attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
    }

    -- 🎮 DAP Keymaps (registered here so dap/dapui are already loaded)
    keymap("n", "<leader>dcr", dap.continue, { desc = "▶ Start Debugging" })
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
    keymap("n", "<leader>drt", function()
      dap.terminate()
      dapui.close()
      vim.defer_fn(function()
        dapui.open()
      end, 200)
    end, { desc = "🧼 Reset DAP UI Layout" })
    keymap("n", "<leader>dcf", function()
      local ft = vim.bo.filetype
      local configs = dap.configurations[ft] or {}
      if #configs == 0 then
        vim.notify("No DAP configurations for filetype: " .. ft, vim.log.levels.WARN)
        return
      end
      vim.ui.select(configs, {
        prompt = "Select DAP configuration:",
        format_item = function(item) return item.name end,
      }, function(config)
        if config then dap.run(config) end
      end)
    end, { desc = "🔭 DAP Configs" })
    keymap("n", "<leader>dcb", function()
      dap.list_breakpoints()
      vim.cmd("copen")
    end, { desc = "🧷 List Breakpoints" })
    keymap("n", "<leader>dco", dap.repl.open, { desc = "⚙️ DAP Commands" })

    -- 🔌 Dynamic Debug Attach (no hardcoded ports)
    -- Bun requires --inspect=host:port/debug to set a known WebSocket path
    -- because it doesn't implement /json/list for auto-discovery.
    keymap("n", "<leader>jd", function()
      vim.ui.input({ prompt = "Inspector port (default 6499): " }, function(input)
        if input == nil then return end -- cancelled
        local port = input ~= "" and input or "6499"
        local port_num = tonumber(port)
        if not port_num then
          vim.notify("Invalid port number", vim.log.levels.ERROR)
          return
        end
        local ws_url = "ws://localhost:" .. port .. "/debug"
        vim.notify("Attaching to " .. ws_url, vim.log.levels.INFO)
        dap.run({
          name = "Attach (" .. ws_url .. ")",
          type = "pwa-node",
          request = "attach",
          websocketAddress = ws_url,
          cwd = fn.getcwd(),
          sourceMaps = true,
          resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          restart = true,
        })
      end)
    end, { desc = "🔌 Debug Attach (dynamic)" })

    -- JavaScript uses same configurations as TypeScript
    dap.configurations.javascript = {
      {
        name = "Launch Current File",
        type = "pwa-node",
        request = "launch",
        program = "${file}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
      {
        name = "Attach to Process",
        type = "pwa-node",
        request = "attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
    }

    -- TSX/JSX use the same configurations as their base languages
    dap.configurations.typescriptreact = dap.configurations.typescript
    dap.configurations.javascriptreact = dap.configurations.javascript
  end,
}
