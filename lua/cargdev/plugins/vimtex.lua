-- ============================================================================
-- VIMTEX: LaTeX editing and compilation support
-- ============================================================================
-- Comprehensive LaTeX plugin providing syntax highlighting, compilation with
-- latexmk, forward/inverse search, and PDF viewing. Configured to use Skim
-- as the PDF viewer on macOS. Loads automatically for tex, latex, and bib files.
-- ============================================================================

return {
  "lervag/vimtex",
  ft = { "tex", "latex", "bib" },
  config = function()
    -- Use Skim on macOS (or change to your preferred PDF viewer)
    vim.g.vimtex_view_method = "skim"

    -- Alternatively, use the general viewer (Preview.app)
    -- vim.g.vimtex_view_method = "general"
    -- vim.g.vimtex_view_general_viewer = "open"

    -- Compiler settings
    vim.g.vimtex_compiler_method = "latexmk"

    -- Disable quickfix auto-open (optional)
    vim.g.vimtex_quickfix_mode = 0
  end,
}
