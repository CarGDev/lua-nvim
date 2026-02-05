-- ============================================================================
-- nvim-highlight-colors: Color highlighting
-- ============================================================================
-- Highlights color codes in your files with their actual colors as background.
-- Supports hex (#fff, #ffffff), RGB, HSL, CSS named colors, and CSS variables.
-- Renders colors inline making it easy to visualize color values in stylesheets.
-- ============================================================================

return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    render = "background",
    virtual_symbol = "■",
    virtual_symbol_prefix = "",
    virtual_symbol_suffix = " ",
    virtual_symbol_position = "inline",
    enable_hex = true,
    enable_short_hex = true,
    enable_rgb = true,
    enable_hsl = true,
    enable_var_usage = true,
    enable_named_colors = true,
    enable_tailwind = true,
    custom_colors = {},
    exclude_filetypes = {},
    exclude_buftypes = {},
  },
}
