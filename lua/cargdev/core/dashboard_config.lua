-- Minimalist TUI-style dashboard configuration
local M = {}

-- CARGDEV NEOVIM ASCII art logo
M.header = {
  "",
  "  ██████╗ █████╗ ██████╗  ██████╗ ██████╗ ███████╗██╗   ██╗ ",
  "  █╔════╝██╔══██╗██╔══██╗██╔════╝ ██╔══██╗██╔════╝██║   ██║ ",
  "  █║     ███████║██████╔╝██║  ███╗██║  ██║█████╗  ██║   ██║ ",
  "  █║     ██╔══██║██╔══██╗██║   ██║██║  ██║██╔══╝  ╚██╗ ██╔╝ ",
  "  ██████╗██║  ██║██║  ██║╚██████╔╝██████╔╝███████╗ ╚████╔╝  ",
  "  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝  ╚═══╝   ",
  "",
  "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  "",
}

-- Minimal VS Code-like menu items
M.menu_items = {
  { key = "f", icon = "", desc = "Go to File",         action = ":Telescope find_files" },
  { key = "r", icon = "", desc = "Recent Files",       action = ":Telescope oldfiles" },
  { key = "g", icon = "", desc = "Find in Files",      action = ":Telescope live_grep" },
  { key = "s", icon = "", desc = "Restore Session",    action = ":lua require('persistence').load()" },
  { key = "e", icon = "", desc = "Explorer",           action = ":NvimTreeToggle" },
  { key = "c", icon = "", desc = "Settings",           action = ":e $MYVIMRC" },
  { key = "q", icon = "", desc = "Quit",               action = ":qa" },
}

-- Get header as string (for snacks)
function M.get_header_string()
  return table.concat(M.header, "\n")
end

-- Helper to convert menu items to snacks format
local function to_snacks_keys(items)
  local keys = {}
  for _, item in ipairs(items) do
    table.insert(keys, {
      icon = item.icon,
      key = item.key,
      desc = item.desc,
      action = item.action,
    })
  end
  return keys
end

-- Get snacks dashboard keys format
function M.get_snacks_keys()
  return to_snacks_keys(M.menu_items)
end

return M
