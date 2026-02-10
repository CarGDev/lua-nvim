-- ============================================================================
-- OBSIDIAN: Full Obsidian vault integration for Neovim
-- ============================================================================
-- Wiki-link completion, daily notes, templates, backlinks, Telescope search,
-- and more. Replaces the custom follow_obsidian_link() function.
-- ============================================================================
return {
  "epwalsh/obsidian.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
  },
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/Nextcloud/ObsidianVault/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Nextcloud/ObsidianVault/**.md",
  },
  ft = "markdown",
  keys = {
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
    { "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Today's daily note" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Show backlinks" },
    { "<leader>ot", "<cmd>ObsidianTemplate<cr>", desc = "Insert template" },
    { "<leader>of", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
    { "<leader>ol", "<cmd>ObsidianLink<cr>", mode = "v", desc = "Link selection to note" },
  },
  opts = {
    workspaces = {
      {
        name = "vault",
        path = "/Users/carlos/Nextcloud/ObsidianVault",
      },
    },
    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
    },
    templates = {
      folder = "templates",
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    preferred_link_style = "wiki",
    use_advanced_uri = false,
    picker = {
      name = "telescope.nvim",
    },
  },
}
