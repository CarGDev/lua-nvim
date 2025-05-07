return {
  "xiyaowong/transparent.nvim",
  event = "VeryLazy",
  config = function()
    require("transparent").setup({
      groups = {
        "Normal",
        "NormalNC",
        "Comment",
        "Constant",
        "Special",
        "Identifier",
        "Statement",
        "PreProc",
        "Type",
        "Underlined",
        "Todo",
        "String",
        "Function",
        "Repeat",
        "Operator",
        "Structure",
        "LineNr",
        "NonText",
        "SignColumn",
        "CursorLine",
        "CursorLineNr",
        "StatusLine",
        "StatusLineNC",
        "EndOfBuffer",
      },
      extra_groups = {
        "NormalFloat", -- Floating windows
        "NvimTreeNormal", -- NvimTree
        "TelescopeNormal", -- Telescope
        "WhichKeyFloat", -- WhichKey
        "BufferLineFill", -- Bufferline
        "BufferLineBackground",
        "BufferLineSeparator",
        "BufferLineTab",
        "BufferLineTabSelected",
        "BufferLineTabClose",
        "LspInfoBorder", -- LSP info window
        "LspSagaHoverBorder",
        "LspSagaRenameBorder",
        "LspSagaSignatureHelpBorder",
      },
      exclude_groups = {}, -- Groups you don't want to clear
      on_clear = function()
        print("💡 Transparent Mode Enabled")
      end,
    })

    -- Clear specific plugin prefixes dynamically
    require("transparent").clear_prefix("BufferLine")
    require("transparent").clear_prefix("NeoTree")
    require("transparent").clear_prefix("lualine")

    -- Custom Commands
    vim.api.nvim_create_user_command("TransparentEnable", function()
      require("transparent").enable()
      print("🌟 Transparency Enabled")
    end, {})

    vim.api.nvim_create_user_command("TransparentDisable", function()
      require("transparent").disable()
      print("🚫 Transparency Disabled")
    end, {})

    vim.api.nvim_create_user_command("TransparentToggle", function()
      require("transparent").toggle()
      print("🔄 Transparency Toggled")
    end, {})

    -- Global flag for transparency
    vim.g.transparent_enabled = true
  end,
}
