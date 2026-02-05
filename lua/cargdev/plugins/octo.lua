-- ============================================================================
-- OCTO: GitHub integration for Neovim
-- ============================================================================
-- A plugin that brings GitHub functionality directly into Neovim, allowing
-- you to manage issues, pull requests, and repositories without leaving
-- your editor. Uses Telescope for browsing and searching.
--
-- Keymaps (leader: o):
--   <leader>oi - List issues
--   <leader>oI - Create new issue
--   <leader>op - List pull requests
--   <leader>oP - Create new pull request
--   <leader>or - List repositories
--   <leader>os - Search issues/PRs
--   <leader>oa - Show available Octo actions
--
-- Picker mappings:
--   <C-b> - Open in browser
--   <C-y> - Copy URL to clipboard
--   <C-o> - Checkout PR
--   <C-r> - Merge PR
-- ============================================================================
return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Octo",
  keys = {
    { "<leader>oi", "<cmd>Octo issue list<cr>", desc = "List issues" },
    { "<leader>oI", "<cmd>Octo issue create<cr>", desc = "Create issue" },
    { "<leader>op", "<cmd>Octo pr list<cr>", desc = "List PRs" },
    { "<leader>oP", "<cmd>Octo pr create<cr>", desc = "Create PR" },
    { "<leader>or", "<cmd>Octo repo list<cr>", desc = "List repos" },
    { "<leader>os", "<cmd>Octo search<cr>", desc = "Search issues/PRs" },
    { "<leader>oa", "<cmd>Octo actions<cr>", desc = "Octo actions" },
  },
  opts = {
    use_local_fs = false,
    enable_builtin = true,
    default_remote = { "upstream", "origin" },
    ssh_aliases = {},
    picker = "telescope",
    picker_config = {
      use_emojis = true,
      mappings = {
        open_in_browser = { lhs = "<C-b>", desc = "open in browser" },
        copy_url = { lhs = "<C-y>", desc = "copy url to clipboard" },
        checkout_pr = { lhs = "<C-o>", desc = "checkout PR" },
        merge_pr = { lhs = "<C-r>", desc = "merge PR" },
      },
    },
    comment_icon = "",
    outdated_icon = "󰅒 ",
    resolved_icon = " ",
    reaction_viewer_hint_icon = " ",
    user_icon = " ",
    timeline_marker = " ",
    timeline_indent = "2",
    right_bubble_delimiter = "",
    left_bubble_delimiter = "",
    github_hostname = "",
    snippet_context_lines = 4,
    gh_env = {},
    timeout = 5000,
    default_to_projects_v2 = false,
    ui = {
      use_signcolumn = true,
    },
    issues = {
      order_by = {
        field = "CREATED_AT",
        direction = "DESC",
      },
    },
    pull_requests = {
      order_by = {
        field = "CREATED_AT",
        direction = "DESC",
      },
      always_select_remote_on_create = false,
    },
    file_panel = {
      size = 10,
      use_icons = true,
    },
    mappings = {},
  },
}
