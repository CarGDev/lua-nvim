-- Core options and settings
local opt = vim.opt
local g = vim.g
local fn = vim.fn

-- Disable deprecated API warnings
vim.deprecate = function() end

-- Set leader key before lazy
g.mapleader = " "
g.maplocalleader = " "

-- General settings
opt.mouse = "a" -- Enable mouse
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.swapfile = false -- Don't create swap files
opt.completeopt = "menuone,noselect" -- Better completion
opt.undofile = true -- Persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Suppress startup messages to avoid "Press ENTER" prompts
opt.shortmess = "aoOtTIcFWS" -- Suppress various messages
opt.cmdheight = 1 -- Set command height to avoid prompts

-- Search settings
opt.ignorecase = true -- Case insensitive search
opt.smartcase = true -- Case sensitive when uppercase
opt.hlsearch = false -- Don't highlight search results
opt.incsearch = true -- Incremental search

-- Indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Number of spaces for indentation
opt.tabstop = 2 -- Number of spaces for tabs
opt.softtabstop = 2 -- Number of spaces for soft tabs
opt.autoindent = true -- Auto indent
opt.smartindent = true -- Smart indent

-- Performance optimizations
opt.updatetime = 100 -- Faster completion (reduced from 250)
opt.timeoutlen = 200 -- Faster key sequence completion (reduced from 300)
opt.redrawtime = 1500 -- Allow more time for loading syntax
opt.synmaxcol = 200 -- Only highlight the first 200 columns (conservative for performance)
opt.maxmempattern = 1000 -- Reduce memory for pattern matching
opt.hidden = true -- Allow switching buffers without saving
opt.scrolljump = 1 -- Minimal number of screen lines to scroll
opt.scrolloff = 3 -- Keep 3 lines above/below cursor (reduced from 8)
opt.sidescrolloff = 3 -- Keep 3 columns left/right of cursor (reduced from 8)

-- Syntax loading optimizations
opt.syntax = "on" -- Enable syntax highlighting
opt.lazyredraw = false -- Don't use lazy redraw (can cause issues)
opt.foldlevel = 99 -- Don't fold by default

-- Filetype plugin optimizations
opt.filetype = "on" -- Enable filetype detection
opt.modeline = false -- Disable modeline for security and performance
opt.modelines = 0 -- Disable modelines

-- Matchparen optimizations
g.matchparen_timeout = 100 -- Reduce from default 300ms
g.matchparen_insert_timeout = 50 -- Reduce from default 100ms
g.matchparen_disable_cursor_hl = 0 -- Keep cursor highlighting but optimize

-- UI settings
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.cursorline = false -- Disable cursor line highlighting for performance
opt.cursorcolumn = false -- Don't highlight current column
opt.signcolumn = "yes" -- Always show sign column

-- =============================================================================
-- NATIVE AUTO WRAPPER CONFIGURATION
-- =============================================================================

-- Text wrapping settings
opt.wrap = true -- Enable visual line wrapping (wraps based on window width)
opt.linebreak = true -- Break lines at word boundaries
opt.breakindent = true -- Preserve indentation in wrapped lines
opt.showbreak = "↪ " -- Show break indicator
opt.breakindentopt = "shift:2" -- Indent wrapped lines by 2 spaces

-- Text width and formatting
opt.textwidth = 0 -- Disable hard wrapping (0 = no limit, wraps based on window width)
opt.colorcolumn = "" -- Disable color column (or set to a high value if you want a guide)
opt.formatoptions = "jcroqln" -- Format options (removed 't' to disable auto-wrap based on textwidth)

-- Format options settings
-- Note: 't' option removed - we want visual wrapping only, not hard line breaks
opt.formatoptions:append("c") -- Auto-wrap comments using textwidth (only applies if textwidth > 0)
opt.formatoptions:append("r") -- Auto-wrap comments when pressing Enter
opt.formatoptions:append("o") -- Auto-wrap comments when pressing 'o' or 'O'
opt.formatoptions:append("q") -- Allow formatting of comments with 'gq'
opt.formatoptions:append("l") -- Long lines are not broken in insert mode
opt.formatoptions:append("n") -- Recognize numbered lists
opt.formatoptions:append("j") -- Remove comment leader when joining lines

-- Scroll settings for wrapped text
opt.showmatch = true -- Show matching brackets
opt.matchtime = 2 -- How long to show matching brackets

-- Folding (indent-based is generally faster than syntax-based)
opt.foldmethod = "indent" -- Fold based on indentation
opt.foldnestmax = 10 -- Maximum nesting level

-- Backup and swap
opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup files while writing
opt.swapfile = false -- Don't create swap files

-- Terminal
opt.termguicolors = true -- Enable true color support
opt.background = "dark" -- Set background to dark

-- File encoding
opt.encoding = "utf-8" -- Set encoding to UTF-8
opt.fileencoding = "utf-8" -- Set file encoding to UTF-8

-- Wildmenu
opt.wildmenu = true -- Enable wildmenu
opt.wildmode = "longest:full,full" -- Wildmenu mode

-- Split behavior
opt.splitbelow = true -- Split below when creating horizontal splits
opt.splitright = true -- Split right when creating vertical splits

-- Conceal
opt.conceallevel = 2 -- Conceal certain characters

-- Provider configurations
g.loaded_perl_provider = 0 -- Disable Perl provider
g.loaded_ruby_provider = 0 -- Disable Ruby provider (optional)

-- Python provider configuration

g.python3_host_prog = fn.expand("~/.local/pipx/venvs/pynvim/bin/python")

-- Clipboard provider optimization (macOS)
g.clipboard = {
  name = "macOS-clipboard",
  copy = {
    ["+"] = "pbcopy",
    ["*"] = "pbcopy",
  },
  paste = {
    ["+"] = "pbpaste",
    ["*"] = "pbpaste",
  },
}

-- Lua specific settings
opt.runtimepath:append(vim.fn.stdpath("config") .. "/lua")

-- Custom file type associations
vim.filetype.add({
  extension = {
    strata = "html",
    sts = "typescript",
  },
})

-- Better diff
opt.diffopt:append("algorithm:patience")
opt.diffopt:append("indent-heuristic")

-- Better grep
opt.grepprg = "rg --vimgrep --smart-case"
opt.grepformat = "%f:%l:%c:%m"

-- Better listchars
opt.list = true
opt.listchars = {
  tab = "▸ ",
  trail = "·",
  extends = "❯",
  precedes = "❮",
  nbsp = "␣",
}

-- Better fillchars
opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}

-- Disable builtin plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

-- =============================================================================
-- OPTIMIZED AUTO WRAPPER AUTOCMDS
-- =============================================================================

-- Consolidated auto-wrapping configuration
-- Note: textwidth is set to 0 globally to allow visual wrapping based on window width
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    local filetype = vim.bo.filetype
    local opt = vim.opt_local
    
    -- Text/documentation files - visual wrapping only (no hard breaks)
    if vim.tbl_contains({ "text", "markdown", "gitcommit", "mail", "help", "man" }, filetype) then
      opt.textwidth = 0 -- Disable hard wrapping, use visual wrapping based on window width
      opt.wrap = true
      opt.linebreak = true
      -- Removed 't' option - we want visual wrapping only, not hard line breaks
    end
    
    -- Code files - visual wrapping only (no hard breaks)
    if vim.tbl_contains({ "lua", "javascript", "typescript", "python", "java", "cpp", "c", "rust", "go" }, filetype) then
      opt.textwidth = 0 -- Disable hard wrapping, use visual wrapping based on window width
      opt.formatoptions:append("c") -- Auto-wrap comments (only if textwidth > 0, so this won't apply)
      opt.formatoptions:append("r") -- Auto-wrap comments with leader
      opt.formatoptions:append("o") -- Auto-wrap comments with 'o'
      opt.formatoptions:append("q") -- Allow formatting of comments with 'gq'
    end
    
    -- Configuration files - visual wrapping only (no hard breaks)
    if vim.tbl_contains({ "conf", "config", "ini", "toml", "yaml", "json" }, filetype) then
      opt.textwidth = 0 -- Disable hard wrapping, use visual wrapping based on window width
      opt.formatoptions:append("c") -- Auto-wrap comments (only if textwidth > 0, so this won't apply)
    end
  end,
})

-- =============================================================================
-- RETURN TO DASHBOARD ON LAST BUFFER CLOSE
-- =============================================================================

-- When closing the last buffer, return to dashboard instead of quitting
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local bufs = vim.tbl_filter(function(b)
      return vim.api.nvim_buf_is_valid(b)
        and vim.bo[b].buflisted
        and vim.api.nvim_buf_get_name(b) ~= ""
    end, vim.api.nvim_list_bufs())

    -- If this is the last listed buffer, open dashboard
    if #bufs <= 1 then
      vim.schedule(function()
        local ok, snacks = pcall(require, "snacks")
        if ok and snacks.dashboard then
          snacks.dashboard()
        end
      end)
    end
  end,
})

-- =============================================================================
-- MODERN UI: GLOBAL ROUNDED BORDERS
-- =============================================================================

-- Rounded border style for all floating windows
local border = "rounded"

-- Override default floating window border
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

-- Diagnostic floating window border
vim.diagnostic.config({
  float = {
    border = border,
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Set global float border highlight
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7aa2f7", bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1a1b26" })

-- Modern cursor line (subtle highlight)
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#292e42" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#7aa2f7", bold = true })

-- =============================================================================
-- WORD COUNTER (EXCLUDING SYMBOLS)
-- =============================================================================

-- Function to count words excluding symbols
local function count_words_no_symbols()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local text = table.concat(lines, " ")
  -- Remove all non-alphanumeric characters except spaces
  local clean_text = text:gsub("[^%w%s]", "")
  -- Count words (sequences of alphanumeric characters)
  local count = 0
  for _ in clean_text:gmatch("%w+") do
    count = count + 1
  end
  return count
end

-- Make it globally accessible for statusline
_G.word_count_no_symbols = count_words_no_symbols

-- Create user command to display word count
vim.api.nvim_create_user_command("WordCount", function()
  local count = count_words_no_symbols()
  vim.notify("Words (excluding symbols): " .. count, vim.log.levels.INFO)
end, { desc = "Count words excluding symbols" })
