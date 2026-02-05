-- ============================================================================
-- BUFFERLINE: Tab-like buffer management in the top bar
-- ============================================================================
-- Displays open buffers as tabs at the top of the screen. Provides visual
-- buffer switching, close buttons, and LSP diagnostics indicators per buffer.
-- Uses snacks.bufdelete for smart buffer closing that shows dashboard on last.
-- ============================================================================
return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  event = "VeryLazy",
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        mode = "buffers",
        style_preset = bufferline.style_preset.minimal,
        themable = true,
        numbers = "none",
        close_command = function(bufnr)
          require("snacks").bufdelete({ buf = bufnr, force = true })
        end,
        right_mouse_command = function(bufnr)
          require("snacks").bufdelete({ buf = bufnr, force = true })
        end,
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
          icon = "▎",
          style = "icon",
        },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 30,
        max_prefix_length = 30,
        truncate_names = true,
        tab_size = 21,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, _, _)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        offsets = {
          {
            filetype = "NvimTree",
            text = " File Explorer",
            text_align = "center",
            separator = true,
            highlight = "Directory",
          },
        },
      },
      highlights = {
        fill = {
          bg = "#16161e",
        },
        background = {
          fg = "#565f89",
          bg = "#16161e",
        },
        tab = {
          fg = "#565f89",
          bg = "#16161e",
        },
        tab_selected = {
          fg = "#c0caf5",
          bg = "#1f2a48",
        },
        tab_separator = {
          fg = "#16161e",
          bg = "#16161e",
        },
        tab_separator_selected = {
          fg = "#1f2a48",
          bg = "#1f2a48",
        },
        buffer_visible = {
          fg = "#565f89",
          bg = "#16161e",
        },
        buffer_selected = {
          fg = "#c0caf5",
          bg = "#1f2a48",
          bold = true,
          italic = false,
        },
        numbers = {
          fg = "#565f89",
          bg = "#16161e",
        },
        numbers_visible = {
          fg = "#565f89",
          bg = "#16161e",
        },
        numbers_selected = {
          fg = "#c0caf5",
          bg = "#1f2a48",
          bold = true,
          italic = false,
        },
        diagnostic = {
          fg = "#565f89",
          bg = "#16161e",
        },
        diagnostic_visible = {
          fg = "#565f89",
          bg = "#16161e",
        },
        diagnostic_selected = {
          fg = "#c0caf5",
          bg = "#1f2a48",
          bold = true,
          italic = false,
        },
        hint = {
          fg = "#1abc9c",
          bg = "#16161e",
        },
        hint_visible = {
          fg = "#1abc9c",
          bg = "#16161e",
        },
        hint_selected = {
          fg = "#1abc9c",
          bg = "#1f2a48",
          bold = true,
          italic = false,
        },
        hint_diagnostic = {
          fg = "#1abc9c",
          bg = "#16161e",
        },
        hint_diagnostic_visible = {
          fg = "#1abc9c",
          bg = "#16161e",
        },
        hint_diagnostic_selected = {
          fg = "#1abc9c",
          bg = "#1f2a48",
          bold = true,
          italic = false,
        },
        info = {
          fg = "#0db9d7",
          bg = "#16161e",
        },
        info_visible = {
          fg = "#0db9d7",
          bg = "#16161e",
        },
        info_selected = {
          fg = "#0db9d7",
          bg = "#1f2a48",
          bold = true,
          italic = false,
        },
        info_diagnostic = {
          fg = "#0db9d7",
          bg = "#16161e",
        },
        info_diagnostic_visible = {
          fg = "#0db9d7",
          bg = "#16161e",
        },
        info_diagnostic_selected = {
          fg = "#0db9d7",
          bg = "#1f2a48",
          bold = true,
          italic = false,
        },
        warning = {
          fg = "#e0af68",
          bg = "#16161e",
        },
        warning_visible = {
          fg = "#e0af68",
          bg = "#16161e",
        },
        warning_selected = {
          fg = "#e0af68",
          bg = "#1f2a48",
          bold = true,
          italic = false,
        },
        warning_diagnostic = {
          fg = "#e0af68",
          bg = "#16161e",
        },
        warning_diagnostic_visible = {
          fg = "#e0af68",
          bg = "#16161e",
        },
        warning_diagnostic_selected = {
          fg = "#e0af68",
          bg = "#1f2a48",
          bold = true,
          italic = false,
        },
        error = {
          fg = "#f7768e",
          bg = "#16161e",
        },
        error_visible = {
          fg = "#f7768e",
          bg = "#16161e",
        },
        error_selected = {
          fg = "#f7768e",
          bg = "#1f2a48",
          bold = true,
          italic = false,
        },
        error_diagnostic = {
          fg = "#f7768e",
          bg = "#16161e",
        },
        error_diagnostic_visible = {
          fg = "#f7768e",
          bg = "#16161e",
        },
        error_diagnostic_selected = {
          fg = "#f7768e",
          bg = "#1f2a48",
          bold = true,
          italic = false,
        },
        modified = {
          fg = "#e0af68",
          bg = "#16161e",
        },
        modified_visible = {
          fg = "#e0af68",
          bg = "#16161e",
        },
        modified_selected = {
          fg = "#e0af68",
          bg = "#1f2a48",
        },
        duplicate_selected = {
          fg = "#c0caf5",
          bg = "#1f2a48",
          italic = true,
        },
        duplicate_visible = {
          fg = "#565f89",
          bg = "#16161e",
          italic = true,
        },
        duplicate = {
          fg = "#565f89",
          bg = "#16161e",
          italic = true,
        },
        separator_selected = {
          fg = "#16161e",
          bg = "#1f2a48",
        },
        separator_visible = {
          fg = "#16161e",
          bg = "#16161e",
        },
        separator = {
          fg = "#16161e",
          bg = "#16161e",
        },
        indicator_selected = {
          fg = "#7aa2f7",
          bg = "#1f2a48",
        },
        indicator_visible = {
          fg = "#16161e",
          bg = "#16161e",
        },
        pick_selected = {
          fg = "#f7768e",
          bg = "#1f2a48",
          bold = true,
          italic = false,
        },
        pick_visible = {
          fg = "#f7768e",
          bg = "#16161e",
          bold = true,
          italic = false,
        },
        pick = {
          fg = "#f7768e",
          bg = "#16161e",
          bold = true,
          italic = false,
        },
        offset_separator = {
          fg = "#16161e",
          bg = "#16161e",
        },
        trunc_marker = {
          fg = "#565f89",
          bg = "#16161e",
        },
      },
    })
  end,
}
