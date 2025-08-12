return {
  "CarGDev/cargdev-cyberpunk",
  --[[   dir = "/Users/carlos/Documents/SSD_Documents/projects/cargdevschemecolor.nvim", ]]
  event = "VimEnter", -- Load only when entering Vim
  priority = 1000,
  config = function()
    require("cargdev-cyberpunk").setup()
  end,
}
