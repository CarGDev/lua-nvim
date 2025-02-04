return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        format = {
          cmdline = { icon = ">" },
          search_down = { icon = "🔍 " },
          search_up = { icon = "🔍 " },
          filter = { icon = "$" },
          lua = { icon = "" },
          help = { icon = "?" },
        },
      },
      messages = {
        enabled = true,
        view = "mini", -- Mini popup for messages
        view_error = "mini", -- Ensure errors also use mini
        view_warn = "mini",
        view_history = "messages",
        view_search = "virtualtext",
      },
      popupmenu = {
        enabled = true,
        backend = "nui",
      },
      lsp = {
        progress = {
          enabled = false,
        },
        message = {
          enabled = true,
          view = "mini", -- Show LSP messages in mini popup
        },
      },
      views = {
        mini = {
          position = {
            row = "100%", -- Place it at the bottom of the screen
            col = "50%", -- Center it horizontally
          },
          border = {
            style = "rounded",
          },
          win_options = {
            winblend = 10, -- Slight transparency
          },
          max_height = 2, -- Small window size
          max_width = 60,
        },
        notify = {
          position = {
            row = "100%", -- Bottom of the screen
            col = "50%",
          },
          win_options = {
            winblend = 10,
          },
          max_height = 2,
          max_width = 60,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = false,
      },
    })
  end,
}
