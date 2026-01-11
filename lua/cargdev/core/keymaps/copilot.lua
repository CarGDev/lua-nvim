-- Copilot keymaps
local keymap = vim.keymap

-- Helper function to safely get Copilot modules
local function get_copilot_panel()
  local ok, panel = pcall(require, "copilot.panel")
  return ok and panel or nil
end

local function get_copilot_suggestion()
  local ok, suggestion = pcall(require, "copilot.suggestion")
  return ok and suggestion or nil
end

-- Copilot panel and status
keymap.set("n", "<leader>cp", ":Copilot panel<CR>", { desc = "Copilot: Open copilot panel" })
keymap.set("n", "<leader>cd", ":Copilot disable<CR>", { desc = "Copilot: Disable" })
keymap.set("n", "<leader>ce", ":Copilot enable<CR>", { desc = "Copilot: Enable" })
keymap.set("n", "<leader>cs", ":Copilot status<CR>", { desc = "Copilot: Status" })

-- Copilot panel keymaps
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

keymap.set("n", "gr", function()
  local panel = get_copilot_panel()
  if panel and panel.is_open() then
    panel.refresh()
  end
end, { desc = "Copilot: Refresh panel" })

keymap.set("n", "<M-CR>", ":Copilot panel<CR>", { desc = "Copilot: Open panel" })

-- Copilot suggestion keymaps (insert mode)
-- Note: Tab mapping is handled in nvim-cmp.lua to avoid conflicts
-- Tab is reserved exclusively for Copilot inline suggestions

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

-- CodeCompanion keymaps
keymap.set("n", "<leader>cc", ":CodeCompanion<CR>", { desc = "CodeCompanion: Open CodeCompanion" })
