return {
  "CarGDev/cargdev-cyberpunk",
  name = "cargdev-cyberpunk",
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.opt.background = "dark"
    require("cargdev-cyberpunk").setup()
  end,
}
