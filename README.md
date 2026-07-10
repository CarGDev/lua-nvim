# CargDev Neovim Configuration

A modern, pruned Neovim configuration (~45 plugins) optimized for full-stack development.

```
  ██████╗ █████╗ ██████╗  ██████╗ ██████╗ ███████╗██╗   ██╗
  █╔════╝██╔══██╗██╔══██╗██╔════╝ ██╔══██╗██╔════╝██║   ██║
  █║     ███████║██████╔╝██║  ███╗██║  ██║█████╗  ██║   ██║
  █║     ██╔══██║██╔══██╗██║   ██║██║  ██║██╔══╝  ╚██╗ ██╔╝
  ██████╗██║  ██║██║  ██║╚██████╔╝██████╔╝███████╗ ╚████╔╝
  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝  ╚═══╝

  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
```

## Features

- **VS Code-like UI** with file explorer, breadcrumbs, symbol outline
- **Full LSP support** for TypeScript, Python, Java, Go, Lua, and more
- **Debugging** with DAP for Node.js/NestJS, Python, Java, Bun
- **Git integration** with LazyGit (merge conflicts included) + Octo (GitHub PRs) + gitsigns
- **AI assistance** with `codetyper.nvim` (custom multi-provider assistant)
- **HTTP client** (rest.nvim) for API testing with `.http` files
- **Task runner** for build/run tasks
- **Snacks.nvim** for dashboard + terminal
- **fzf-lua** for all fuzzy-finding and LSP navigation
- **Noice** (cmdline-only) — centered floating `:` / `/` prompt

## Requirements

```bash
# Required
brew install neovim ripgrep fd node python3

# Optional but recommended
brew install lazygit jq
pip3 install pynvim
npm install -g neovim
```

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this configuration
git clone <your-repo-url> ~/.config/nvim

# Start Neovim (plugins auto-install)
nvim
```

## Documentation

| Document | Description |
|----------|-------------|
| [KEYMAPS.md](./docs/KEYMAPS.md) | **Complete keybinding reference** |
| [PLUGINS.md](./docs/PLUGINS.md) | All plugins and their purposes |
| [CHANGELOG.md](./CHANGELOG.md) | Version history and recent changes |
| [Native Auto Wrapper](./docs/NATIVE_AUTO_WRAPPER_GUIDE.md) | Text wrapping configuration |
| [Snacks Migration](./docs/TELESCOPE_TO_SNACKS_MIGRATION.md) | Telescope to Snacks migration notes |
| [Keyboard Mappings](./docs/keyboard_mappings.md) | QMK keyboard layout reference |

## Quick Start

### Leader Key: `<Space>`

### Essential Keymaps

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files (fzf-lua) |
| `<leader>fs` | Live grep (fzf-lua) |
| `<leader>e` | Toggle file explorer |
| `<leader>gg` | Open LazyGit |
| `H` | Hover documentation |
| `gd` | Go to definition (fzf-lua) |
| `<leader>la` | Code actions (lspsaga) |
| `<leader>rn` | Rename symbol (inc-rename) |

### Navigation

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files (fzf-lua) |
| `<leader>fs` | Live grep (fzf-lua) |
| `<leader>fr` | Recent files |
| `<leader>fb` | Find buffers |
| `<leader>fk` | Find keymaps |
| `<leader>ft` | Find TODOs (TodoFzfLua) |

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | LazyGit |
| `<leader>gs` | Git status |
| `]h` / `[h` | Next/prev hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff this |

### LSP

| Key | Action |
|-----|--------|
| `H` | Hover documentation |
| `gd` | Go to definition |
| `gi` | Go to implementation |
| `gr` | Show references |
| `<leader>la` | Code actions (lspsaga) |
| `<leader>li` / `<leader>lo` | Incoming / outgoing calls |
| `<leader>rn` | Rename (inc-rename) |
| `<leader>dd` | Line diagnostics |
| `[d` / `]d` | Prev/next diagnostic |

### Debugging

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dcr` | Start/continue debugging |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dot` | Step out |
| `<leader>du` | Toggle DAP UI |
| `<leader>jd` | Dynamic debug attach |

### Codetyper & AI

| Key | Action |
|-----|--------|
| `<leader>ct` | Toggle codetyper view |
| `<leader>ca` | Open codetyper Ask panel |
| `<leader>co` | Open codetyper view |
| `<leader>cd` | Open codetyper Diff Review |

### Editing

| Key | Action |
|-----|--------|
| `<leader>/` | Toggle comment |
| `<leader>sub` | Substitute with motion |
| `<leader>mm` | Format with conform |

### Tasks & HTTP

| Key | Action |
|-----|--------|
| `<leader>or` | Run task (Overseer) |
| `<leader>ot` | Toggle task list |
| `<leader>oL` | List GitHub repos (Octo) |
| `<leader>op` | List PRs (Octo) |
| `<leader>kr` | Run HTTP request (in .http file) |
| `<leader>ka` | Run all HTTP requests |

### Language-Specific

| Key | Action |
|-----|--------|
| `<leader>ns` | Show package versions (package.json) |
| `<leader>cv` | Show crate versions (Cargo.toml) |

## Plugin Categories

### Navigation & Search
- **fzf-lua** - Primary fuzzy finder (files, grep, LSP, todos, diagnostics, git)
- **snacks.nvim** - Dashboard + terminal
- **portal.nvim** - Jump through jumplist with preview

### Git
- **lazygit.nvim** - Terminal UI (covers merge conflicts)
- **gitsigns** - Gutter decorations, hunk staging, line blame
- **octo.nvim** - GitHub issues/PRs (fzf-lua picker)

### LSP & Coding
- **nvim-lspconfig** + **mason** - LSP setup
- **lspsaga** - Pretty LSP UI
- **nvim-cmp** - Completion engine
- **treesitter** - Syntax highlighting
- **outline.nvim** - Symbol sidebar
- **inc-rename** - Live rename preview
- **lightbulb** - Code action indicator

### Editing
- **treesj** - Split/join blocks
- **nvim-surround** - Surround text
- **nvim-autopairs** - Auto brackets
- **Comment.nvim** - Commenting

### UI
- **snacks.nvim** - Dashboard, notifier, terminal
- **noice.nvim** - Centered cmdline popup (cmdline-only mode)
- **fidget.nvim** - LSP progress in the corner
- **lualine** - Statusline (with word count)
- **bufferline** - Buffer tabs
- **dropbar** - Breadcrumbs
- **outline.nvim** - Symbol sidebar (`<leader>so`)
- **satellite** - Scrollbar with markers
- **which-key** - Keybinding hints
- **trouble** - Diagnostics list

### Debugging
- **nvim-dap** - Debug Adapter Protocol
- **nvim-dap-ui** - Debug UI
- **nvim-dap-python** - Python debugging
- **nvim-jdtls** - Java debugging

### Productivity
- **overseer** - Task runner
- **rest.nvim** - HTTP client (`.http` files)
- **grug-far** - Search & replace
- **ssr.nvim** - Structural search/replace

### Eye Candy
- **cargdev-cyberpunk** - Custom theme (owned)
- **hlchunk** - Scope highlighting
- **nvim-highlight-colors** - Color preview

### AI (owned)
- **CarGDev/codetyper.nvim** - Custom multi-provider AI assistant
- **CarGDev/ideadrop.nvim** - Obsidian-style note panel

## Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Plugin manager |
| `:Mason` | LSP server manager |
| `:Outline` | Symbol outline |
| `:LazyGit` | Git TUI |
| `:GrugFar` | Search & replace |
| `:Octo` | GitHub integration |
| `:OverseerRun` | Run tasks |
| `:ZenMode` | Distraction-free mode |
| `:Hardtime toggle` | Toggle vim training |
| `:WordCount` | Show word count (excluding symbols) |
| `:RunProject` | Run project command |

## Debugging Setup

### Python
```bash
:Mason  # Install debugpy
```
Configs: Launch File, Django, FastAPI, Flask, Attach Remote

### Node.js / TypeScript / NestJS / Bun
```bash
:Mason  # Install js-debug-adapter
```
Configs: Launch NestJS, Launch File, ts-node, Bun Launch, Dynamic Attach

### Java
```bash
:Mason  # Install java-debug-adapter, java-test
```
Auto-configured via nvim-jdtls (JDK 25, mac_arm)

## HTTP Client (rest.nvim)

Create a `.http` file:

```http
### Get users
GET https://api.example.com/users
Authorization: Bearer {{token}}

### Create user
POST https://api.example.com/users
Content-Type: application/json

{
  "name": "John"
}
```

Use `<leader>kr` to run the request under cursor, or `<leader>ka` to run all requests.

## Tips & Tricks

### Learn Vim Motions
Enable Hardtime (`<leader>ht`) to discourage repeated motions and improve your vim skills.

### Multi-Cursor Editing
Like VS Code: `<C-d>` to select word, keep pressing for more occurrences.

### Split/Join Code
`<leader>tj` on arrays, objects, function arguments to toggle between single/multi-line.

## Troubleshooting

```vim
:checkhealth          " Run health checks
:Lazy sync            " Sync plugins
:Mason                " Check LSP servers
:LspInfo              " Check LSP status
```

## License

MIT License
