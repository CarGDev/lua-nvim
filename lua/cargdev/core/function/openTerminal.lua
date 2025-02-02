vim.g.mapleader = " "

local keymap = vim.keymap

-- Function to open terminal
local function open_terminal()
  -- Move to the rightmost buffer (equivalent to `<C-l>` multiple times)
  vim.cmd("wincmd l")
  vim.cmd("wincmd l")
  vim.cmd("wincmd l")
  vim.cmd("wincmd l")

  -- Get current buffer number and type
  local buf_num = vim.api.nvim_get_current_buf()
  local buf_type = vim.api.nvim_buf_get_option(buf_num, "buftype")

  if buf_type == "terminal" then
    -- If already in a terminal, close it
    vim.cmd("q")
  else
    -- Open terminal in a vertical split
    vim.cmd("vsp | term zsh")

    -- Disable line numbers in terminal
    vim.cmd("setlocal nonumber norelativenumber")

    -- Auto-start insert mode in terminal
    vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
      buffer = 0,
      command = "startinsert!",
    })
    vim.api.nvim_create_autocmd("BufLeave", {
      buffer = 0,
      command = "stopinsert!",
    })

    -- Terminal key mappings
    vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { buffer = true })
    vim.keymap.set("t", "<C-t>", "<C-\\><C-n>:q<CR>", { buffer = true })
    vim.keymap.set("t", "<C-\\><C-\\>", "<C-\\><C-n>", { buffer = true })

    -- Start terminal in insert mode
    vim.cmd("startinsert!")
  end
end

-- Keybinding to open terminal
keymap.set("n", "<Leader>ter", open_terminal, { noremap = true, silent = true })
