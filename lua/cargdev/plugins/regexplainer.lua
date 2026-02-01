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
