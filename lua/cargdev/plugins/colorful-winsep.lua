return {
  "nvim-zh/colorful-winsep.nvim",
  event = { "WinLeave" },
  config = function()
    require("colorful-winsep").setup({
      hi = {
        bg = "",
        fg = "#806d9c",
      },
      no_exec_files = {
        "NvimTree",
        "neo-tree",
        "packer",
        "TelescopePrompt",
        "mason",
        "lazy",
        "CompetiTest",
        "fugitive",
      },
      smooth = true,
      exponential_smoothing = true,
      anchor = {
        left = { height = 1, x = -1, y = -1 },
        right = { height = 1, x = -1, y = 0 },
        up = { width = 0, x = -1, y = 0 },
        bottom = { width = 0, x = 1, y = 0 },
      },
      symbols = { "─", "│", "┌", "┐", "└", "┘" },
      only_line_seq = true,
      create_event = function()
        local win_n = require("colorful-winsep.utils").calculate_number_windows()
        if win_n == 2 then
          local win_id = vim.fn.win_getid(vim.fn.winnr("h"))
          local filetype = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win_id), "filetype")
          if filetype == "NvimTree" or filetype == "neo-tree" then
            require("colorful-winsep").NvsepRealClose()
          end
        end
      end,
      close_event = function() end,
    })
  end,
}
