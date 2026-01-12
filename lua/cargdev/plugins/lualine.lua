return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    -- Rainbow colors similar to p10k-rainbow
    local colors = {
      blue = "#61afef",
      cyan = "#56b6c2",
      green = "#98c379",
      magenta = "#c678dd",
      orange = "#d19a66",
      red = "#e06c75",
      yellow = "#e5c07b",
      fg = "#abb2bf",
      bg = "#282c34",
      bg_dark = "#21252b",
      white = "#ffffff",
      black = "#000000",
    }

    -- P10k rainbow style theme with solid backgrounds
    local theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.black, gui = "bold" },
        b = { bg = colors.bg, fg = colors.blue },
        c = { bg = colors.bg_dark, fg = colors.fg },
        z = { bg = colors.blue, fg = colors.black, gui = "bold" },
      },
      insert = {
        a = { bg = colors.green, fg = colors.black, gui = "bold" },
        b = { bg = colors.bg, fg = colors.green },
        c = { bg = colors.bg_dark, fg = colors.fg },
        z = { bg = colors.green, fg = colors.black, gui = "bold" },
      },
      visual = {
        a = { bg = colors.magenta, fg = colors.black, gui = "bold" },
        b = { bg = colors.bg, fg = colors.magenta },
        c = { bg = colors.bg_dark, fg = colors.fg },
        z = { bg = colors.magenta, fg = colors.black, gui = "bold" },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
        b = { bg = colors.bg, fg = colors.yellow },
        c = { bg = colors.bg_dark, fg = colors.fg },
        z = { bg = colors.yellow, fg = colors.black, gui = "bold" },
      },
      replace = {
        a = { bg = colors.red, fg = colors.black, gui = "bold" },
        b = { bg = colors.bg, fg = colors.red },
        c = { bg = colors.bg_dark, fg = colors.fg },
        z = { bg = colors.red, fg = colors.black, gui = "bold" },
      },
      inactive = {
        a = { bg = colors.bg_dark, fg = colors.fg },
        b = { bg = colors.bg_dark, fg = colors.fg },
        c = { bg = colors.bg_dark, fg = colors.fg },
      },
    }

    -- LSP client name
    local function lsp_client()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then
        return ""
      end
      local names = {}
      for _, client in ipairs(clients) do
        table.insert(names, client.name)
      end
      return " " .. table.concat(names, ", ")
    end

    lualine.setup({
      options = {
        theme = theme,
        globalstatus = true,
        -- Powerline angled separators like p10k
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "snacks_dashboard" },
        },
      },
      sections = {
        lualine_a = {
          { "mode", icon = "" },
        },
        lualine_b = {
          { "branch", icon = "" },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            colored = true,
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.yellow },
              removed = { fg = colors.red },
            },
          },
        },
        lualine_c = {
          {
            "diagnostics",
            symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
            diagnostics_color = {
              error = { fg = colors.red },
              warn = { fg = colors.yellow },
              info = { fg = colors.cyan },
              hint = { fg = colors.green },
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = { modified = " ●", readonly = " ", unnamed = "󰜥 " } },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = colors.orange, bg = colors.bg_dark },
          },
          { lsp_client, color = { fg = colors.cyan, bg = colors.bg_dark } },
        },
        lualine_y = {
          { "encoding", icon = "" },
          { "fileformat", icons_enabled = true },
          { "filetype", colored = true, icon_only = false },
        },
        lualine_z = {
          { "progress", icon = "󰦨" },
          { "location", icon = "" },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "nvim-tree", "lazy", "fzf", "trouble", "quickfix" },
    })

    -- Ensure statusline has solid background
    vim.opt.laststatus = 3
    vim.api.nvim_set_hl(0, "StatusLine", { bg = colors.bg_dark })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = colors.bg_dark })
  end,
}
