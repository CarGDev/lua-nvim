-- ============================================================================
-- LUALINE: Statusline with mode, git, diagnostics, and more
-- ============================================================================
-- Customizable statusline at the bottom showing: mode, git branch, filename,
-- diagnostics, encoding, filetype, position. Uses rainbow colors inspired
-- by powerlevel10k. Shows lazy.nvim update count and word count.
-- ============================================================================
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
      fg = "#98c379", -- Bright green for better visibility
      fg_dim = "#7ec8e3", -- Light blue for secondary text
      bg = "#282c34",
      bg_dark = "#21252b",
      white = "#ffffff",
      black = "#000000",
    }

    -- P10k rainbow style theme with solid backgrounds
    local theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.white, gui = "bold" },
        b = { bg = colors.bg, fg = colors.cyan },
        c = { bg = colors.bg_dark, fg = colors.green },
        z = { bg = colors.blue, fg = colors.white, gui = "bold" },
      },
      insert = {
        a = { bg = colors.green, fg = colors.white, gui = "bold" },
        b = { bg = colors.bg, fg = colors.cyan },
        c = { bg = colors.bg_dark, fg = colors.green },
        z = { bg = colors.green, fg = colors.white, gui = "bold" },
      },
      visual = {
        a = { bg = colors.magenta, fg = colors.white, gui = "bold" },
        b = { bg = colors.bg, fg = colors.cyan },
        c = { bg = colors.bg_dark, fg = colors.green },
        z = { bg = colors.magenta, fg = colors.white, gui = "bold" },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.white, gui = "bold" },
        b = { bg = colors.bg, fg = colors.cyan },
        c = { bg = colors.bg_dark, fg = colors.green },
        z = { bg = colors.yellow, fg = colors.white, gui = "bold" },
      },
      replace = {
        a = { bg = colors.red, fg = colors.white, gui = "bold" },
        b = { bg = colors.bg, fg = colors.cyan },
        c = { bg = colors.bg_dark, fg = colors.green },
        z = { bg = colors.red, fg = colors.white, gui = "bold" },
      },
      inactive = {
        a = { bg = colors.bg_dark, fg = colors.cyan },
        b = { bg = colors.bg_dark, fg = colors.cyan },
        c = { bg = colors.bg_dark, fg = colors.cyan },
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

    -- Word counter (excluding symbols) - cached to avoid recomputing on every statusline refresh
    local cached_word_count = 0
    local word_count_timer = nil
    local function update_word_count()
      local buf = vim.api.nvim_get_current_buf()
      local line_count = vim.api.nvim_buf_line_count(buf)
      if line_count > 5000 then
        cached_word_count = -1
        return
      end
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local text = table.concat(lines, " ")
      local clean_text = text:gsub("[^%w%s]", "")
      local count = 0
      for _ in clean_text:gmatch("%w+") do
        count = count + 1
      end
      cached_word_count = count
    end

    -- Debounce: only recount on TextChanged/BufEnter for .tex files
    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufEnter" }, {
      callback = function()
        if vim.bo.filetype ~= "tex" then
          cached_word_count = -1
          return
        end
        if word_count_timer then
          word_count_timer:stop()
        end
        word_count_timer = vim.defer_fn(update_word_count, 500)
      end,
    })

    local function word_count()
      if cached_word_count < 0 then return "" end
      return "words: " .. cached_word_count
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
          { word_count, color = { fg = colors.cyan } },
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
