return {
  "github/copilot.vim",
  lazy = false, -- Force load on startup
  enabled = false,
  config = function()
    vim.g.copilot_no_tab_map = true -- Disable default Tab mapping
    vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-j>", "copilot#Next()", { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-k>", "copilot#Previous()", { expr = true, silent = true })
    vim.api.nvim_set_keymap("i", "<C-x>", "copilot#Dismiss()", { expr = true, silent = true })
  end,
}
