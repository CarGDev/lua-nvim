local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local fs_stat = (vim.uv or vim.loop).fs_stat
if not fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "cargdev.plugins" }, { import = "cargdev.plugins.lsp" } }, {
  checker = {
    enabled = true,
    notify = false,
    frequency = 86400,
  },
  change_detection = {
    notify = false,
  },
})
