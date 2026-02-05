-- ============================================================================
-- HARDTIME: Break bad vim habits
-- ============================================================================
-- Helps you break bad Vim habits by limiting repetitive key presses (hjkl, etc.)
-- Shows hints for better motion alternatives. Disabled by default, toggle with
-- <leader>ht. Uses "hint" mode to suggest improvements without blocking input.
-- ============================================================================

return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  opts = {
    max_time = 1000,
    max_count = 3,
    disable_mouse = false,
    hint = true,
    notification = true,
    allow_different_key = true,
    enabled = false, -- DISABLED by default - use <leader>ht to enable
    restriction_mode = "hint", -- Only show hints, never block
    restricted_keys = {
      ["h"] = { "n", "x" },
      ["j"] = { "n", "x" },
      ["k"] = { "n", "x" },
      ["l"] = { "n", "x" },
    },
    disabled_keys = {}, -- Don't disable any keys
    disabled_filetypes = {
      "NvimTree",
      "neo-tree",
      "lazy",
      "mason",
      "qf",
      "netrw",
      "help",
      "oil",
      "Trouble",
      "trouble",
      "spectre_panel",
      "toggleterm",
      "TelescopePrompt",
      "snacks_input",
      "noice",
      "DressingInput",
      "prompt",
    },
    disabled_buftypes = {
      "nofile",
      "prompt",
      "popup",
      "terminal",
    },
  },
  keys = {
    { "<leader>ht", "<cmd>Hardtime toggle<cr>", desc = "Toggle Hardtime" },
  },
}
