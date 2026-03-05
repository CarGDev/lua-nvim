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
    -- PDF viewer: Skim on macOS, zathura elsewhere
    if vim.fn.has("mac") == 1 then
      vim.g.vimtex_view_method = "skim"
    else
      vim.g.vimtex_view_method = "zathura"
    end

    -- Compiler settings
    vim.g.vimtex_compiler_method = "latexmk"

    -- Disable quickfix auto-open (optional)
    vim.g.vimtex_quickfix_mode = 0
  end,
}
