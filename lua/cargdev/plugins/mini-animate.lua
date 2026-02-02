return {
  "echasnovski/mini.animate",
  event = "VeryLazy",
  opts = function()
    local animate = require("mini.animate")
    return {
      cursor = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
      },
      scroll = {
        enable = false, -- Disabled for performance
      },
      resize = {
        enable = false, -- Disabled for performance
      },
      open = {
        enable = false, -- Disabled for performance
      },
      close = {
        enable = false, -- Disabled for performance
      },
    }
  end,
}
