-- ============================================================================
-- reactive: Reactive cursor mode colors
-- ============================================================================
-- Changes cursor and cursorline colors dynamically based on the current mode.
-- Integrates with catppuccin-mocha theme for consistent color schemes.
-- Provides visual feedback for Normal, Insert, Visual, and other Vim modes.
-- ============================================================================

return {
  "rasulomaroff/reactive.nvim",
  event = "VeryLazy",
  opts = {
    builtin = {
      cursorline = true,
      cursor = true,
      modemsg = true,
    },
    load = { "catppuccin-mocha-cursor", "catppuccin-mocha-cursorline" },
  },
  config = function(_, opts)
    require("reactive").setup(opts)

    -- Custom mode colors
    require("reactive").add_preset({
      name = "custom",
      init = function()
        vim.opt.guicursor:append("a:ReactiveCursor")
      end,
      modes = {
        n = {
          winhl = {
            CursorLine = { bg = "#2a2b3c" },
            CursorLineNr = { fg = "#89b4fa", bg = "#2a2b3c" },
          },
          hl = {
            ReactiveCursor = { bg = "#f5e0dc" },
          },
        },
        i = {
          winhl = {
            CursorLine = { bg = "#1e3a2f" },
            CursorLineNr = { fg = "#a6e3a1", bg = "#1e3a2f" },
          },
          hl = {
            ReactiveCursor = { bg = "#a6e3a1" },
          },
        },
        v = {
          winhl = {
            CursorLine = { bg = "#2d3654" },
            CursorLineNr = { fg = "#89b4fa", bg = "#2d3654" },
          },
          hl = {
            ReactiveCursor = { bg = "#89b4fa" },
          },
        },
        V = {
          winhl = {
            CursorLine = { bg = "#2d3654" },
            CursorLineNr = { fg = "#89b4fa", bg = "#2d3654" },
          },
          hl = {
            ReactiveCursor = { bg = "#89b4fa" },
          },
        },
        ["\x16"] = { -- Visual Block mode
          winhl = {
            CursorLine = { bg = "#2d3654" },
            CursorLineNr = { fg = "#89b4fa", bg = "#2d3654" },
          },
          hl = {
            ReactiveCursor = { bg = "#89b4fa" },
          },
        },
        R = {
          winhl = {
            CursorLine = { bg = "#3d2a2d" },
            CursorLineNr = { fg = "#f38ba8", bg = "#3d2a2d" },
          },
          hl = {
            ReactiveCursor = { bg = "#f38ba8" },
          },
        },
        c = {
          winhl = {
            CursorLine = { bg = "#3d3a2d" },
            CursorLineNr = { fg = "#f9e2af", bg = "#3d3a2d" },
          },
          hl = {
            ReactiveCursor = { bg = "#f9e2af" },
          },
        },
      },
    })
  end,
}
