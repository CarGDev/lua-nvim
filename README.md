# Neovim Configuration

> **📋 Documentation:**
> - **[IMPROVEMENTS.md](./IMPROVEMENTS.md)** - Comprehensive analysis of configuration improvements and recommendations
> - **[keyboard_mappings.md](./keyboard_mappings.md)** - Complete keymap reference
> - **[NATIVE_AUTO_WRAPPER_GUIDE.md](./NATIVE_AUTO_WRAPPER_GUIDE.md)** - Text wrapping configuration guide

---

# Vim and Tmux Keymaps

## Tmux Keymaps

### General Settings
- **Enable mouse support**: `set -g mouse on` (Allows scrolling, selecting panes, resizing)
- **Set scrollback buffer**: `set -g history-limit 2000`
- **Copy selected text to clipboard**: `set-option -g set-clipboard on`
- **Use vi-style key bindings**: `setw -g mode-keys vi`

### Reload Configuration
- **Reload tmux config**: `prefix + r` (Reloads tmux configuration)

### Pane Navigation
- **Move panes**:
  - `Alt + Left` → Move left
  - `Alt + Right` → Move right
  - `Alt + Up` → Move up
  - `Alt + Down` → Move down
- **Split panes**:
  - `prefix + |` → Vertical split
  - `prefix + -` → Horizontal split
- **Sync panes**:
  - `prefix + y` → Enable pane synchronization
  - `prefix + y` → Disable pane synchronization

### Status Bar and UI Enhancements
- **Battery and time status**: `set -g status-right '#{battery_status_bg} battery: #{battery_percentage}% | %Y-%m-%d %H:%M '`
- **Pane border colors**:
  - Inactive: `set -g pane-border-style fg=colour240`
  - Active: `set -g pane-active-border-style fg=colour33`

### Resize Panes
- **Resize using Ctrl + Option + Arrow keys (macOS friendly)**:
  - `Ctrl + Option + Left` → Resize left
  - `Ctrl + Option + Right` → Resize right
  - `Ctrl + Option + Up` → Resize up
  - `Ctrl + Option + Down` → Resize down

## Vim Keymaps

### File Management
- **Save file**: `space + w`
- **Save and close all files**: `space + x + a`
- **Close all files**: `space + q`
- **Reload Neovim config**: `space + s + o`
- **Clear search highlights**: `space + n + o`

### Number Increment/Decrement
- **Increase number**: `space + +`
- **Decrease number**: `space + -`

### Window Management
- **Split window vertically**: `space + s + v`
- **Split window horizontally**: `space + s + h`
- **Make splits equal size**: `space + s + e`
- **Close split**: `space + s + x`

### Tabs
- **Open new tab**: `space + t + o`
- **Close tab**: `space + t + x`
- **Next tab**: `space + t + n`
- **Previous tab**: `space + t + p`
- **Move current buffer to new tab**: `space + t + f`

### Syntax Formatting
- **Format current file**: `space + s + y`

### Buffer Management
- **Close current buffer**: `space + b + d`

### Navigation
- **Next buffer**: `Ctrl + p`
- **Previous buffer**: `Ctrl + n`

### Coding Enhancements
- **Add import React**: `space + r + e`
- **Add comma at end of line**: `space + ,`
- **Add semicolon at end of line**: `space + ;`
- **Insert console.log() below**: `space + c + o + n`
- **Run current file with Node.js**: `space + x`

### Resize Splits
- **Decrease vertical split**: `Ctrl + l`
- **Increase vertical split**: `Ctrl + h`
- **Increase horizontal split**: `Ctrl + k`
- **Decrease horizontal split**: `Ctrl + j`

### LSP and Navigation
- **Show references**: `g + R`
- **Go to declaration**: `g + D`
- **Show definitions**: `g + d`
- **Show implementations**: `g + i`
- **Show type definitions**: `g + t`
- **See available code actions**: `space + c + a`
- **Rename variable**: `space + r + n`
- **Show buffer diagnostics**: `space + D`
- **Show line diagnostics**: `space + d`
- **Previous diagnostic**: `[ + d`
- **Next diagnostic**: `] + d`
- **Show documentation for cursor**: `K`
- **Restart LSP**: `space + r + s`

### File Explorer (Nvim-Tree)
- **Toggle file explorer**: `space + e + e`
- **Toggle explorer on current file**: `space + n + t`
- **Collapse explorer**: `space + e + c`
- **Refresh explorer**: `space + e + r`

This README provides an organized list of Vim and Tmux keymaps for efficient navigation and workflow.
