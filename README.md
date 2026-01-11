# Neovim Configuration

A modern, fast, and well-organized Neovim configuration built with Lua.

## Requirements

- **Neovim**: 0.9+ (0.10+ recommended)
- **Git**: For plugin management
- **Node.js**: For LSP servers and tooling
- **ripgrep** (`rg`): For fast file searching
- **Python 3**: With `pynvim` package for Python support

### Optional Dependencies

- **Pandoc**: For HTML to Markdown conversion
- **Prettier**: For code formatting
- **Stylua**: For Lua formatting

## Installation

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this configuration
git clone <your-repo-url> ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

## Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/cargdev/
│   ├── core/
│   │   ├── init.lua         # Core initialization
│   │   ├── options.lua      # Neovim options
│   │   ├── keymaps/         # Keymap modules
│   │   │   ├── init.lua     # Keymap loader
│   │   │   ├── general.lua  # General keymaps
│   │   │   ├── personal.lua # Personal workflow keymaps
│   │   │   ├── plugins.lua  # Plugin-specific keymaps
│   │   │   ├── window.lua   # Window management
│   │   │   ├── lsp.lua      # LSP keymaps
│   │   │   ├── copilot.lua  # Copilot keymaps
│   │   │   └── ...
│   │   └── function/        # Custom functions
│   ├── plugins/             # Plugin configurations
│   │   ├── lsp/             # LSP-related plugins
│   │   └── ...
│   └── lazy.lua             # Lazy.nvim setup
└── ftplugin/                # Filetype-specific settings
```

## Key Features

- **Colorscheme**: [cargdev-cyberpunk](https://github.com/CarGDev/cargdev-cyberpunk) - Vibrant cyberpunk theme with neon colors and full TypeScript/LSP support
- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) with auto-update notifications
- **LSP**: Full LSP support with Mason for easy server management
- **Completion**: nvim-cmp with multiple sources
- **File Navigation**: Snacks.nvim (modern) + Telescope (git features)
- **File Explorer**: nvim-tree
- **Git Integration**: LazyGit, Gitsigns
- **AI Assistant**: GitHub Copilot with Copilot Chat
- **Debugging**: DAP with UI
- **Formatting**: Conform.nvim with auto-format on save
- **Diagnostics**: Trouble.nvim for organized diagnostics view

## Documentation

| Document | Description |
|----------|-------------|
| [CHANGELOG.md](./CHANGELOG.md) | Version history and changes |
| [keyboard_mappings.md](./keyboard_mappings.md) | QMK keyboard configuration |
| [NATIVE_AUTO_WRAPPER_GUIDE.md](./NATIVE_AUTO_WRAPPER_GUIDE.md) | Text wrapping configuration |
| [TELESCOPE_TO_SNACKS_MIGRATION.md](./TELESCOPE_TO_SNACKS_MIGRATION.md) | Migration notes |

## Quick Reference - Essential Keymaps

### Leader Key: `<Space>`

### File Operations
| Keymap | Description |
|--------|-------------|
| `<leader>w` | Save file |
| `<leader>q` | Close file |
| `<leader>xa` | Save and close all |
| `<leader>bd` | Close buffer (safe) |
| `<leader>bD` | Force close buffer |

### Navigation
| Keymap | Description |
|--------|-------------|
| `<leader>ff` | Find files |
| `<leader>fs` | Live grep (search text) |
| `<leader>fr` | Recent files |
| `<leader>fb` | Find buffers |
| `<leader>e` | Toggle file explorer |

### Window Management
| Keymap | Description |
|--------|-------------|
| `<leader>sv` | Split vertical |
| `<leader>sh` | Split horizontal |
| `<leader>se` | Equal splits |
| `<leader>sx` | Close split |
| `<C-h/j/k/l>` | Resize splits |

### LSP
| Keymap | Description |
|--------|-------------|
| `gd` | Go to definition |
| `gr` | Show references |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>f` | Format buffer |
| `<leader>mm` | Format (conform) |

### Git
| Keymap | Description |
|--------|-------------|
| `<leader>gg` | LazyGit |
| `<leader>gs` | Git status |
| `<leader>gb` | Git blame |

### Diagnostics & Quickfix
| Keymap | Description |
|--------|-------------|
| `<leader>xx` | Toggle Trouble |
| `<leader>xd` | Document diagnostics |
| `<leader>qn/qp` | Next/prev quickfix |
| `<leader>qo/qq` | Open/close quickfix |

### Session
| Keymap | Description |
|--------|-------------|
| `<leader>sS` | Save session |
| `<leader>sR` | Restore session |

### Copilot
| Keymap | Description |
|--------|-------------|
| `<Tab>` | Accept suggestion |
| `<leader>zc` | Open Copilot Chat |
| `<leader>ze` | Explain code (visual) |
| `<leader>zf` | Fix code (visual) |

## Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Open plugin manager |
| `:Mason` | Open LSP server manager |
| `:checkhealth` | Run health checks |
| `:CheckConfig` | Run config validation |
| `:FormatToggle` | Toggle auto-format on save |

## Troubleshooting

### Check Configuration Health
```vim
:checkhealth
:CheckConfig
```

### Common Issues

1. **Plugins not loading**: Run `:Lazy sync`
2. **LSP not working**: Run `:Mason` and install required servers
3. **Formatting not working**: Ensure formatters are installed (prettier, stylua, etc.)
4. **Slow startup**: Check `:Lazy profile` for slow plugins

## License

MIT License - Feel free to use and modify as needed.
