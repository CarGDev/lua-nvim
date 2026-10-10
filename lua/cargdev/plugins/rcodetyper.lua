local dir = vim.fn.expand("~/Documents/projects/nvim.plugins/codetyper/rcodetyper.nvim")

return {
  dir = dir,
  name = "rcodetyper.nvim",
  lazy = false,
  build = "make build",
  config = function()
    package.cpath = package.cpath .. ";" .. dir .. "/lua/?.so"
    local ok, rcodetyper = pcall(require, "rcodetyper")
    if not ok then
      vim.notify("rcodetyper: " .. tostring(rcodetyper), vim.log.levels.ERROR)
      return
    end
    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function()
        vim.schedule(function()
          rcodetyper.hello()
        end)
      end,
    })
  end,
}
