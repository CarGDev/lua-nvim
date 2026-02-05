-- ============================================================================
-- VIM-TMUX-NAVIGATOR: Seamless Navigation Between Vim and Tmux
-- ============================================================================
-- Enables seamless navigation between Neovim splits and tmux panes using
-- consistent keybindings. Uses <C-h/j/k/l> to move between panes regardless
-- of whether they are Neovim splits or tmux panes.
--
-- Default Keymaps (provided by plugin):
--   <C-h> - Navigate left
--   <C-j> - Navigate down
--   <C-k> - Navigate up
--   <C-l> - Navigate right
--   <C-\> - Navigate to previous pane
-- ============================================================================
return {
  "christoomey/vim-tmux-navigator",
  event = "VeryLazy", -- Loads only when needed
}
