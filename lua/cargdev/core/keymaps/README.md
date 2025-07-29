# Keymaps Structure

This folder contains all the keymaps organized by category for better maintainability.

## 📁 File Structure

```
keymaps/
├── README.md          # This file
├── general.lua        # General keymaps (leader, basic navigation)
├── personal.lua       # Personal workflow keymaps
├── lsp.lua           # LSP and function navigation keymaps
├── telescope.lua     # Telescope search and navigation keymaps
└── plugins.lua       # Plugin-specific keymaps
```

## 🔧 How It Works

The main `keymaps.lua` file automatically loads all `.lua` files from this folder. Each file contains keymaps for a specific category:

### **general.lua**
- Leader key setup
- Basic navigation
- General utility keymaps

### **personal.lua**
- Your personal workflow keymaps
- File management
- Window management
- Coding shortcuts
- Copilot integration

### **lsp.lua**
- Function navigation (`gd`, `gi`, `gr`, `gt`)
- Symbol search (`<leader>ds`, `<leader>ws`)
- Code actions and documentation
- Diagnostics

### **telescope.lua**
- File search (`<leader>ff`, `<leader>fs`)
- Buffer management
- Git integration
- Help and commands

### **plugins.lua**
- NvimTree
- Comment
- DAP (debugging)
- Trouble
- Terminal
- Session management
- Git conflicts
- LeetCode
- And more...

## ➕ Adding New Keymaps

To add new keymaps:

1. **Choose the appropriate file** based on the category
2. **Add your keymaps** using the standard format:
   ```lua
   keymap.set("n", "<leader>key", "<cmd>command<cr>", { desc = "Description" })
   ```
3. **The keymaps will be automatically loaded** when Neovim starts

## 🎯 Keymap Categories

| Category | File | Description |
|----------|------|-------------|
| General | `general.lua` | Basic setup and utilities |
| Personal | `personal.lua` | Your workflow shortcuts |
| LSP | `lsp.lua` | Function navigation and LSP features |
| Search | `telescope.lua` | File and text search |
| Plugins | `plugins.lua` | Plugin-specific functionality |

## 🔄 Benefits

- **Modular**: Each category is in its own file
- **Maintainable**: Easy to find and modify specific keymaps
- **Scalable**: Easy to add new categories
- **Organized**: Clear separation of concerns
- **Auto-loading**: No need to manually import files

## 🚀 Usage

The keymaps are automatically loaded when Neovim starts. You can:

- **View all keymaps**: `<leader>fk` (Telescope keymaps)
- **Search keymaps**: Use Telescope to search through your keymaps
- **Modify keymaps**: Edit the appropriate file and restart Neovim

## 📝 Notes

- All files are automatically loaded by `keymaps.lua`
- Each file should have its own `local keymap = vim.keymap` declaration
- Use descriptive comments to organize keymaps within each file
- Follow the existing naming conventions for consistency 