-- Core options and settings
local opt = vim.opt
local g = vim.g

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
opt.lazyredraw = true -- Don't redraw while executing macros
opt.updatetime = 100 -- Faster completion (reduced from 250)
opt.timeoutlen = 200 -- Faster key sequence completion (reduced from 300)
opt.redrawtime = 1500 -- Allow more time for loading syntax
opt.synmaxcol = 240 -- Only highlight the first 240 columns
opt.maxmempattern = 1000 -- Reduce memory for pattern matching
opt.hidden = true -- Allow switching buffers without saving
opt.scrolljump = 1 -- Minimal number of screen lines to scroll
opt.scrolloff = 3 -- Keep 3 lines above/below cursor (reduced from 8)
opt.sidescrolloff = 3 -- Keep 3 columns left/right of cursor (reduced from 8)

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
opt.wrap = true -- Enable line wrapping
opt.linebreak = true -- Break lines at word boundaries
opt.breakindent = true -- Preserve indentation in wrapped lines
opt.showbreak = "↪ " -- Show break indicator
opt.breakindentopt = "shift:2" -- Indent wrapped lines by 2 spaces

-- Text width and formatting
opt.textwidth = 80 -- Set text width for auto-wrapping
opt.colorcolumn = "80" -- Show column at 80 characters
opt.formatoptions = "jcroqlnt" -- Format options for auto-wrapping

-- Auto-wrap specific settings
opt.formatoptions:append("t") -- Auto-wrap text using textwidth
opt.formatoptions:append("c") -- Auto-wrap comments using textwidth
opt.formatoptions:append("r") -- Auto-wrap comments when pressing Enter
opt.formatoptions:append("o") -- Auto-wrap comments when pressing 'o' or 'O'
opt.formatoptions:append("q") -- Allow formatting of comments with 'gq'
opt.formatoptions:append("l") -- Long lines are not broken in insert mode
opt.formatoptions:append("n") -- Recognize numbered lists
opt.formatoptions:append("j") -- Remove comment leader when joining lines

-- Scroll settings for wrapped text
opt.showmatch = true -- Show matching brackets
opt.matchtime = 2 -- How long to show matching brackets

-- Folding
opt.foldmethod = "indent" -- Fold based on indentation
opt.foldlevel = 99 -- Don't fold by default
opt.foldnestmax = 10 -- Maximum nesting level

-- Backup and swap
opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup files while writing
opt.swapfile = false -- Don't create swap files

-- Terminal
opt.termguicolors = true -- Enable true color support

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

-- Disable providers that cause warnings
g.loaded_perl_provider = 0 -- Disable Perl provider
g.loaded_ruby_provider = 0 -- Disable Ruby provider (optional)

-- Lua specific settings
opt.runtimepath:append(vim.fn.stdpath("config") .. "/lua")

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
-- AUTO WRAPPER AUTOCMDS
-- =============================================================================

-- Set up auto-wrapping for different file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "markdown", "gitcommit", "mail" },
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.formatoptions:append("t") -- Auto-wrap text
  end,
})

-- Set up auto-wrapping for code files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "javascript", "typescript", "python", "java", "cpp", "c", "rust", "go" },
  callback = function()
    vim.opt_local.textwidth = 100 -- Longer lines for code
    vim.opt_local.formatoptions:append("c") -- Auto-wrap comments
    vim.opt_local.formatoptions:append("r") -- Auto-wrap comments with leader
    vim.opt_local.formatoptions:append("o") -- Auto-wrap comments with 'o'
    vim.opt_local.formatoptions:append("q") -- Allow formatting of comments with 'gq'
  end,
})

-- Set up auto-wrapping for documentation files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man" },
  callback = function()
    vim.opt_local.textwidth = 78
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.formatoptions:append("t") -- Auto-wrap text
  end,
})

-- Set up auto-wrapping for configuration files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "conf", "config", "ini", "toml", "yaml", "json" },
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.formatoptions:append("c") -- Auto-wrap comments
  end,
})
