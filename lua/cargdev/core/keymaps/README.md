# Keymaps Structure

This folder contains all the keymaps organized by category for better maintainability.

## File Structure

```
keymaps/
├── README.md          # This file
├── general.lua        # General keymaps (leader, basic navigation, obsidian)
├── personal.lua       # Personal workflow keymaps
├── lsp.lua            # LSP and function navigation keymaps
├── dap.lua            # DAP debugging keymaps
├── snacks.lua         # Snacks search and navigation keymaps
├── window.lua         # Window management keymaps
├── copilot.lua        # Copilot AI keymaps
├── plugins.lua        # Plugin-specific keymaps (Telescope, trouble, etc.)
├── project.lua        # Project-specific keymaps
├── ufo.lua            # Folding keymaps
├── leet.lua           # LeetCode keymaps
├── sudoku.lua         # Sudoku game keymaps
└── database.lua       # Database keymaps
```

## How It Works

The main `keymaps.lua` file automatically loads all `.lua` files from this folder:

```lua
local function load_keymaps()
  local keymaps_path = vim.fn.stdpath("config") .. "/lua/cargdev/core/keymaps"
  local scan = vim.fn.globpath(keymaps_path, "*.lua", false, true)

  for _, file in ipairs(scan) do
    local module_name = "cargdev.core.keymaps." .. file:match("([^/]+)%.lua$")
    pcall(require, module_name)
  end
end
```

## Keymap Categories

| Category | File | Description |
|----------|------|-------------|
| General | `general.lua` | Basic setup, escape, obsidian links |
| Personal | `personal.lua` | Your workflow shortcuts |
| LSP | `lsp.lua` | Function navigation and LSP features |
| Debugging | `dap.lua` | DAP debugging (Java, Node.js, Python) |
| Search | `snacks.lua` | File and text search (Snacks) |
| Window | `window.lua` | Window/split management |
| Copilot | `copilot.lua` | AI assistant keymaps |
| Plugins | `plugins.lua` | Plugin-specific (Telescope, trouble, etc.) |
| Project | `project.lua` | Project commands |
| Folding | `ufo.lua` | Code folding |
| LeetCode | `leet.lua` | LeetCode integration |
| Database | `database.lua` | Database operations |

## Adding New Keymaps

1. **Choose the appropriate file** based on the category
2. **Add your keymaps** using the standard format:
   ```lua
   local keymap = vim.keymap
   keymap.set("n", "<leader>key", "<cmd>command<cr>", { desc = "Description" })
   ```
3. **The keymaps will be automatically loaded** when Neovim starts

## Leader Key Prefixes

| Prefix | Category |
|--------|----------|
| `<leader>f` | Find/Files (Telescope) |
| `<leader>g` | Git |
| `<leader>d` | Debug |
| `<leader>l` | LSP/LeetCode |
| `<leader>x` | Trouble/Diagnostics |
| `<leader>s` | Search/Session |
| `<leader>t` | Toggle/Text/Treesj |
| `<leader>h` | Harpoon |
| `<leader>k` | Kulala (HTTP) |
| `<leader>o` | Overseer/Octo |
| `<leader>n` | NPM/Navbuddy |
| `<leader>c` | Code/Crates |
| `<leader>v` | Vim learning |
| `<leader>z` | Zen mode |
| `<leader>q` | Session (persistence) |
| `<leader>r` | Rename/Regex |
| `<leader>p` | Portal/Projects |

## Full Reference

See [KEYMAPS.md](../../../../KEYMAPS.md) in the root directory for complete keybinding reference.

## Notes

- All files are automatically loaded by `keymaps.lua`
- Each file should have its own `local keymap = vim.keymap` declaration
- Use descriptive `desc` for all keymaps (shows in which-key)
- Follow the existing naming conventions for consistency
