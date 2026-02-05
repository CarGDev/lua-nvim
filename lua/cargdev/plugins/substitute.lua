-- ============================================================================
-- SUBSTITUTE.NVIM: Enhanced Text Substitution
-- ============================================================================
-- Provides improved substitution operators for Neovim. Allows quick text
-- replacement using motions, making it easy to substitute text with the
-- contents of a register.
--
-- Keymaps:
--   <leader>ss - Substitute entire line
--   <leader>s  - Substitute with motion
--   S          - Substitute to end of line
--   s (visual) - Substitute in visual selection
-- ============================================================================
return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local substitute = require("substitute")

    substitute.setup()

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ss", "S", { desc = "Substitute line" })
    keymap.set("n", "<leader>s", "s", { desc = "Substitute with motion" })
    keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
    keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode" })
  end,
}
