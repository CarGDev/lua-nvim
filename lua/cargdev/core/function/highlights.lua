--- Custom filetype detection for unsupported or ambiguous file extensions.
--- Registers autocmds that assign the correct filetype when buffers are
--- opened, enabling proper syntax highlighting and LSP support.
--- @module highlights

--- Set .njk (Nunjucks) files to use the htmldjango filetype,
--- which provides the closest built-in syntax support for
--- Nunjucks/Jinja-style template syntax (blocks, extends, includes).
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.njk",
  callback = function()
    vim.cmd("set filetype=htmldjango")
  end,
})
