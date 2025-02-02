return {
  "ap/vim-buftabline",
  event = "VeryLazy", -- Loads when Neovim starts up
  config = function()
    -- Enable the buffer tabline
    vim.g.buftabline_numbers = 2 -- Shows buffer numbers
    vim.g.buftabline_separators = 1 -- Shows separators between tabs
    vim.g.buftabline_indicators = 1 -- Show indicators for modified buffers
    vim.g.buftabline_show = 1 -- 0: never, 1: always, 2: auto-hide when only one buffer
    vim.g.buftabline_modified_indicator = "[+]" -- Custom indicator for modified buffers
  end,
}
