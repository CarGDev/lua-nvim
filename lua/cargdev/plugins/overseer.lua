-- ============================================================================
-- OVERSEER: Task runner and job management plugin
-- ============================================================================
-- A task runner and job manager for Neovim with support for various build
-- systems, shell commands, and custom task templates. Features include:
-- - Terminal-based task execution with DAP integration
-- - Task list panel with preview and quick actions
-- - Custom templates for npm, Python, Flutter, Go, Arduino, and C projects
-- Keymaps: <leader>or (run), <leader>ot (toggle), <leader>oa (action),
--          <leader>oq (quick action), <leader>ob (build), <leader>oc (cmd)
-- ============================================================================

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
        -- Auto-open the output dock (focused) whenever a task starts, so
        -- you don't have to manually <leader>ot to see it running.
        { "open_output", direction = "dock", on_start = "always", focus = true },
        -- vim.notify the last output lines if a task fails (belt-and-
        -- suspenders in case you've navigated away from the output dock).
        "on_fail_notify_output",
        "on_exit_set_status",
        "on_complete_notify",
        -- NOTE: "display_duration" and "on_output_summarize" were removed:
        -- both are deprecated no-ops in this overseer.nvim version
        -- ("Components are no longer used to customize task rendering").
        { "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
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

    -- Arduino: compile/upload/monitor via arduino-cli.
    -- Params have defaults so keymaps run instantly; edit them via <leader>or
    -- (OverseerRun picker) when your board's FQBN or port changes.
    overseer.register_template({
      name = "Arduino: Compile",
      params = {
        fqbn = { type = "string", default = "arduino:avr:uno", desc = "Fully Qualified Board Name" },
      },
      builder = function(params)
        return {
          cmd = { "arduino-cli" },
          args = { "compile", "--fqbn", params.fqbn, "." },
          cwd = vim.fn.expand("%:p:h"),
          name = "arduino compile",
        }
      end,
      condition = {
        filetype = { "arduino" },
      },
    })

    overseer.register_template({
      name = "Arduino: Compile & Upload",
      params = {
        fqbn = { type = "string", default = "arduino:avr:uno", desc = "Fully Qualified Board Name" },
        port = { type = "string", default = "/dev/cu.usbmodem3112401", desc = "Upload port" },
      },
      builder = function(params)
        return {
          cmd = { "arduino-cli" },
          args = { "compile", "--upload", "-p", params.port, "--fqbn", params.fqbn, "." },
          cwd = vim.fn.expand("%:p:h"),
          name = "arduino compile & upload",
        }
      end,
      condition = {
        filetype = { "arduino" },
      },
    })

    overseer.register_template({
      name = "Arduino: Serial Monitor",
      params = {
        port = { type = "string", default = "/dev/cu.usbmodem3112401", desc = "Serial port" },
        baud = { type = "string", default = "9600", desc = "Baud rate" },
      },
      builder = function(params)
        return {
          cmd = { "arduino-cli" },
          args = { "monitor", "-p", params.port, "-c", "baudrate=" .. params.baud },
          cwd = vim.fn.expand("%:p:h"),
          name = "arduino monitor",
        }
      end,
      condition = {
        filetype = { "arduino" },
      },
    })

    -- C: auto-detects a Makefile (walking up from the current file); uses it
    -- when present, otherwise falls back to compiling the current file
    -- directly with clang. Matches both Makefile-based projects (e.g.
    -- ~/Documents/projects/cpractices/catProject) and standalone practice
    -- files with no build system.
    local function find_makefile_root(start_dir)
      local found = vim.fs.find("Makefile", { path = start_dir, upward = true })[1]
      if found then
        return vim.fn.fnamemodify(found, ":h")
      end
      return nil
    end

    overseer.register_template({
      name = "C: Build",
      builder = function()
        local file = vim.fn.expand("%:p")
        local dir = vim.fn.expand("%:p:h")
        local root = find_makefile_root(dir)
        if root then
          return {
            cmd = { "make" },
            cwd = root,
            name = "make (C build)",
          }
        end
        local out = vim.fn.expand("%:p:r")
        return {
          cmd = { "clang" },
          args = { "-Wall", "-Wextra", "-g", file, "-o", out },
          cwd = dir,
          name = "clang compile " .. vim.fn.expand("%:t"),
        }
      end,
      condition = {
        filetype = { "c" },
      },
    })

    overseer.register_template({
      name = "C: Compile & Run",
      builder = function()
        local file = vim.fn.expand("%:p")
        local dir = vim.fn.expand("%:p:h")
        local root = find_makefile_root(dir)
        if root then
          -- After `make`, find the most recently built executable in the
          -- project root or build/ dir (binary name may not match the
          -- project folder name, e.g. catProject builds "mycat").
          local run_script = "make && "
            .. 'bin=$(find . build -maxdepth 1 -type f -perm +111 2>/dev/null | xargs -I{} ls -t {} 2>/dev/null | head -1); '
            .. 'if [ -n "$bin" ]; then echo "-- running: $bin"; "$bin"; '
            .. 'else echo "No executable found after build"; fi'
          return {
            cmd = { "sh" },
            args = { "-c", run_script },
            cwd = root,
            name = "make && run",
          }
        end
        local out = vim.fn.expand("%:p:r")
        return {
          cmd = { "sh" },
          args = { "-c", string.format("clang -Wall -Wextra -g %q -o %q && %q", file, out, out) },
          cwd = dir,
          name = "clang run " .. vim.fn.expand("%:t"),
        }
      end,
      condition = {
        filetype = { "c" },
      },
    })
  end,
}
