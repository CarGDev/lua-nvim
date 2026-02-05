-- ============================================================================
-- NAVBUDDY: Symbol navigation
-- ============================================================================
-- LSP-powered breadcrumb-style symbol navigator with popup interface.
-- Browse and jump to functions, classes, variables via hierarchical view.
-- Keymap: <leader>nb to open Navbuddy popup. Requires LSP attachment.
-- ============================================================================

return {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>nb", "<cmd>Navbuddy<cr>", desc = "Navbuddy" },
  },
  opts = {
    window = {
      border = "rounded",
      size = "80%",
      position = "50%",
      sections = {
        left = { size = "20%" },
        mid = { size = "40%" },
        right = { preview = "leaf" },
      },
    },
    node_markers = {
      enabled = true,
      icons = {
        leaf = "  ",
        leaf_selected = " → ",
        branch = " ",
      },
    },
    icons = {
      File = "󰈔 ",
      Module = "󰆧 ",
      Namespace = "󰅪 ",
      Package = "󰏗 ",
      Class = " ",
      Method = "󰆧 ",
      Property = " ",
      Field = " ",
      Constructor = " ",
      Enum = " ",
      Interface = " ",
      Function = "󰊕 ",
      Variable = "󰀫 ",
      Constant = "󰏿 ",
      String = "󰉾 ",
      Number = "󰎠 ",
      Boolean = " ",
      Array = "󰅪 ",
      Object = "󰅩 ",
      Key = "󰌋 ",
      Null = "󰟢 ",
      EnumMember = " ",
      Struct = " ",
      Event = " ",
      Operator = "󰆕 ",
      TypeParameter = "󰊄 ",
    },
    use_default_mappings = true,
    lsp = {
      auto_attach = true,
    },
    source_buffer = {
      follow_node = true,
      highlight = true,
      reorient = "smart",
    },
  },
}
