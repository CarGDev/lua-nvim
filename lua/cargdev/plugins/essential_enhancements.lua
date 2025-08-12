return {
  -- Enhanced notifications with better positioning
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      vim.notify = require("notify")
      
      -- Configure notifications to avoid overlapping
      require("notify").setup({
        -- Position notifications to avoid overlapping with dashboard
        stages = "fade_in_slide_out",
        timeout = 3000,
        background_colour = "#000000",
        max_width = 50,
        max_height = 10,
        default_timeout = 4000,
        top_down = false, -- Show newer notifications at the bottom
        render = "minimal",
        minimum_width = 20,
        icons = {
          ERROR = " ",
          WARN = " ",
          INFO = " ",
          DEBUG = " ",
          TRACE = " ",
        },
        -- Position notifications away from dashboard
        on_open = function(win)
          -- Move notification window to avoid overlapping with alpha dashboard
          local config = vim.api.nvim_win_get_config(win)
          if config.relative == "editor" then
            -- Position notifications in the top-right, but not overlapping dashboard
            vim.api.nvim_win_set_config(win, {
              row = 2,
              col = vim.o.columns - 60, -- Position from right side
              relative = "editor",
              width = 55,
              height = 8,
            })
          end
        end,
      })
    end,
  },

  -- Better session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { 
      dir = vim.fn.stdpath("state") .. "/sessions",
      options = { "buffers", "curdir", "tabpages", "winsize", "help" }
    },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },

  -- Project management
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern", "lsp" },
        patterns = { 
          ".git", 
          "package.json", 
          "pyproject.toml", 
          "Cargo.toml",
          "go.mod",
          "requirements.txt"
        },
        show_hidden = false,
        silent_chdir = true,
      })
    end,
  },

  -- Better search and replace
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    config = function()
      require("spectre").setup({
        color_devicons = true,
        open_cmd = "vnew",
        live_update = false, -- Disable for better performance
        line_sep_start = "┌──────────────────────────────────────────────────────────────────────────────┐",
        line_sep = "├──────────────────────────────────────────────────────────────────────────────┤",
        line_sep_end = "└──────────────────────────────────────────────────────────────────────────────┘",
      })
    end,
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Search and Replace" },
    },
  },

  -- Enhanced terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      shade_filetypes = {},
      direction = "float",
      float_opts = {
        border = "curved",
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Float Terminal" },
    },
  },

  -- Better file operations
  {
    "chrisgrieser/nvim-early-retirement",
    event = "VeryLazy",
    opts = {
      retirementAgeMins = 1440, -- 24 hours
      notificationOnAutoClose = true,
      deleteBufferWhenFileDeleted = true,
    },
  },

  -- Enhanced quickfix
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
    config = function()
      require("bqf").setup({
        auto_enable = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┃", "┃", "┛" },
        },
        func_map = {
          vsplit = "",
          ptogglemode = "z,",
          stoggleup = "",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        },
      })
    end,
  },

  -- Better completion menu with improved positioning
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "%d fewer lines" },
              { find = "%d more lines" },
            },
          },
          view = "mini",
        },
        -- Route startup messages to avoid overlapping with dashboard
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "ideaDrop loaded!" },
              { find = "noice.nvim" },
              { find = "lazyredraw" },
            },
          },
          view = "notify",
          opts = { timeout = 2000 },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
      -- Position command palette and other UI elements to avoid overlapping
      cmdline = {
        position = {
          row = "50%",
          col = "50%",
        },
      },
      popupmenu = {
        position = {
          row = "50%",
          col = "50%",
        },
      },
      notify = {
        -- Position notifications to avoid dashboard overlap
        position = "top_right",
        max_width = 50,
        max_height = 10,
      },
    },
  },

  -- Better status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Better buffer management
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        mode = "buffers",
        separator_style = "slant",
        always_show_bufferline = false,
        show_buffer_close_icons = true,
        show_close_icon = false,
        color_icons = true,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = require("lazyvim.config").icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },

  -- Better git integration
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    },
  },
}
