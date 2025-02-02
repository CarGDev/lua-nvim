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
        enabled = true, -- Enables floating command-line window
        view = "cmdline_popup", -- Use floating popup instead of bottom bar
        format = {
          cmdline = { icon = ">" }, -- Custom icon for `:`
          search_down = { icon = "🔍 " }, -- Custom icon for `/`
          search_up = { icon = "🔍 " }, -- Custom icon for `?`
          filter = { icon = "$" },
          lua = { icon = "" },
          help = { icon = "?" },
        },
      },
      messages = {
        enabled = true, -- Show messages in floating windows
        view = "notify", -- Use floating popup instead of bottom bar
      },
      popupmenu = {
        enabled = true, -- Floating completion menu
        backend = "nui",
      },
      lsp = {
        progress = {
          enabled = false,
        },
      },
      views = {
        notify = {
          position = "top", -- Moves notifications to the bottom
          win_options = { winblend = 10 }, -- Optional transparency
          max_height = 2, -- Max height of the notification window
          max_width = 50, -- Max width of the notification window
        },
        mini = {
          position = {
            row = -2, -- Positions it closer to the bottom
            col = "50%",
          },
        },
      },
      presets = {
        bottom_search = false, -- Disable default bottom search bar
        command_palette = true, -- Make commands appear in the center
        long_message_to_split = true, -- Long messages go to a split
      },
    })
  end,
}
