-- Shared dashboard configuration for alpha-nvim and snacks.dashboard
local M = {}

M.header = {
  "  ██████╗ █████╗ ██████╗  ██████╗ ██████╗ ███████╗██╗   ██╗ ",
  "  █╔════╝██╔══██╗██╔══██╗██╔════╝ ██╔══██╗██╔════╝██║   ██║ ",
  "  █║     ███████║██████╔╝██║  ███╗██║  ██║█████╗  ██║   ██║ ",
  "  █║     ██╔══██║██╔══██╗██║   ██║██║  ██║██╔══╝  ╚██╗ ██╔╝ ",
  "  ██████╗██║  ██║██║  ██║╚██████╔╝██████╔╝███████╗ ╚████╔╝  ",
  "  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝  ╚═══╝   ",
  "                                                     ",
  "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
}

-- Menu items (single column)
M.menu_items = {
  { key = "f", icon = " ", desc = "Find File", action = ":FzfLua files" },
  { key = "n", icon = " ", desc = "New File", action = ":ene | startinsert" },
  { key = "g", icon = " ", desc = "Find Text", action = ":FzfLua live_grep" },
  { key = "r", icon = " ", desc = "Recent Files", action = ":FzfLua oldfiles" },
  { key = "t", icon = " ", desc = "File Tree", action = ":NvimTreeToggle" },
  { key = "L", icon = "󰒲 ", desc = "Lazy", action = ":Lazy" },
  { key = "m", icon = " ", desc = "Mason", action = ":Mason" },
  { key = "q", icon = " ", desc = "Quit", action = ":qa" },
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

-- Get alpha buttons (requires alpha dashboard module)
function M.get_alpha_buttons(dashboard)
  local buttons = {}
  for _, item in ipairs(M.menu_items) do
    local cmd = item.action:gsub("^:", "<cmd>") .. "<CR>"
    table.insert(buttons, dashboard.button(item.key, item.icon .. " " .. item.desc, cmd))
  end
  return buttons
end

return M
