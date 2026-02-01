return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerRun",
    "OverseerToggle",
    "OverseerOpen",
    "OverseerClose",
    "OverseerBuild",
    "OverseerTaskAction",
    "OverseerQuickAction",
  },
  keys = {
    { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run task" },
    { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle task list" },
    { "<leader>oa", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
    { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Quick action" },
    { "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Build" },
    { "<leader>oc", "<cmd>OverseerRunCmd<cr>", desc = "Run shell command" },
  },
  opts = {
    strategy = "terminal",
    templates = { "builtin" },
    auto_detect_success_color = true,
    dap = true,
    task_list = {
      default_detail = 1,
      max_width = { 100, 0.2 },
      min_width = { 40, 0.1 },
      width = nil,
      max_height = { 20, 0.1 },
      min_height = 8,
      height = nil,
      separator = "────────────────────────────────────────",
      direction = "bottom",
      bindings = {
        ["?"] = "ShowHelp",
        ["g?"] = "ShowHelp",
        ["<CR>"] = "RunAction",
        ["<C-e>"] = "Edit",
        ["o"] = "Open",
        ["<C-v>"] = "OpenVsplit",
        ["<C-s>"] = "OpenSplit",
        ["<C-f>"] = "OpenFloat",
        ["<C-q>"] = "OpenQuickFix",
        ["p"] = "TogglePreview",
        ["<C-l>"] = "IncreaseDetail",
        ["<C-h>"] = "DecreaseDetail",
        ["L"] = "IncreaseAllDetail",
        ["H"] = "DecreaseAllDetail",
        ["["] = "DecreaseWidth",
        ["]"] = "IncreaseWidth",
        ["{"] = "PrevTask",
        ["}"] = "NextTask",
        ["<C-k>"] = "ScrollOutputUp",
        ["<C-j>"] = "ScrollOutputDown",
        ["q"] = "Close",
      },
    },
    form = {
      border = "rounded",
      zindex = 40,
      min_width = 80,
      max_width = 0.9,
      width = nil,
      min_height = 10,
      max_height = 0.9,
      height = nil,
      win_opts = {
        winblend = 0,
      },
    },
    task_launcher = {
      bindings = {
        i = {
          ["<C-s>"] = "Submit",
          ["<C-c>"] = "Cancel",
        },
        n = {
          ["<CR>"] = "Submit",
          ["<C-s>"] = "Submit",
          ["q"] = "Cancel",
          ["?"] = "ShowHelp",
        },
      },
    },
    task_editor = {
      bindings = {
        i = {
          ["<CR>"] = "NextOrSubmit",
          ["<C-s>"] = "Submit",
          ["<Tab>"] = "Next",
          ["<S-Tab>"] = "Prev",
          ["<C-c>"] = "Cancel",
        },
        n = {
          ["<CR>"] = "NextOrSubmit",
          ["<C-s>"] = "Submit",
          ["<Tab>"] = "Next",
          ["<S-Tab>"] = "Prev",
          ["q"] = "Cancel",
          ["?"] = "ShowHelp",
        },
      },
    },
    component_aliases = {
      default = {
        { "display_duration", detail_level = 2 },
        "on_output_summarize",
        "on_exit_set_status",
        "on_complete_notify",
        "on_complete_dispose",
      },
      default_neotest = {
        "unique",
        { "on_complete_notify", system = "unfocused" },
        "default",
      },
    },
    bundles = {
      save_task_opts = {
        bundleable = true,
      },
    },
    preload_components = {},
    default_template_prompt = "allow",
    log = {
      {
        type = "echo",
        level = vim.log.levels.WARN,
      },
      {
        type = "file",
        filename = "overseer.log",
        level = vim.log.levels.WARN,
      },
    },
  },
  config = function(_, opts)
    local overseer = require("overseer")
    overseer.setup(opts)

    -- Custom templates for common tasks
    overseer.register_template({
      name = "npm run dev",
      builder = function()
        return {
          cmd = { "npm" },
          args = { "run", "dev" },
          name = "npm dev",
        }
      end,
      condition = {
        filetype = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
      },
    })

    overseer.register_template({
      name = "npm run build",
      builder = function()
        return {
          cmd = { "npm" },
          args = { "run", "build" },
          name = "npm build",
        }
      end,
      condition = {
        filetype = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
      },
    })

    overseer.register_template({
      name = "npm test",
      builder = function()
        return {
          cmd = { "npm" },
          args = { "test" },
          name = "npm test",
        }
      end,
      condition = {
        filetype = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
      },
    })

    overseer.register_template({
      name = "Python run file",
      builder = function()
        return {
          cmd = { "python3" },
          args = { vim.fn.expand("%:p") },
          name = "python " .. vim.fn.expand("%:t"),
        }
      end,
      condition = {
        filetype = { "python" },
      },
    })

    overseer.register_template({
      name = "Flutter run",
      builder = function()
        return {
          cmd = { "flutter" },
          args = { "run" },
          name = "flutter run",
        }
      end,
      condition = {
        filetype = { "dart" },
      },
    })

    overseer.register_template({
      name = "Go run",
      builder = function()
        return {
          cmd = { "go" },
          args = { "run", "." },
          name = "go run",
        }
      end,
      condition = {
        filetype = { "go" },
      },
    })
  end,
}
