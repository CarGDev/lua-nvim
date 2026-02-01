# CargDev Neovim Configuration

A modern, feature-rich Neovim configuration with 80+ plugins, optimized for full-stack development.

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

- **VS Code-like UI** with file explorer on right, breadcrumbs, symbol outline
- **80+ plugins** carefully configured and optimized
- **Full LSP support** for TypeScript, Python, Java, Go, Lua, and more
- **Debugging** with DAP for Node.js/NestJS, Python, Java
- **Git integration** with LazyGit, Neogit, Diffview, Octo (GitHub PRs)
- **AI assistance** with GitHub Copilot
- **HTTP client** for API testing
- **Task runner** for build/run tasks
- **Multi-cursor** editing like VS Code

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
| [KEYMAPS.md](./KEYMAPS.md) | **Complete keybinding reference** |
| [PLUGINS.md](./PLUGINS.md) | All plugins and their purposes |
| [CHANGELOG.md](./CHANGELOG.md) | Version history |

## Quick Start

### Leader Key: `<Space>`

### Essential Keymaps

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fs` | Search text in project |
| `<leader>e` | Toggle file explorer (right side) |
| `<leader>gg` | Open LazyGit |
| `s` | Flash jump (type chars to jump) |
| `<leader>ha` | Harpoon add file |
| `<leader>1-5` | Jump to harpooned file |
| `K` | Hover documentation |
| `gd` | Go to definition |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol (live preview) |
| `<C-d>` | Multi-cursor (select word) |

### Navigation

| Key | Action |
|-----|--------|
| `s` | Flash jump anywhere |
| `S` | Flash treesitter select |
| `<leader>nb` | Navbuddy (code structure popup) |
| `<leader>cs` | Symbol outline sidebar |
| `<leader>tu` | Undo tree |

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | LazyGit |
| `<leader>gn` | Neogit (magit-like) |
| `<leader>gd` | Diffview |
| `<leader>gh` | File history |
| `<leader>gB` | Toggle git blame |
| `<leader>oi` | GitHub issues (Octo) |
| `<leader>op` | GitHub PRs (Octo) |

### Editing

| Key | Action |
|-----|--------|
| `<C-d>` | Add cursor on word (VS Code style) |
| `<C-a>` / `<C-x>` | Smart increment/decrement |
| `<leader>tj` | Toggle split/join code blocks |
| `<leader>sr` | Search & replace (project-wide) |
| `<leader>sR` | Structural search/replace |
| `<leader>yh` | Yank history |
| `<C-p>` / `<C-n>` | Cycle yank history |

### LSP

| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `gd` | Peek definition |
| `gD` | Go to definition |
| `gr` | Rename |
| `gh` | LSP finder (refs, implementations) |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename (live preview) |
| `<leader>sl` | Line diagnostics |
| `[d` / `]d` | Prev/next diagnostic |

### Debugging

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dcc` | Start/continue debugging |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>du` | Toggle DAP UI |

### Tasks & HTTP

| Key | Action |
|-----|--------|
| `<leader>or` | Run task (Overseer) |
| `<leader>ot` | Toggle task list |
| `<leader>kr` | Run HTTP request (in .http file) |
| `<leader>ka` | Run all HTTP requests |

### Productivity

| Key | Action |
|-----|--------|
| `<leader>zz` | Zen mode |
| `<leader>zt` | Twilight (dim inactive code) |
| `<leader>qs` | Restore session |
| `<leader>ht` | Toggle Hardtime (learn vim motions) |
| `<leader>vp` | Toggle Precognition (motion hints) |
| `<leader>sk` | Toggle Screenkey (show keypresses) |

### Python

| Key | Action |
|-----|--------|
| `<leader>vs` | Select Python venv |
| Debug configs | Django, FastAPI, Flask, Launch file |

### JavaScript/TypeScript

| Key | Action |
|-----|--------|
| `<leader>ns` | Show package versions (package.json) |
| `<leader>nu` | Update package |
| Debug configs | NestJS, ts-node, Attach |

### Rust

| Key | Action |
|-----|--------|
| `<leader>cv` | Show crate versions (Cargo.toml) |
| `<leader>cu` | Update crate |

## Plugin Categories

### Navigation & Search
- **telescope** - Fuzzy finder
- **flash.nvim** - Jump anywhere with minimal keystrokes
- **harpoon** - Quick file marks
- **portal.nvim** - Jump through jumplist with preview
- **nvim-navbuddy** - Code structure navigation

### Git
- **lazygit** - Terminal UI for git
- **neogit** - Magit-like git interface
- **diffview** - Side-by-side diffs
- **gitsigns** - Git decorations
- **git-blame** - Inline blame
- **octo.nvim** - GitHub issues/PRs

### LSP & Coding
- **nvim-lspconfig** + **mason** - LSP setup
- **lspsaga** - Pretty LSP UI
- **nvim-cmp** - Completion
- **treesitter** - Syntax highlighting
- **outline.nvim** - Symbol sidebar
- **inc-rename** - Live rename preview
- **lightbulb** - Code action indicator

### Editing
- **vim-visual-multi** - Multi-cursor
- **yanky.nvim** - Yank ring
- **treesj** - Split/join blocks
- **dial.nvim** - Smart increment
- **nvim-surround** - Surround text
- **nvim-autopairs** - Auto brackets
- **Comment.nvim** - Commenting

### UI
- **snacks.nvim** - Dashboard, notifier, picker
- **noice.nvim** - UI for messages, cmdline
- **lualine** - Statusline
- **bufferline** - Buffer tabs
- **dropbar** - Breadcrumbs
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
- **kulala** - HTTP client
- **zen-mode** - Distraction-free
- **persistence** - Session management
- **grug-far** - Search & replace
- **ssr.nvim** - Structural search/replace

### Eye Candy
- **cargdev-cyberpunk** - Custom theme
- **mini.animate** - Smooth animations
- **reactive** - Mode-based colors
- **hlchunk** - Scope highlighting
- **nvim-highlight-colors** - Color preview

## Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Plugin manager |
| `:Mason` | LSP server manager |
| `:Navbuddy` | Code navigation |
| `:Outline` | Symbol outline |
| `:Neogit` | Git interface |
| `:DiffviewOpen` | Open diff view |
| `:GrugFar` | Search & replace |
| `:Octo` | GitHub integration |
| `:OverseerRun` | Run tasks |
| `:ZenMode` | Distraction-free mode |
| `:Hardtime toggle` | Toggle vim training |
| `:Screenkey` | Show keypresses |

## Debugging Setup

### Python
```bash
:Mason  # Install debugpy
```
Configs: Launch File, Django, FastAPI, Flask, Attach Remote

### Node.js / TypeScript / NestJS
```bash
:Mason  # Install js-debug-adapter
```
Configs: Launch NestJS, Launch File, ts-node, Attach

### Java
```bash
:Mason  # Install java-debug-adapter, java-test
```
Auto-configured via nvim-jdtls

## HTTP Client (Kulala)

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

Use `<leader>kr` to run request under cursor.

## Tips & Tricks

### Learn Vim Motions
Enable Hardtime (`<leader>ht`) and Precognition (`<leader>vp`) to improve your vim skills.

### Quick File Switching
Use Harpoon to mark important files (`<leader>ha`), then jump instantly with `<leader>1-5`.

### Multi-Cursor Editing
Like VS Code: `<C-d>` to select word, keep pressing for more occurrences.

### Smart Increment
`<C-a>` on `true` → `false`, on `GET` → `POST`, on dates, colors, etc.

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
