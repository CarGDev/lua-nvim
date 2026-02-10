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

- **VS Code-like UI** with file explorer, breadcrumbs, symbol outline
- **80+ plugins** carefully configured and optimized
- **Full LSP support** for TypeScript, Python, Java, Go, Lua, and more
- **Debugging** with DAP for Node.js/NestJS, Python, Java, Bun
- **Git integration** with LazyGit, Neogit, Diffview, Octo (GitHub PRs)
- **AI assistance** with GitHub Copilot + CopilotChat
- **HTTP client** for API testing
- **Task runner** for build/run tasks
- **Multi-cursor** editing like VS Code
- **Snacks.nvim** for modern file navigation and pickers
- **fzf-lua** for LSP navigation

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
| `<leader>ff` | Find files (Snacks picker) |
| `<leader>fs` | Search text in project |
| `<leader>e` | Toggle file explorer |
| `<leader>gg` | Open LazyGit |
| `K` | Peek fold or hover documentation |
| `gd` | Go to definition (fzf-lua) |
| `<leader>ca` | Code actions (fzf-lua) |
| `<leader>rn` | Rename symbol |
| `<C-d>` | Multi-cursor (select word) |

### Navigation

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files (Snacks) |
| `<leader>fs` | Live grep (Snacks) |
| `<leader>fr` | Recent files (Snacks) |
| `<leader>fb` | Find buffers (Snacks) |
| `<leader>fk` | Find keymaps (Snacks) |

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
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename |
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

### Copilot & AI

| Key | Action |
|-----|--------|
| `<leader>cc` | Toggle CopilotChat |
| `<leader>ce` | Explain code |
| `<leader>cr` | Review code |
| `<leader>cf` | Fix code |
| `<leader>ct` | Generate tests |

### Editing

| Key | Action |
|-----|--------|
| `<C-d>` | Add cursor on word (VS Code style) |
| `<leader>/` | Toggle comment |
| `<leader>sub` | Substitute with motion |
| `<leader>mm` | Format with conform |

### Tasks & HTTP

| Key | Action |
|-----|--------|
| `<leader>or` | Run task (Overseer) |
| `<leader>ot` | Toggle task list |
| `<leader>kr` | Run HTTP request (in .http file) |
| `<leader>ka` | Run all HTTP requests |

### Language-Specific

| Key | Action |
|-----|--------|
| `<leader>vs` | Select Python venv |
| `<leader>ns` | Show package versions (package.json) |
| `<leader>cv` | Show crate versions (Cargo.toml) |

## Plugin Categories

### Navigation & Search
- **snacks.nvim** - Modern file navigation, pickers, dashboard
- **telescope** - Fuzzy finder (git features, TODOs)
- **fzf-lua** - LSP navigation pickers
- **portal.nvim** - Jump through jumplist with preview
- **nvim-navbuddy** - Code structure navigation

### Git
- **lazygit** - Terminal UI for git
- **neogit** - Magit-like git interface
- **diffview** - Side-by-side diffs
- **gitsigns** - Git decorations and hunk actions
- **git-blame** - Inline blame
- **octo.nvim** - GitHub issues/PRs

### LSP & Coding
- **nvim-lspconfig** + **mason** - LSP setup
- **lspsaga** - Pretty LSP UI
- **nvim-cmp** - Completion (with Copilot source)
- **treesitter** - Syntax highlighting
- **outline.nvim** - Symbol sidebar
- **inc-rename** - Live rename preview
- **lightbulb** - Code action indicator

### Editing
- **vim-visual-multi** - Multi-cursor
- **yanky.nvim** - Yank ring
- **treesj** - Split/join blocks
- **nvim-surround** - Surround text
- **nvim-autopairs** - Auto brackets
- **Comment.nvim** - Commenting

### UI
- **snacks.nvim** - Dashboard, notifier, picker
- **noice.nvim** - UI for messages, cmdline
- **lualine** - Statusline (with word count)
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
- **grug-far** - Search & replace
- **ssr.nvim** - Structural search/replace

### Eye Candy
- **cargdev-cyberpunk** - Custom theme
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
