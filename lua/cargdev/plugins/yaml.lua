-- ============================================================================
-- YAML.NVIM: YAML path navigation and utilities
-- ============================================================================
-- Provides utilities for working with YAML files including showing the current
-- path in the document, searching by path, and jumping to keys. Integrates
-- with Telescope, fzf-lua, and snacks.nvim for fuzzy searching capabilities.
-- Requires treesitter for parsing YAML structure.
-- ============================================================================

return {
  "cuducos/yaml.nvim",
  ft = { "yaml" }, -- optional
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "folke/snacks.nvim", -- optional
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua", -- optional
  },
}
