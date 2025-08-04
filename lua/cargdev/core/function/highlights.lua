-- Highlight .njk files as htmldjango for better templating syntax
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.njk",
  callback = function()
    vim.cmd("set filetype=htmldjango")
  end,
})
