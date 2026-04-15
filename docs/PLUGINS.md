# Plugins Reference

Complete list of plugins in this configuration.

## Navigation & Search

| Plugin | Description |
|--------|-------------|
| `ibhagwan/fzf-lua` | Primary fuzzy finder (files, grep, LSP, diagnostics, todos) |
| `cbochs/portal.nvim` | Navigate jumplist/changelist with preview |

## File Management

| Plugin | Description |
|--------|-------------|
| `nvim-tree/nvim-tree.lua` | File explorer sidebar |
| `nvim-tree/nvim-web-devicons` | File icons |

## Git

| Plugin | Description |
|--------|-------------|
| `kdheepak/lazygit.nvim` | LazyGit TUI (also handles merge conflicts) |
| `lewis6991/gitsigns.nvim` | Gutter signs, hunk staging, inline blame |
| `pwntester/octo.nvim` | GitHub issues/PRs (fzf-lua picker) |

## LSP & Code Intelligence

| Plugin | Description |
|--------|-------------|
| `neovim/nvim-lspconfig` | LSP configuration |
| `williamboman/mason.nvim` | LSP server installer |
| `williamboman/mason-lspconfig.nvim` | Mason + lspconfig bridge |
| `nvimdev/lspsaga.nvim` | Pretty LSP UI (code action, hover, rename, calls) |
| `hrsh7th/nvim-cmp` | Completion engine |
| `hrsh7th/cmp-nvim-lsp` | LSP completion source |
| `hrsh7th/cmp-buffer` | Buffer completion source |
| `hrsh7th/cmp-path` | Path completion source |
| `hedyhli/outline.nvim` | Symbol outline sidebar (`<leader>so`) |
| `smjonas/inc-rename.nvim` | Live rename preview (`<leader>rn`) |
| `kosayoda/nvim-lightbulb` | Code action indicator |
| `rachartier/tiny-inline-diagnostic.nvim` | Pretty inline diagnostics |
| `folke/trouble.nvim` | Diagnostics list |

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
| `kylechui/nvim-surround` | Surround text objects (native `cs<from><to>`) |
| `windwp/nvim-autopairs` | Auto close brackets |
| `numToStr/Comment.nvim` | Commenting |
| `folke/todo-comments.nvim` | Highlight TODOs (`:TodoFzfLua`) |
| `gbprod/substitute.nvim` | Substitute operator |
| `mbbill/undotree` | Visual undo history |
| `chentoast/marks.nvim` | Better marks |
| `kevinhwang91/nvim-ufo` | Better folding |

## Search & Replace

| Plugin | Description |
|--------|-------------|
| `MagicDuck/grug-far.nvim` | Project-wide search & replace (`<leader>sr` / `<leader>sR`) |
| `cshuaimin/ssr.nvim` | Structural search/replace (`<leader>sX`) |

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
| `CarGDev/cargdev-cyberpunk` | Custom cyberpunk theme (owned) |
| `folke/snacks.nvim` | Dashboard, notifier, terminal |
| `folke/noice.nvim` | Centered cmdline popup (cmdline-only mode) |
| `j-hui/fidget.nvim` | LSP progress |
| `nvim-lualine/lualine.nvim` | Statusline |
| `akinsho/bufferline.nvim` | Buffer tabs |
| `Bekaboo/dropbar.nvim` | VS Code-like breadcrumbs |
| `lewis6991/satellite.nvim` | Scrollbar with markers |
| `folke/which-key.nvim` | Keybinding hints |
| `rcarriga/nvim-notify` | Notification backend |

## Eye Candy

| Plugin | Description |
|--------|-------------|
| `shellRaining/hlchunk.nvim` | Scope highlighting |
| `brenoprata10/nvim-highlight-colors` | Color preview |
| `lukas-reineke/indent-blankline.nvim` | Indent guides |
| `xiyaowong/transparent.nvim` | Transparent background |

## Productivity

| Plugin | Description |
|--------|-------------|
| `folke/zen-mode.nvim` | Distraction-free mode |
| `m4xshen/hardtime.nvim` | Vim motion training |
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

## AI

| Plugin | Description |
|--------|-------------|
| `zbirenbaum/copilot.lua` | GitHub Copilot ghost text |
| `zbirenbaum/copilot-cmp` | Copilot completion source in nvim-cmp |
| `CarGDev/codetyper.nvim` | Custom multi-provider AI assistant (owned) |
| `CarGDev/ideadrop.nvim` | Obsidian-style idea panel (owned) |

## Misc

| Plugin | Description |
|--------|-------------|
| `wakatime/vim-wakatime` | Coding time tracking (under review — see audit) |
| `kawre/leetcode.nvim` | LeetCode integration |
| `christoomey/vim-tmux-navigator` | Tmux integration |
| `nvim-lua/plenary.nvim` | Lua utilities |
| `MunifTanjim/nui.nvim` | UI components |
| `kkharji/sqlite.lua` | SQLite for plugins |

---

## Recently Removed (2026-04-14)

telescope.nvim · telescope-fzf-native · telescope-dap · neogit · diffview.nvim · CopilotChat.nvim · modicator.nvim · vim-maximizer · precognition.nvim · twilight.nvim · git-blame.nvim · navbuddy.nvim · nvim-navic · FixCursorHold.nvim

See [CHANGELOG.md](../CHANGELOG.md) for rationale.

## Installation

All plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim) and auto-install on first run.

```vim
:Lazy          " Open plugin manager
:Lazy sync     " Sync plugins
:Lazy update   " Update plugins
:Lazy clean    " Remove unused plugins
:Lazy profile  " Check plugin load times
```
