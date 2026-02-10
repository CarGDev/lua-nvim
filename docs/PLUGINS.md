# Plugins Reference

Complete list of all plugins in this configuration.

## Navigation & Search

| Plugin | Description |
|--------|-------------|
| `nvim-telescope/telescope.nvim` | Fuzzy finder for files, text, buffers |
| `folke/flash.nvim` | Jump anywhere with minimal keystrokes |
| `ThePrimeagen/harpoon` | Quick file marks and navigation |
| `cbochs/portal.nvim` | Navigate jumplist/changelist with preview |
| `SmiteshP/nvim-navbuddy` | Code structure navigation popup |
| `SmiteshP/nvim-navic` | Breadcrumb provider for navbuddy |

## File Management

| Plugin | Description |
|--------|-------------|
| `nvim-tree/nvim-tree.lua` | File explorer sidebar |
| `nvim-tree/nvim-web-devicons` | File icons |

## Git

| Plugin | Description |
|--------|-------------|
| `kdheepak/lazygit.nvim` | LazyGit integration |
| `NeogitOrg/neogit` | Magit-like git interface |
| `sindrets/diffview.nvim` | Side-by-side diff viewer |
| `lewis6991/gitsigns.nvim` | Git signs in gutter |
| `f-person/git-blame.nvim` | Inline git blame |
| `pwntester/octo.nvim` | GitHub issues/PRs in Neovim |

## LSP & Code Intelligence

| Plugin | Description |
|--------|-------------|
| `neovim/nvim-lspconfig` | LSP configuration |
| `williamboman/mason.nvim` | LSP server installer |
| `williamboman/mason-lspconfig.nvim` | Mason + lspconfig bridge |
| `nvimdev/lspsaga.nvim` | Pretty LSP UI |
| `hrsh7th/nvim-cmp` | Completion engine |
| `hrsh7th/cmp-nvim-lsp` | LSP completion source |
| `hrsh7th/cmp-buffer` | Buffer completion source |
| `hrsh7th/cmp-path` | Path completion source |
| `hedyhli/outline.nvim` | Symbol outline sidebar |
| `smjonas/inc-rename.nvim` | Live rename preview |
| `kosayoda/nvim-lightbulb` | Code action indicator |
| `rachartier/tiny-inline-diagnostic.nvim` | Pretty inline diagnostics |
| `folke/trouble.nvim` | Diagnostics list |
| `pmizio/typescript-tools.nvim` | Enhanced TypeScript support |

## Treesitter

| Plugin | Description |
|--------|-------------|
| `nvim-treesitter/nvim-treesitter` | Syntax highlighting |
| `nvim-treesitter/nvim-treesitter-context` | Sticky function headers |
| `nvim-treesitter/nvim-treesitter-textobjects` | Text objects |
| `folke/ts-comments.nvim` | Better comments for embedded languages |
| `windwp/nvim-ts-autotag` | Auto close/rename HTML tags |

## Editing

| Plugin | Description |
|--------|-------------|
| `mg979/vim-visual-multi` | Multi-cursor editing |
| `gbprod/yanky.nvim` | Yank ring with history |
| `Wansmer/treesj` | Split/join code blocks |
| `monaqa/dial.nvim` | Smart increment/decrement |
| `kylechui/nvim-surround` | Surround text objects |
| `windwp/nvim-autopairs` | Auto close brackets |
| `numToStr/Comment.nvim` | Commenting |
| `folke/todo-comments.nvim` | Highlight TODOs |
| `gbprod/substitute.nvim` | Substitute operator |
| `mbbill/undotree` | Visual undo history |
| `chentoast/marks.nvim` | Better marks |
| `kevinhwang91/nvim-ufo` | Better folding |

## Search & Replace

| Plugin | Description |
|--------|-------------|
| `MagicDuck/grug-far.nvim` | Project-wide search & replace |
| `cshuaimin/ssr.nvim` | Structural search/replace |

## Debugging

| Plugin | Description |
|--------|-------------|
| `mfussenegger/nvim-dap` | Debug Adapter Protocol |
| `rcarriga/nvim-dap-ui` | Debug UI |
| `nvim-neotest/nvim-nio` | Async IO for dap-ui |
| `theHamsta/nvim-dap-virtual-text` | Virtual text for debugging |
| `mfussenegger/nvim-dap-python` | Python debugging |
| `jay-babu/mason-nvim-dap.nvim` | Mason + DAP bridge |
| `Weissle/persistent-breakpoints.nvim` | Save breakpoints |

## Tasks & HTTP

| Plugin | Description |
|--------|-------------|
| `stevearc/overseer.nvim` | Task runner |
| `mistweaverco/kulala.nvim` | HTTP client |

## UI & Theme

| Plugin | Description |
|--------|-------------|
| `CarGDev/cargdev-cyberpunk` | Custom cyberpunk theme |
| `folke/snacks.nvim` | Dashboard, notifier, picker, terminal |
| `folke/noice.nvim` | UI for messages, cmdline, popups |
| `nvim-lualine/lualine.nvim` | Statusline |
| `akinsho/bufferline.nvim` | Buffer tabs |
| `Bekaboo/dropbar.nvim` | VS Code-like breadcrumbs |
| `lewis6991/satellite.nvim` | Scrollbar with markers |
| `folke/which-key.nvim` | Keybinding hints |
| `stevearc/dressing.nvim` | Better vim.ui |
| `rcarriga/nvim-notify` | Notification manager |
| `j-hui/fidget.nvim` | LSP progress |
| `folke/edgy.nvim` | Window layout management |

## Eye Candy

| Plugin | Description |
|--------|-------------|
| `echasnovski/mini.animate` | Smooth animations |
| `rasulomaroff/reactive.nvim` | Mode-based colors |
| `mawkler/modicator.nvim` | Line number mode colors |
| `shellRaining/hlchunk.nvim` | Scope highlighting |
| `nvim-zh/colorful-winsep.nvim` | Colorful window separators |
| `brenoprata10/nvim-highlight-colors` | Color preview |
| `lukas-reineke/indent-blankline.nvim` | Indent guides |
| `xiyaowong/transparent.nvim` | Transparent background |

## Productivity

| Plugin | Description |
|--------|-------------|
| `folke/zen-mode.nvim` | Distraction-free mode |
| `folke/twilight.nvim` | Dim inactive code |
| `folke/persistence.nvim` | Session management |
| `rmagatti/auto-session` | Auto session restore |
| `m4xshen/hardtime.nvim` | Vim motion training |
| `tris203/precognition.nvim` | Vim motion hints |
| `NStefan002/screenkey.nvim` | Show keypresses |
| `bennypowers/nvim-regexplainer` | Regex explanation |

## Language Specific

| Plugin | Description |
|--------|-------------|
| `linux-cultist/venv-selector.nvim` | Python venv selector |
| `vuki656/package-info.nvim` | NPM package versions |
| `saecki/crates.nvim` | Rust crate versions |
| `mfussenegger/nvim-jdtls` | Java LSP + debugging |
| `akinsho/flutter-tools.nvim` | Flutter development |
| `lervag/vimtex` | LaTeX support |

## Database

| Plugin | Description |
|--------|-------------|
| `kristijanhusak/vim-dadbod-ui` | Database UI |
| `tpope/vim-dadbod` | Database interaction |
| `kristijanhusak/vim-dadbod-completion` | DB completion |

## Testing

| Plugin | Description |
|--------|-------------|
| `nvim-neotest/neotest` | Test runner framework |
| `nvim-neotest/neotest-jest` | Jest adapter |
| `nvim-neotest/neotest-python` | Python test adapter |

## AI & Copilot

| Plugin | Description |
|--------|-------------|
| `zbirenbaum/copilot.lua` | GitHub Copilot |
| `zbirenbaum/copilot-cmp` | Copilot completion source |

## Misc

| Plugin | Description |
|--------|-------------|
| `wakatime/vim-wakatime` | Coding time tracking |
| `kawre/leetcode.nvim` | LeetCode integration |
| `christoomey/vim-tmux-navigator` | Tmux integration |
| `szw/vim-maximizer` | Window maximizer |
| `nvim-lua/plenary.nvim` | Lua utilities |
| `MunifTanjim/nui.nvim` | UI components |
| `kkharji/sqlite.lua` | SQLite for plugins |

---

## Plugin Count: 80+

## Installation

All plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim) and auto-install on first run.

```vim
:Lazy          " Open plugin manager
:Lazy sync     " Sync plugins
:Lazy update   " Update plugins
:Lazy clean    " Remove unused plugins
:Lazy profile  " Check plugin load times
```
