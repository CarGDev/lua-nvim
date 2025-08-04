return {
  "seandewar/killersheep.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required dependency for killersheep.nvim
  },
  config = function()
    require("killersheep").setup({
      gore = true, -- Enables/disables blood and gore.
      keymaps = {
        move_left = "h", -- Keymap to move cannon to the left.
        move_right = "l", -- Keymap to move cannon to the right.
        shoot = "<Space>", -- Keymap to shoot the cannon.
      },
    })
  end,
}
