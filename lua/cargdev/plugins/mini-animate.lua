return {
  "echasnovski/mini.animate",
  event = "VeryLazy",
  opts = function()
    local animate = require("mini.animate")
    return {
      cursor = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
      },
      scroll = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
      },
      resize = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
      },
      open = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
        winconfig = animate.gen_winconfig.wipe({ direction = "from_edge" }),
        winblend = animate.gen_winblend.linear({ from = 80, to = 100 }),
      },
      close = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
        winconfig = animate.gen_winconfig.wipe({ direction = "to_edge" }),
        winblend = animate.gen_winblend.linear({ from = 100, to = 80 }),
      },
    }
  end,
}
