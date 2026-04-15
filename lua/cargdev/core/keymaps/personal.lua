--- Personal keymaps — custom workflow shortcuts.
--- Includes text selection helpers, file management (save, quit, source),
--- number increment/decrement, buffer management with smart close via
--- snacks.bufdelete, coding shortcuts (React import, semicolons, commas,
--- console.log), Copilot Chat commands, clipboard HTML-to-Markdown paste,
--- and quickfix/location list navigation.
--- @module keymaps.personal

local keymap = vim.keymap

-- =============================================================================
-- PERSONAL KEYMAPS (ORIGINAL WORKFLOW)
-- =============================================================================

--- Select the entire file contents (visual mode).
keymap.set("n", "<leader>u", function()
  vim.cmd("normal! ggVG$")
end, { desc = "Select the whole file" })

--- Duplicate the current line below.
keymap.set("n", "<leader>4", function()
  -- Copy current line and paste below
  vim.cmd("normal! yy")
  vim.cmd("normal! p")
end, { desc = "Copy the entire line and paste just below" })

--- File management — save, quit, force quit, source, and clear search.
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save the current file" })
keymap.set("n", "<leader>xa", ":xa<CR>", { desc = "Save and close all the files" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap.set("n", "<leader>vr", ":source %<CR>", { desc = "Vim: Reload current file" })
keymap.set("n", "<leader>no", ":noh <CR>", { desc = "Reset search a word" })

--- Increment/decrement the number under the cursor.
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window management keymaps are centralized in lua/cargdev/core/keymaps/window.lua

--- Re-indent the entire file using Neovim's built-in `=` operator.
keymap.set("n", "<leader>sy", "gg=G<CR>", { desc = "Format current file" })

--- Fast scroll — 10 lines at a time with Ctrl+E / Ctrl+Y.
keymap.set("n", "<C-e>", "10<C-e>", { noremap = true, silent = true })
keymap.set("n", "<C-y>", "10<C-y>", { noremap = true, silent = true })

--- Close the current buffer with a confirmation prompt if modified.
keymap.set("n", "<leader>bd", function()
  if vim.bo.modified then
    vim.ui.select({ "Save & Close", "Discard & Close", "Cancel" }, {
      prompt = "Buffer has unsaved changes:",
    }, function(choice)
      if choice == "Save & Close" then
        vim.cmd("w")
        vim.cmd("bd")
      elseif choice == "Discard & Close" then
        vim.cmd("bd!")
      end
    end)
  else
    vim.cmd("bd")
  end
end, { desc = "Buffer: Close (safe)" })

--- Force close the current buffer, discarding unsaved changes.
keymap.set("n", "<leader>bD", ":db!<CR>", { desc = "Buffer: Force close" })

--- Buftabline navigation — Ctrl+P next buffer, Ctrl+N previous buffer.
keymap.set("n", "<C-p>", ":bnext<CR>", { noremap = true, silent = true })
keymap.set("n", "<C-n>", ":bprev<CR>", { noremap = true, silent = true })

--- Coding shortcuts — React import, trailing comma/semicolon, run with Node.
keymap.set(
  "n",
  "<leader>re",
  "ggOimport<space>React<space>from<space>'react';<esc>0",
  { desc = "Type import react from 'react' at the top of the file" }
)
keymap.set("n", "<leader>,", "$a,<ESC>", { desc = "Adding ',' at the end of the line" })
keymap.set("n", "<leader>;", "$a;<ESC>", { desc = "Adding ';' at the end of the line" })
keymap.set("n", "<leader>xr", ":!node %<CR>", { desc = "Run file with node" })

-- Resize splits keymaps are centralized in lua/cargdev/core/keymaps/window.lua

--- Paste HTML from the system clipboard as GitHub-Flavored Markdown (via pandoc).
--- TODO: Fix this keymap
-- keymap.set("n", "<leader>p", function()
--   vim.cmd("read !pbpaste -Prefer html | pandoc -f html -t gfm")
-- end, { desc = "Paste HTML clipboard as Markdown" })

-- =============================================================================
-- QUICKFIX NAVIGATION (under <leader>x for Trouble/Diagnostics group)
-- =============================================================================

--- Quickfix list navigation — next, previous, open, close, first, last.
keymap.set("n", "<leader>xn", ":cnext<CR>zz", { desc = "Quickfix: Next item" })
keymap.set("n", "<leader>xp", ":cprev<CR>zz", { desc = "Quickfix: Previous item" })
keymap.set("n", "<leader>xo", ":copen<CR>", { desc = "Quickfix: Open list" })
keymap.set("n", "<leader>xQ", ":cclose<CR>", { desc = "Quickfix: Close list" })
keymap.set("n", "<leader>xf", ":cfirst<CR>zz", { desc = "Quickfix: First item" })
keymap.set("n", "<leader>xL", ":clast<CR>zz", { desc = "Quickfix: Last item" })

--- Location list navigation — next, previous, open, close.
keymap.set("n", "<leader>ln", ":lnext<CR>zz", { desc = "Location: Next item" })
keymap.set("n", "<leader>lp", ":lprev<CR>zz", { desc = "Location: Previous item" })
keymap.set("n", "<leader>lL", ":lopen<CR>", { desc = "Location: Open list" })
keymap.set("n", "<leader>lq", ":lclose<CR>", { desc = "Location: Close list" })
