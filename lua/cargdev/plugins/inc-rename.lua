return {
  "smjonas/inc-rename.nvim",
  cmd = "IncRename",
  keys = {
    {
      "<leader>rn",
      function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end,
      expr = true,
      desc = "Incremental rename",
    },
  },
  opts = {
    cmd_name = "IncRename",
    hl_group = "Substitute",
    preview_empty_name = false,
    show_message = true,
    save_in_cmdline_history = true,
    input_buffer_type = nil,
    post_hook = nil,
  },
}
