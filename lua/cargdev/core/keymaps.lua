vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>u", "gg0vG$", { desc = "Select the whole file open" })
keymap.set("n", "<leader>4", "0v$hy<Esc>0o<Esc>0p0kw<CR>", { desc = "Copy the entire line and paste just below" })

-- file management
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save the current file" })
keymap.set("n", "<leader>xa", ":xa<CR>", { desc = "Save and close all the files" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Close all the files" })
keymap.set("n", "<leader>so", ":source %<CR>", { desc = "Reload nvim" })
keymap.set("n", "<leader>no", ":noh <CR>", { desc = "Reset search a word" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) -- go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- sintax fixer
keymap.set("n", "<leader>sy", "gg=G<CR>", { desc = "Format current file" })

keymap.set("n", "<C-e>", "10<C-e>", { noremap = true, silent = true })
keymap.set("n", "<C-y>", "10<C-y>", { noremap = true, silent = true })

-- close current file on buffer
keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Close current file on buffer" })

-- Set buftabline mappings
keymap.set("n", "<C-p>", ":bnext<CR>", { noremap = true, silent = true })
keymap.set("n", "<C-n>", ":bprev<CR>", { noremap = true, silent = true })

-- Coding hacks
keymap.set(
  "n",
  "<leader>re",
  "ggOimport<space>React<space>from<space>'react';<esc>0",
  { desc = "Type import react from 'react' at the top of the file" }
)
keymap.set("n", "<leader>,", "$a,<ESC>", { desc = "Adding ',' at the end of the line" })
keymap.set("n", "<leader>;", "$a;<ESC>", { desc = "Adding ';' at the end of the line" })
keymap.set("n", "<leader>con", "oconsole.log()<ESC>0w$h", { desc = "Adding console.log() on the line below" })
keymap.set("n", "<leader>x", ":!node %<CR>", { desc = "Running current project using node" })

-- Move between Tmux and Neovim splits using Alt + Arrow keys
-- keymap.set("n", "<A-h>", ":TmuxNavigateLeft<CR>", { noremap = true, silent = true })
-- keymap.set("n", "<A-j>", ":TmuxNavigateDown<CR>", { noremap = true, silent = true })
-- keymap.set("n", "<A-k>", ":TmuxNavigateUp<CR>", { noremap = true, silent = true })
-- keymap.set("n", "<A-l>", ":TmuxNavigateRight<CR>", { noremap = true, silent = true })
