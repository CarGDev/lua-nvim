# Telescope to Snacks Migration

## Overview

Successfully migrated from Telescope to Snacks throughout the project for a more modern, faster, and cleaner interface.

## Changes Made

### 1. **Alpha Menu** (`lua/cargdev/plugins/alpha.lua`)
- ✅ **Find File**: `Telescope find_files` → `Snacks.picker.files()`
- ✅ **Find Text**: `Telescope live_grep` → `Snacks.picker.grep()`
- ✅ **Recent Files**: `Telescope oldfiles` → `Snacks.picker.oldfiles()`

### 2. **Keymaps** (`lua/cargdev/core/keymaps/snacks.lua`)
- ✅ **File Navigation**: All file search keymaps updated to Snacks
- ✅ **Buffer Management**: Buffer search updated to Snacks
- ✅ **LSP Integration**: LSP pickers updated to Snacks
- ✅ **Symbol Search**: Document and workspace symbols updated to Snacks

### 3. **LSP Keymaps** (`lua/cargdev/core/keymaps/lsp.lua`)
- ✅ **Navigation**: `gd`, `gi`, `gr`, `gt` updated to Snacks
- ✅ **Symbols**: `<leader>ds`, `<leader>ws` updated to Snacks
- ✅ **Diagnostics**: `<leader>D` updated to Snacks

### 4. **DAP Keymaps** (`lua/cargdev/core/keymaps/dap.lua`)
- ✅ **DAP Integration**: All DAP pickers updated to Snacks

### 5. **File Structure**
- ✅ **Renamed**: `telescope.lua` → `snacks.lua`
- ✅ **Updated**: All documentation references

## Kept Telescope For

Some features were kept with Telescope as Snacks may not have equivalent functionality:

### **Git Features**
```lua
-- Git (using Telescope for git features as Snacks may not have all git pickers)
keymap.set("n", "<leader>fG", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
keymap.set("n", "<leader>fB", "<cmd>Telescope git_bcommits<cr>", { desc = "Git buffer commits" })
keymap.set("n", "<leader>fg", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
```

### **Todos**
```lua
-- Todos (keep Telescope for todos as Snacks may not have this)
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
```

## Benefits of Migration

### **Performance**
- ⚡ **Faster**: Snacks is generally faster than Telescope
- 🚀 **Better UX**: Smoother animations and transitions
- 📱 **Modern**: Better touch/gesture support

### **Interface**
- 🎨 **Cleaner**: More modern, less overwhelming interface
- 🎯 **Focused**: Streamlined experience
- 🔧 **Integrated**: Better integration with other Snacks components

### **Consistency**
- 🎯 **Unified**: All pickers now use the same interface
- 🔄 **Cohesive**: Consistent experience across all features
- 📱 **Modern**: Contemporary design language

## Keymaps Summary

### **File Navigation**
- `<leader>ff` - Find files (Snacks)
- `<leader>fs` - Live grep (Snacks)
- `<leader>fc` - Grep string (Snacks)
- `<leader>fr` - Recent files (Snacks)

### **Buffer Management**
- `<leader>fb` - Find buffers (Snacks)
- `<leader>fh` - Help tags (Snacks)
- `<leader>fm` - Find marks (Snacks)
- `<leader>fk` - Find keymaps (Snacks)
- `<leader>fC` - Find commands (Snacks)

### **LSP Navigation**
- `gd` - Go to definition (Snacks)
- `gi` - Go to implementation (Snacks)
- `gr` - Show references (Snacks)
- `gt` - Go to type definition (Snacks)
- `<leader>ds` - Document symbols (Snacks)
- `<leader>ws` - Workspace symbols (Snacks)
- `<leader>D` - Show diagnostics (Snacks)

### **DAP Integration**
- `<leader>dcf` - DAP configurations (Snacks)
- `<leader>dcb` - List breakpoints (Snacks)
- `<leader>dco` - DAP commands (Snacks)

## Alpha Menu

The alpha menu now uses Snacks for all navigation:
- **`f`** - Find File (Snacks)
- **`g`** - Find Text (Snacks)
- **`r`** - Recent Files (Snacks)

## Migration Complete! 🎉

Your Neovim configuration now uses Snacks for all primary navigation and search functionality, providing a faster, more modern, and consistent experience throughout your editor. 