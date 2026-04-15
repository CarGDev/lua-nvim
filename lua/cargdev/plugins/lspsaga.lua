-- ============================================================================
-- LSPSAGA: Enhanced LSP UI with floating windows
-- ============================================================================
-- Beautiful UI for LSP features: code actions, hover docs, rename, outline,
-- diagnostics, call hierarchy. Provides better UX than default LSP handlers.
-- Has DiagnosticChanged autocmd to update virtual text on diagnostic changes.
-- ============================================================================
return {
  "nvimdev/lspsaga.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  event = "LspAttach",
  opts = {
    ui = {
      border = "rounded",
      devicon = true,
      title = true,
      expand = "",
      collapse = "",
      code_action = "💡",
      actionfix = " ",
      lines = { "┗", "┣", "┃", "━", "┏" },
      kind = nil,
      imp_sign = "󰳛 ",
    },
    hover = {
      max_width = 0.9,
      max_height = 0.8,
      open_link = "gx",
      open_cmd = "!open",
    },
    diagnostic = {
      show_code_action = false,
      show_layout = "float",
      show_normal_height = 10,
      jump_num_shortcut = true,
      max_width = 0.8,
      max_height = 0.6,
      max_show_width = 0.9,
      max_show_height = 0.6,
      text_hl_follow = false,
      border_follow = true,
      extend_relatedInformation = false,
      diagnostic_only_current = true,
      keys = {
        exec_action = "o",
        quit = "q",
        toggle_or_jump = "<CR>",
        quit_in_show = { "q", "<ESC>" },
      },
    },
    code_action = {
      num_shortcut = true,
      show_server_name = true,
      extend_gitsigns = true,
      only_in_cursor = true,
      max_height = 0.3,
      keys = {
        quit = "q",
        exec = "<CR>",
      },
    },
    lightbulb = {
      enable = false, -- Using nvim-lightbulb instead
      sign = false,
      virtual_text = false,
    },
    scroll_preview = {
      scroll_down = "<C-f>",
      scroll_up = "<C-b>",
    },
    finder = {
      max_height = 0.5,
      left_width = 0.3,
      right_width = 0.5,
      methods = {},
      default = "ref+imp",
      layout = "float",
      silent = false,
      filter = {},
      keys = {
        shuttle = "[w",
        toggle_or_open = "o",
        vsplit = "s",
        split = "i",
        tabe = "t",
        tabnew = "r",
        quit = "q",
        close = "<C-c>",
      },
    },
    definition = {
      width = 0.6,
      height = 0.5,
      keys = {
        edit = "<C-c>o",
        vsplit = "<C-c>v",
        split = "<C-c>i",
        tabe = "<C-c>t",
        quit = "q",
        close = "<C-c>",
      },
    },
    rename = {
      in_select = true,
      auto_save = false,
      project_max_width = 0.5,
      project_max_height = 0.5,
      keys = {
        quit = "<C-c>",
        exec = "<CR>",
        select = "x",
      },
    },
    symbol_in_winbar = {
      enable = false, -- Using dropbar instead
      separator = " › ",
      hide_keyword = true,
      show_file = true,
      folder_level = 1,
      color_mode = true,
    },
    callhierarchy = {
      layout = "float",
      keys = {
        edit = "e",
        vsplit = "s",
        split = "i",
        tabe = "t",
        quit = "q",
        shuttle = "[w",
        toggle_or_req = "u",
        close = "<C-c>",
      },
    },
    implement = {
      enable = true,
      sign = true,
      virtual_text = true,
    },
    beacon = {
      enable = true,
      frequency = 7,
    },
  },
  keys = {
    { "gh", "<cmd>Lspsaga finder<cr>", desc = "LSP Finder" },
    { "<leader>la", "<cmd>Lspsaga code_action<cr>", mode = { "n", "v" }, desc = "LSP: Code action (saga)" },
    { "gr", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
    { "gR", "<cmd>Lspsaga rename ++project<cr>", desc = "Rename (project)" },
    { "gd", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek definition" },
    { "gD", "<cmd>Lspsaga goto_definition<cr>", desc = "Goto definition" },
    { "gt", "<cmd>Lspsaga peek_type_definition<cr>", desc = "Peek type definition" },
    { "gT", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Goto type definition" },
    -- Line diagnostics handled by native <leader>dd (vim.diagnostic.open_float)
    { "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", desc = "Cursor diagnostics" },
    { "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<cr>", desc = "Buffer diagnostics" },
    { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Prev diagnostic" },
    { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Next diagnostic" },
    { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover doc" },
    { "<leader>li", "<cmd>Lspsaga incoming_calls<cr>", desc = "LSP: Incoming calls" },
    { "<leader>lo", "<cmd>Lspsaga outgoing_calls<cr>", desc = "LSP: Outgoing calls" },
  },
}
