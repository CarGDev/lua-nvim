-- ============================================================================
-- GIT-CONFLICT: Merge conflict resolution
-- ============================================================================
-- Highlights the conflict markers in a file and lets you pick which side to keep
-- with simple mappings, so you don't edit the markers by hand.
-- Example: open a file mid-merge and choose current, incoming or both changes.
-- ============================================================================
return {
  "akinsho/git-conflict.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("git-conflict").setup({
      default_mappings = true, -- enable buffer local mapping created by this plugin
      disable_diagnostics = true, -- This will disable diagnostics in a buffer whilst it is conflicted
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = "DiffText",
        current = "DiffAdd",
      },
    })
  end,
}
