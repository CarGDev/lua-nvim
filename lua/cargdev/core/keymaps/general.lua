-- General keymaps
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- =============================================================================
-- GENERAL KEYMAPS
-- =============================================================================

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General keymaps
keymap.set("i", "jk", "<ESC>", opts) -- Exit insert mode with jk
keymap.set("n", "<leader>nh", ":nohl<CR>", opts) -- Clear search highlights
keymap.set("n", "x", '"_x', opts) -- Delete character without copying into register

-- Save and quit (additional)
keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all" })

-- Put this in your init.lua
local vault_path = "/Users/carlos/Nextcloud/ObsidianVault"

local function follow_obsidian_link()
  -- grab the token under cursor, clean obsidian syntax
  local raw = vim.fn.expand("<cWORD>")
  raw = raw:gsub("^!%[%[", "[[") -- strip leading ! from embeds
  local link = raw:gsub("%[%[", ""):gsub("%]%]", "")

  -- split off alias and heading
  local base, alias = link:match("^(.-)|(.+)$")
  link = base or link
  local fname, heading = link:match("^(.-)#(.+)$")
  link = fname or link

  -- normalize spaces
  link = link:gsub("\\ ", " "):gsub("^%s+", ""):gsub("%s+$", "")

  local function goto_heading(h)
    if not h or h == "" then
      return
    end
    -- crude jump: search for markdown heading or block that contains it
    vim.cmd("keepjumps normal! gg")
    local pat = "^%s*#+%s*" .. vim.pesc(h)
    if vim.fn.search(pat) == 0 then
      -- fallback: plain search
      vim.fn.search(vim.pesc(h))
    end
  end

  -- if link contains a '/', treat it as a relative path inside the vault
  if link:find("/") then
    local target = vault_path .. "/" .. link .. ".md"
    vim.cmd.edit(target)
    goto_heading(heading)
    return
  end

  -- otherwise search recursively for basename match anywhere in the vault
  local pattern = "**/" .. link .. ".md"
  local matches = vim.fn.globpath(vault_path, pattern, false, true) -- list

  if #matches == 1 then
    vim.cmd.edit(matches[1])
    goto_heading(heading)
  elseif #matches > 1 then
    vim.ui.select(matches, { prompt = "Multiple matches for " .. link .. ":" }, function(choice)
      if choice then
        vim.cmd.edit(choice)
        goto_heading(heading)
      end
    end)
  else
    -- not found: offer to create at vault root
    local target = vault_path .. "/" .. link .. ".md"
    vim.ui.input({ prompt = "Create " .. target .. " ? (y/N) " }, function(ans)
      if ans and ans:lower():sub(1, 1) == "y" then
        vim.cmd.edit(target)
        -- optional: insert a title
        if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
          vim.api.nvim_buf_set_lines(0, 0, 0, false, { "# " .. (alias or link), "" })
        end
        goto_heading(heading)
      end
    end)
  end
end

vim.keymap.set("n", "<leader>o", follow_obsidian_link, { noremap = true, silent = true })
