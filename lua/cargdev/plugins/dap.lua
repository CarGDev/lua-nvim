return {
  "mfussenegger/nvim-dap",
  optional = true,
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

    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 10,
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

    require("mason-nvim-dap").setup({
      ensure_installed = { "js-debug-adapter", "firefox" },
      automatic_setup = true,
    })

    require("nvim-dap-virtual-text").setup({
      commented = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
      virt_text_pos = "eol",
      all_frames = true,
    })

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

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    local map = function(lhs, rhs, desc)
      keymap("n", lhs, rhs, { desc = "Debug: " .. desc })
    end

    map("<leader>dc", dap.continue, "Continue")
    map("<leader>db", dap.toggle_breakpoint, "Toggle Breakpoint")
    map("<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, "Conditional Breakpoint")
    map("<leader>do", dap.step_over, "Step Over")
    map("<leader>di", dap.step_into, "Step Into")
    map("<leader>dO", dap.step_out, "Step Out")
    map("<leader>dt", dap.terminate, "Terminate")
    map("<leader>dr", dap.repl.toggle, "Toggle REPL")
    map("<leader>dl", dap.run_last, "Run Last")
    map("<leader>dw", widgets.hover, "Hover Variables")
    map("<leader>dp", widgets.preview, "Preview")

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

    api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.ts",
      callback = function()
        if fn.filereadable(".nvim/project.lua") == 1 then
          local config = loadfile(".nvim/project.lua")()
          if config and config.run and config.run:match("nest") then
            -- custom logic here
          end
        end
      end,
    })
  end,
}
