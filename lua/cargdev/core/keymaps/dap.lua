-- DAP (Debug Adapter Protocol) keymaps

local ok_dap, dap = pcall(require, "dap")
local ok_dapui, dapui = pcall(require, "dapui")
local fn = vim.fn
local keymap = vim.keymap.set

if ok_dap and ok_dapui then
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

  -- 🔭 Snacks Integration (replacing Telescope)
keymap("n", "<leader>dcf", "<cmd>lua require('snacks.picker').dap_configurations()<cr>", { desc = "🔭 DAP Configs" })
keymap("n", "<leader>dcb", "<cmd>lua require('snacks.picker').dap_list_breakpoints()<cr>", { desc = "🧷 List Breakpoints" })
keymap("n", "<leader>dco", "<cmd>lua require('snacks.picker').dap_commands()<cr>", { desc = "⚙️ DAP Commands" })
end
