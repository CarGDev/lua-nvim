return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- 🚀 Set header
    dashboard.section.header.val = {
      "  ██████╗ █████╗ ██████╗  ██████╗ ██████╗ ███████╗██╗   ██╗ ",
      "  █╔════╝██╔══██╗██╔══██╗██╔════╝ ██╔══██╗██╔════╝██║   ██║ ",
      "  █║     ███████║██████╔╝██║  ███╗██║  ██║█████╗  ██║   ██║ ",
      "  █║     ██╔══██║██╔══██╗██║   ██║██║  ██║██╔══╝  ╚██╗ ██╔╝ ",
      "  ██████╗██║  ██║██║  ██║╚██████╔╝██████╔╝███████╗ ╚████╔╝  ",
      "  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝  ╚═══╝   ",
      "                                                     ",
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
      "                                                     ",
      "  🚀 Welcome to CarGDev Neovim - Customize Your Flow! 🚀  ",
    }

    -- 📂 Set menu with improved icons
    dashboard.section.buttons.val = {
      dashboard.button("e", "📜  New File", "<cmd>ene<CR>"),
      dashboard.button("SPC ee", "📂  File Explorer", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("SPC ff", "🔎  Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("SPC fs", "📝  Find Word", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("SPC wr", "💾  Restore Session", "<cmd>SessionRestore<CR>"),
      dashboard.button("q", "❌  Quit NVIM", "<cmd>qa<CR>"),
    }

    -- 🎯 Function to center text within a width
    local function center_text(text, width)
      local padding = math.floor((width - #text) / 2)
      return padding > 0 and string.rep(" ", padding) .. text or text
    end

    -- 📌 Function to wrap text at a specific width
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

    -- 🖥 Set viewport width (adjust if necessary)
    local viewport_width = 50

    -- 📝 Get a fortune quote and wrap it
    local handle = io.popen("fortune")
    local quote = handle and handle:read("*a") or "💻 Code, Create, Conquer with CarGDev 🚀"
    if handle then
      handle:close()
    end
    local wrapped_quote = wrap_text(quote:gsub("\n", " "), viewport_width)

    -- 📝 Set the footer content with added spacing
    dashboard.section.footer.val = {
      "",
      center_text("🔧  CarGDev - Innovating with Neovim! 🔧", viewport_width),
      "",
    }

    -- Add wrapped quote below separator
    for _, line in ipairs(wrapped_quote) do
      table.insert(dashboard.section.footer.val, line)
    end

    -- Add branding line at the bottom
    table.insert(dashboard.section.footer.val, "")
    table.insert(
      dashboard.section.footer.val,
      center_text("🎯 Stay productive & code with passion! 🚀", viewport_width)
    )
    table.insert(dashboard.section.footer.val, "")

    -- 🌈 Apply modern styling
    dashboard.opts.opts = {
      position = "center",
      hl = "Statement",
      spacing = 2,
    }

    -- 🚀 Load dashboard config
    alpha.setup(dashboard.opts)

    -- 🔥 Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
