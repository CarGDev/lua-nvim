return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = false, -- Replaced by Snacks dashboard
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local config = require("cargdev.core.dashboard_config")

    -- Set header from shared config
    dashboard.section.header.val = config.header

    -- Set menu from shared config
    dashboard.section.buttons.val = config.get_alpha_buttons(dashboard)

    -- Footer with fortune
    local function center_text(text, width)
      local padding = math.floor((width - #text) / 2)
      return padding > 0 and string.rep(" ", padding) .. text or text
    end

    local function wrap_text(text, width)
      local wrapped_lines = {}
      for line in text:gmatch("[^\n]+") do
        while #line > width do
          local cut = line:sub(1, width)
          table.insert(wrapped_lines, center_text(cut, width))
          line = line:sub(width + 1)
        end
        table.insert(wrapped_lines, center_text(line, width))
      end
      return wrapped_lines
    end

    local viewport_width = 50
    local handle = io.popen("fortune")
    local quote = handle and handle:read("*a") or "Code, Create, Conquer with CarGDev"
    if handle then handle:close() end
    local wrapped_quote = wrap_text(quote:gsub("\n", " "), viewport_width)

    dashboard.section.footer.val = { "", center_text("CarGDev - Innovating with Neovim!", viewport_width), "" }
    for _, line in ipairs(wrapped_quote) do
      table.insert(dashboard.section.footer.val, line)
    end

    dashboard.opts.opts = { position = "center", hl = "Statement", spacing = 2 }
    alpha.setup(dashboard.opts)
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
