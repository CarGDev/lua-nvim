-- ============================================================================
-- KULALA: HTTP client for Neovim
-- ============================================================================
-- A REST client plugin that allows you to run HTTP requests directly from
-- .http files. Supports multiple requests, environments, and cURL export.
-- Key features: request execution, environment switching, response inspection.
--
-- Keymaps (leader: k):
--   <leader>kr - Run current HTTP request
--   <leader>ka - Run all requests in file
--   <leader>kp/kn - Jump to previous/next request
--   <leader>ki - Inspect request details
--   <leader>kt - Toggle between headers and body view
--   <leader>kc - Copy request as cURL command
--   <leader>ke - Set environment variables
-- ============================================================================
return {
  "mistweaverco/kulala.nvim",
  ft = "http",
  keys = {
    { "<leader>kr", "<cmd>lua require('kulala').run()<cr>", desc = "Run HTTP request" },
    { "<leader>ka", "<cmd>lua require('kulala').run_all()<cr>", desc = "Run all requests" },
    { "<leader>kp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Previous request" },
    { "<leader>kn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Next request" },
    { "<leader>ki", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect request" },
    { "<leader>kt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body" },
    { "<leader>kc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as cURL" },
    { "<leader>ke", "<cmd>lua require('kulala').set_selected_env()<cr>", desc = "Set environment" },
  },
  opts = {
    default_view = "body",
    split_direction = "vertical",
    icons = {
      inlay = {
        loading = "⏳",
        done = "✅",
        error = "❌",
      },
    },
  },
}
