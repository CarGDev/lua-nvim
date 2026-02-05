-- ============================================================================
-- LAZYGIT: Terminal UI for git inside Neovim
-- ============================================================================
-- Opens lazygit (TUI git client) in a floating terminal. Full git workflow:
-- staging, committing, branching, rebasing, etc. <leader>lg to open.
-- Note: snacks.nvim also provides lazygit integration.
-- ============================================================================
return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
  },
}
