return {
  "CarGDev/cargdev-cyberpunk",
  name = "cargdev-cyberpunk",
  lazy = false,
  priority = 1000, -- Load before other plugins for consistent UI
  config = function()
    local opt = vim.opt
    opt.termguicolors = true
    opt.background = "dark"

    require("cargdev-cyberpunk").setup({
      transparent = true,
      italic_comments = true,
      bold_keywords = true,
      bold_functions = true,
      bold_types = true,

      -- Enable terminal colors
      terminal_colors = true,
    })
  end,
}
