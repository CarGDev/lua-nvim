-- ============================================================================
-- TINY-INLINE-DIAGNOSTIC: Pretty inline diagnostic messages
-- ============================================================================
-- Replaces default virtual text diagnostics with prettier inline messages.
-- Shows errors/warnings with icons and better formatting. Disables default
-- diagnostic virtual_text. Has DiagnosticChanged autocmd to update display.
-- ============================================================================
return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  priority = 1000,
  config = function()
    -- Disable default diagnostics virtual text and auto float
    vim.diagnostic.config({
      virtual_text = false,
      float = false, -- Disable automatic float, use manual <leader>sl instead
      signs = true,
      underline = true,
      update_in_insert = false,
    })

    require("tiny-inline-diagnostic").setup({
      signs = {
        left = "",
        right = "",
        diag = "●",
        arrow = "    ",
        up_arrow = "    ",
        vertical = " │",
        vertical_end = " └",
      },
      hi = {
        error = "DiagnosticError",
        warn = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint",
        arrow = "NonText",
        background = "CursorLine",
        mixing_color = "None",
      },
      blend = {
        factor = 0.22,
      },
      options = {
        show_source = true,
        throttle = 20,
        softwrap = 30,
        multiple_diag_under_cursor = true,
        multilines = true,
        show_all_diags_on_cursorline = false,
        enable_on_insert = false,
        overflow = {
          mode = "wrap",
        },
        format = nil,
        break_line = {
          enabled = false,
          after = 30,
        },
        virt_texts = {
          priority = 2048,
        },
      },
    })
  end,
}
