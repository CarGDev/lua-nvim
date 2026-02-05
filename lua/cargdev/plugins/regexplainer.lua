-- ============================================================================
-- REGEXPLAINER: Human-readable regex explanations
-- ============================================================================
-- Parses regular expressions under the cursor and displays a human-readable
-- narrative explanation in a popup window. Uses Treesitter for accurate
-- parsing across multiple languages including JS/TS, Lua, Python, Go, Rust.
-- Keymap: <leader>rx (toggle explanation popup)
-- ============================================================================

return {
  "bennypowers/nvim-regexplainer",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "MunifTanjim/nui.nvim",
  },
  cmd = { "RegexplainerShow", "RegexplainerToggle" },
  keys = {
    { "<leader>rx", "<cmd>RegexplainerToggle<cr>", desc = "Toggle Regexplainer" },
  },
  opts = {
    mode = "narrative",
    auto = false,
    filetypes = {
      "html",
      "js",
      "cjs",
      "mjs",
      "ts",
      "jsx",
      "tsx",
      "cjsx",
      "mjsx",
      "lua",
      "python",
      "java",
      "go",
      "rust",
    },
    debug = false,
    display = "popup",
    mappings = {
      toggle = "<leader>rx",
    },
    narrative = {
      separator = "\n",
    },
  },
}
