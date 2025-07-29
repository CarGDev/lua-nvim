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

-- Performance
opt.lazyredraw = false -- Don't redraw while executing macros
opt.updatetime = 250 -- Faster completion
opt.timeoutlen = 300 -- Faster key sequence completion

-- UI settings
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.cursorline = true -- Highlight current line
opt.cursorcolumn = false -- Don't highlight current column
opt.signcolumn = "yes" -- Always show sign column
opt.wrap = false -- Don't wrap lines
opt.linebreak = true -- Break lines at word boundaries
opt.scrolloff = 8 -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
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

-- Improve performance for large files
opt.maxmempattern = 2000 -- Increase memory for pattern matching

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
