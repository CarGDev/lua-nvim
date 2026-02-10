--- Terminal toggle utility.
--- Provides a function and keybinding (`<Leader>ter`) to open or close a
--- vertical-split zsh terminal on the right side of the editor. The terminal
--- automatically enters insert mode on focus and exits insert mode on blur.
--- @module openTerminal

vim.g.mapleader = " "

local keymap = vim.keymap
local cmd = vim.cmd
local api = vim.api

--- Toggle a terminal split on the rightmost side of the editor.
--- If the rightmost buffer is already a terminal, it closes it.
--- Otherwise, opens a new vertical split running zsh with line numbers
--- disabled and auto insert-mode behavior on focus/blur.
local function open_terminal()
  -- Move to the rightmost buffer (equivalent to `<C-l>` multiple times)
  cmd("wincmd l")
  cmd("wincmd l")
  cmd("wincmd l")
  cmd("wincmd l")

  -- Get current buffer number and type
  local buf_num = apinvim_get_current_buf()
  local buf_type = apinvim_buf_get_option(buf_num, "buftype")

  if buf_type == "terminal" then
    -- If already in a terminal, close it
    cmd("q")
  else
    -- Open terminal in a vertical split
    cmd("vsp | term zsh")

    -- Disable line numbers in terminal
    cmd("setlocal nonumber norelativenumber")

    -- Auto-start insert mode in terminal
    apinvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
      buffer = 0,
      command = "startinsert!",
    })
    apinvim_create_autocmd("BufLeave", {
      buffer = 0,
      command = "stopinsert!",
    })

    -- Start terminal in insert mode
    cmd("startinsert!")
  end
end

--- Map `<Leader>ter` in normal mode to toggle the terminal split.
keymap.set("n", "<Leader>ter", open_terminal, { noremap = true, silent = true })
