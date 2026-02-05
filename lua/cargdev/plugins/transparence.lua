-- ============================================================================
-- TRANSPARENT.NVIM: Background Transparency for Neovim
-- ============================================================================
-- Removes background colors from highlight groups to achieve a transparent
-- background effect, allowing terminal background to show through. Supports
-- many built-in and plugin highlight groups including NvimTree, Telescope,
-- WhichKey, BufferLine, NeoTree, and Lualine.
--
-- Commands:
--   :TransparentToggle - Toggle transparency on/off
--
-- Automatically clears background for BufferLine, NeoTree, and Lualine
-- prefixed highlight groups on startup.
-- ============================================================================
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
        "Conditional",
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
        -- Plugin-specific groups
        "NormalFloat", -- Floating windows
        "NvimTreeNormal", -- NvimTree
        "TelescopeNormal", -- Telescope
        "WhichKeyFloat", -- WhichKey
        "BufferLineFill", -- BufferLine
        "BufferLineBackground",
        "BufferLineSeparator",
        "BufferLineTab",
        "BufferLineTabSelected",
        "BufferLineTabClose",
        "LspInfoBorder", -- LSP info window
        "LspSagaHoverBorder",
        "LspSagaRenameBorder",
        "LspSagaSignatureHelpBorder",
        "NeoTreeNormal", -- NeoTree
        -- Lualine
        "lualine_a_normal",
        "lualine_b_normal",
        "lualine_c_normal",
        "lualine_x_normal",
        "lualine_y_normal",
        "lualine_z_normal",
      },
      exclude_groups = {}, -- Groups you don't want to clear
      on_clear = function()
--[[         print("💡 Transparent Mode Enabled") ]]
      end,
    })

    -- 🔄 **Clear Prefixes Dynamically**
    require("transparent").clear_prefix("BufferLine")
    require("transparent").clear_prefix("NeoTree")
    require("transparent").clear_prefix("lualine")

    -- 🔄 **Custom Commands**
    -- vim.api.nvim_create_user_command("TransparentEnable", function()
    --   require("transparent").enable()
    --   print("🌟 Transparency Enabled")
    -- end, {})

    -- vim.api.nvim_create_user_command("TransparentDisable", function()
    --   require("transparent").disable()
    --   print("🚫 Transparency Disabled")
    -- end, {})

    vim.api.nvim_create_user_command("TransparentToggle", function()
      require("transparent").toggle()
      print("🔄 Transparency Toggled")
    end, {})

    -- Global flag for transparency
    vim.g.transparent_enabled = true
  end,
}
