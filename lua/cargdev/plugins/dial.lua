return {
  "monaqa/dial.nvim",
  keys = {
    { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
    { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    { "g<C-a>", function() return require("dial.map").inc_gnormal() end, expr = true, desc = "Increment (g)" },
    { "g<C-x>", function() return require("dial.map").dec_gnormal() end, expr = true, desc = "Decrement (g)" },
    { "<C-a>", function() return require("dial.map").inc_visual() end, mode = "v", expr = true, desc = "Increment" },
    { "<C-x>", function() return require("dial.map").dec_visual() end, mode = "v", expr = true, desc = "Decrement" },
    { "g<C-a>", function() return require("dial.map").inc_gvisual() end, mode = "v", expr = true, desc = "Increment (g)" },
    { "g<C-x>", function() return require("dial.map").dec_gvisual() end, mode = "v", expr = true, desc = "Decrement (g)" },
  },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.integer.alias.octal,
        augend.integer.alias.binary,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%m/%d/%Y"],
        augend.date.alias["%d/%m/%Y"],
        augend.date.alias["%H:%M:%S"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.bool,
        augend.constant.new({
          elements = { "true", "false" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "True", "False" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "yes", "no" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "Yes", "No" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "on", "off" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "enable", "disable" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "enabled", "disabled" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "public", "private", "protected" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "let", "const", "var" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "&&", "||" },
          word = false,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "==", "!=" },
          word = false,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "===", "!==" },
          word = false,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { ">", "<" },
          word = false,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { ">=", "<=" },
          word = false,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "px", "em", "rem", "%" },
          word = false,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "GET", "POST", "PUT", "PATCH", "DELETE" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "info", "warn", "error", "debug" },
          word = true,
          cyclic = true,
        }),
        augend.hexcolor.new({
          case = "lower",
        }),
        augend.semver.alias.semver,
      },
    })
  end,
}
