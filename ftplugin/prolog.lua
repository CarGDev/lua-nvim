-- Prolog: load the current file in an swipl toplevel (vertical split terminal)
vim.keymap.set("n", "<leader>pl", function()
  if vim.fn.executable("swipl") == 0 then
    vim.notify("swipl not found: brew install swi-prolog", vim.log.levels.ERROR)
    return
  end
  vim.cmd("write")
  vim.cmd("vsplit | terminal swipl -s " .. vim.fn.shellescape(vim.fn.expand("%:p")))
  vim.cmd("startinsert")
end, { buffer = true, desc = "Prolog: load file in swipl" })

-- Lint the file on demand. Overrides the global <leader>mm (format) in Prolog
-- buffers only; there is no Prolog formatter configured anyway.
vim.keymap.set("n", "<leader>mm", function()
  if vim.fn.executable("swipl") == 0 then
    vim.notify("swipl not found: brew install swi-prolog", vim.log.levels.ERROR)
    return
  end
  vim.cmd("silent! write")
  require("lint").try_lint("swipl")
end, { buffer = true, desc = "Prolog: lint file (swipl)" })
