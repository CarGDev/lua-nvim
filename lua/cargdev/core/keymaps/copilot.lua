--- Copilot keymaps.
--- Bindings for GitHub Copilot panel navigation (normal mode) and inline
--- suggestion cycling (insert mode). All Copilot modules are loaded via
--- pcall to avoid errors when Copilot is not installed or authenticated.
--- @module keymaps.copilot

local keymap = vim.keymap

--- Safely require the copilot.panel module.
--- @return table|nil panel The panel module, or nil if unavailable.
local function get_copilot_panel()
  local ok, panel = pcall(require, "copilot.panel")
  return ok and panel or nil
end

--- Safely require the copilot.suggestion module.
--- @return table|nil suggestion The suggestion module, or nil if unavailable.
local function get_copilot_suggestion()
  local ok, suggestion = pcall(require, "copilot.suggestion")
  return ok and suggestion or nil
end

--- Copilot commands — open panel, disable, enable, and check status.
keymap.set("n", "<leader>cp", ":Copilot panel<CR>", { desc = "Copilot: Open copilot panel" })
keymap.set("n", "<leader>cD", ":Copilot disable<CR>", { desc = "Copilot: Disable" })
keymap.set("n", "<leader>cE", ":Copilot enable<CR>", { desc = "Copilot: Enable" })
keymap.set("n", "<leader>cs", ":Copilot status<CR>", { desc = "Copilot: Status" })

--- Panel navigation — jump previous/next, accept, refresh, and open.
keymap.set("n", "[[", function()
  local panel = get_copilot_panel()
  if panel and panel.is_open() then
    panel.jump_prev()
  end
end, { desc = "Copilot: Jump to previous suggestion in panel" })

keymap.set("n", "]]", function()
  local panel = get_copilot_panel()
  if panel and panel.is_open() then
    panel.jump_next()
  end
end, { desc = "Copilot: Jump to next suggestion in panel" })

keymap.set("n", "<CR>", function()
  local panel = get_copilot_panel()
  if panel and panel.is_open() then
    panel.accept()
  end
end, { desc = "Copilot: Accept suggestion in panel" })

keymap.set("n", "rp", function()
  local panel = get_copilot_panel()
  if panel and panel.is_open() then
    panel.refresh()
  end
end, { desc = "Copilot: Refresh panel" })

keymap.set("n", "<M-CR>", ":Copilot panel<CR>", { desc = "Copilot: Open panel" })

--- Inline suggestion cycling (insert mode) — next, previous, dismiss.
keymap.set("i", "<leader>]", function()
  local suggestion = get_copilot_suggestion()
  if suggestion and suggestion.is_visible() then
    suggestion.next()
  end
end, { desc = "Copilot: Next suggestion" })

keymap.set("i", "<leader>[", function()
  local suggestion = get_copilot_suggestion()
  if suggestion and suggestion.is_visible() then
    suggestion.prev()
  end
end, { desc = "Copilot: Previous suggestion" })

keymap.set("i", "<C-]>", function()
  local suggestion = get_copilot_suggestion()
  if suggestion and suggestion.is_visible() then
    suggestion.dismiss()
  end
end, { desc = "Copilot: Dismiss suggestion" })
