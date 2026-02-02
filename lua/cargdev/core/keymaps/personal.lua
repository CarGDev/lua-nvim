-- Personal keymaps (original workflow)
local keymap = vim.keymap

-- =============================================================================
-- PERSONAL KEYMAPS (ORIGINAL WORKFLOW)
-- =============================================================================

keymap.set("n", "<leader>u", function()
  vim.cmd("normal! ggVG$")
end, { desc = "Select the whole file" })
keymap.set("n", "<leader>4", function()
  -- Copy current line and paste below
  vim.cmd("normal! yy")
  vim.cmd("normal! p")
end, { desc = "Copy the entire line and paste just below" })

-- file management
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save the current file" })
keymap.set("n", "<leader>xa", ":xa<CR>", { desc = "Save and close all the files" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Close all the files" })
keymap.set("n", "<leader>so", ":source %<CR>", { desc = "Reload nvim" })
keymap.set("n", "<leader>no", ":noh <CR>", { desc = "Reset search a word" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- Window management keymaps are centralized in lua/cargdev/core/keymaps/window.lua

-- sintax fixer
keymap.set("n", "<leader>sy", "gg=G<CR>", { desc = "Format current file" })

keymap.set("n", "<C-e>", "10<C-e>", { noremap = true, silent = true })
keymap.set("n", "<C-y>", "10<C-y>", { noremap = true, silent = true })

-- Buffer management with safe close (confirms if unsaved changes)
-- Closes only the current buffer, switches to another buffer instead of quitting
local function close_buffer(force)
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted
  end, vim.api.nvim_list_bufs())

  if #buffers > 1 then
    -- Switch to previous buffer before closing
    vim.cmd("bprevious")
    if force then
      vim.cmd("bdelete! " .. current_buf)
    else
      vim.cmd("bdelete " .. current_buf)
    end
  else
    -- Last buffer: quit Neovim
    vim.cmd(force and "q!" or "q")
  end
end

keymap.set("n", "<leader>bd", function()
  if vim.bo.modified then
    vim.ui.select({ "Save & Close", "Discard & Close", "Cancel" }, {
      prompt = "Buffer has unsaved changes:",
    }, function(choice)
      if choice == "Save & Close" then
        vim.cmd("w")
        close_buffer(false)
      elseif choice == "Discard & Close" then
        close_buffer(true)
      end
    end)
  else
    close_buffer(false)
  end
end, { desc = "Buffer: Close (safe)" })

-- Force close buffer without confirmation
keymap.set("n", "<leader>bD", function()
  close_buffer(true)
end, { desc = "Buffer: Force close" })

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
keymap.set("n", "<leader>xr", ":!node %<CR>", { desc = "Run file with node" })

-- Resize splits keymaps are centralized in lua/cargdev/core/keymaps/window.lua

-- Run and Debug Project
keymap.set("n", "<leader>pr", ":RunProject<CR>", { desc = "Run Project" })
keymap.set("n", "<leader>pd", ":DebugProject<CR>", { desc = "Debug Project" })

-- Copilot Chat (all Copilot keymaps moved to lua/cargdev/core/keymaps/copilot.lua)
keymap.set("v", "<leader>zn", ":CopilotChatRename<CR>", { desc = "Rename variable (Copilot Chat)" })
keymap.set("n", "<leader>zc", ":CopilotChat<CR>", { desc = "Open Copilot Chat" })
keymap.set("v", "<leader>ze", ":CopilotChatExplain<CR>", { desc = "Explain code (Copilot Chat)" })
keymap.set("v", "<leader>zr", ":CopilotChatReview<CR>", { desc = "Review code (Copilot Chat)" })
keymap.set("v", "<leader>zf", ":CopilotChatFix<CR>", { desc = "Fix code issues (Copilot Chat)" })
keymap.set("v", "<leader>zo", ":CopilotChatOptimize<CR>", { desc = "Optimize code (Copilot Chat)" })
keymap.set("v", "<leader>zd", ":CopilotChatDocs<CR>", { desc = "Generate docs (Copilot Chat)" })

-- Paste HTML as Markdown using pandoc
keymap.set("n", "<leader>p", function()
  vim.cmd("read !pbpaste -Prefer html | pandoc -f html -t gfm")
end, { desc = "Paste HTML clipboard as Markdown" })

-- =============================================================================
-- QUICKFIX NAVIGATION (under <leader>x for Trouble/Diagnostics group)
-- =============================================================================

keymap.set("n", "<leader>xn", ":cnext<CR>zz", { desc = "Quickfix: Next item" })
keymap.set("n", "<leader>xp", ":cprev<CR>zz", { desc = "Quickfix: Previous item" })
keymap.set("n", "<leader>xo", ":copen<CR>", { desc = "Quickfix: Open list" })
keymap.set("n", "<leader>xq", ":cclose<CR>", { desc = "Quickfix: Close list" })
keymap.set("n", "<leader>xf", ":cfirst<CR>zz", { desc = "Quickfix: First item" })
keymap.set("n", "<leader>xl", ":clast<CR>zz", { desc = "Quickfix: Last item" })

-- Location list navigation
keymap.set("n", "<leader>ln", ":lnext<CR>zz", { desc = "Location: Next item" })
keymap.set("n", "<leader>lp", ":lprev<CR>zz", { desc = "Location: Previous item" })
keymap.set("n", "<leader>lo", ":lopen<CR>", { desc = "Location: Open list" })
keymap.set("n", "<leader>lq", ":lclose<CR>", { desc = "Location: Close list" })
