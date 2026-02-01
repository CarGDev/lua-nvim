return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
    { "<leader>gnc", "<cmd>Neogit commit<cr>", desc = "Neogit commit" },
    { "<leader>gnp", "<cmd>Neogit push<cr>", desc = "Neogit push" },
    { "<leader>gnl", "<cmd>Neogit pull<cr>", desc = "Neogit pull" },
    { "<leader>gnb", "<cmd>Neogit branch<cr>", desc = "Neogit branch" },
  },
  opts = {
    disable_hint = false,
    disable_context_highlighting = false,
    disable_signs = false,
    graph_style = "unicode",
    git_services = {
      ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
      ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
      ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
    },
    integrations = {
      telescope = true,
      diffview = true,
    },
    sections = {
      untracked = {
        folded = false,
        hidden = false,
      },
      unstaged = {
        folded = false,
        hidden = false,
      },
      staged = {
        folded = false,
        hidden = false,
      },
      stashes = {
        folded = true,
        hidden = false,
      },
      unpulled_upstream = {
        folded = true,
        hidden = false,
      },
      unmerged_upstream = {
        folded = false,
        hidden = false,
      },
      unpulled_pushRemote = {
        folded = true,
        hidden = false,
      },
      unmerged_pushRemote = {
        folded = false,
        hidden = false,
      },
      recent = {
        folded = true,
        hidden = false,
      },
      rebase = {
        folded = true,
        hidden = false,
      },
    },
    mappings = {
      status = {
        ["q"] = "Close",
        ["<esc>"] = "Close",
      },
    },
    signs = {
      hunk = { "", "" },
      item = { "", "" },
      section = { "", "" },
    },
  },
}
