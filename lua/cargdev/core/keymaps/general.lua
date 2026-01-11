-- General keymaps
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- =============================================================================
-- GENERAL KEYMAPS
-- =============================================================================

-- General keymaps
-- Changed from "jk" to "jj" to avoid conflicts when typing words containing 'j' followed by other letters
-- "jj" is much less likely to appear in normal typing and won't interfere
keymap.set("i", "jj", "<ESC>", opts) -- Exit insert mode with jj
keymap.set("n", "<leader>nh", ":nohl<CR>", opts) -- Clear search highlights

-- Save and quit (additional)
keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all" })

-- Obsidian vault path with validation
local vault_path = vim.env.IDEA_DIR
if not vault_path or vault_path == "" then
  -- Silently skip Obsidian link setup if IDEA_DIR is not configured
  return
end



local function follow_obsidian_link()
  -- Extract the full [[...]] link from the current line under/around the cursor
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.')
  local start_idx, end_idx, raw
  -- Search for all [[...]] in the line, pick the one under/around the cursor
  local i = 1
  while true do
    local s, e = line:find('%[%[.-%]%]', i)
    if not s then break end
    if col >= s and col <= e + 1 then
      start_idx, end_idx = s, e
      break
    end
    i = e + 1
  end
  if not start_idx then
    vim.notify('No [[link]] under cursor', vim.log.levels.WARN)
    return
  end
  raw = line:sub(start_idx, end_idx)
  raw = raw:gsub('^!%[%[', '[[') -- strip leading ! from embeds
  local link = raw:gsub('%[%[', ''):gsub('%]%]', '')

  -- split off alias (|) and heading (#) only after extracting the full link
  local alias
  local heading
  -- first, split off alias if present
  local pipe_idx = link:find("|", 1, true)
  if pipe_idx then
    alias = link:sub(pipe_idx + 1)
    link = link:sub(1, pipe_idx - 1)
  end
  -- then, split off heading if present
  local hash_idx = link:find("#", 1, true)
  if hash_idx then
    heading = link:sub(hash_idx + 1)
    link = link:sub(1, hash_idx - 1)
  end

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
