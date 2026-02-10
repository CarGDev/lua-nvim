# Custom Keyboard Keymaps

## Overview
This document details the custom key mappings and functionality of the QMK firmware configuration, including mappings relevant to Neovim and Tmux usage.

---

## Custom Keycodes

### RGB Lighting Control
- **RGB_SLD**: Sets the RGB lighting mode to static.

### Macro Key Bindings
These macros are optimized for Neovim and Tmux workflows.

- **ST_MACRO_0**: Opens the Neovim terminal (`Alt + Cmd + I`).
- **ST_MACRO_1**: Moves backward in Tmux (`Ctrl + B`, then `D`).
- **ST_MACRO_2**: Moves forward in Tmux (`Ctrl + B`, then `C`).
- **ST_MACRO_3**: Moves to the previous Tmux window (`Ctrl + B`, then `P`).
- **ST_MACRO_4**: Moves to the next Tmux window (`Ctrl + B`, then `N`).
- **ST_MACRO_5**: Closes the current Tmux pane (`Ctrl + B`, then `W`).
- **ST_MACRO_6**: Splits a Tmux pane vertically (`Ctrl + B`, then `Shift + |`).
- **ST_MACRO_7**: Opens a new Tmux session (`Ctrl + B`, then `Shift + ;`, then `NEW`).
- **ST_MACRO_8**: Moves left in a Tmux pane (`Ctrl + B`, then `Left Arrow`).
- **ST_MACRO_9**: Moves down in a Tmux pane (`Ctrl + B`, then `Down Arrow`).
- **ST_MACRO_10**: Moves up in a Tmux pane (`Ctrl + B`, then `Up Arrow`).
- **ST_MACRO_11**: Moves right in a Tmux pane (`Ctrl + B`, then `Right Arrow`).
- **ST_MACRO_12**: Decreases window size in Tmux (`Ctrl + B`, then `-`).
- **ST_MACRO_13**: Moves to the beginning of a line in Neovim (`Space + B D`).
- **ST_MACRO_14**: Formats the entire file in Neovim (`Space + F G`).
- **ST_MACRO_15**: Creates a new tab in Neovim (`Space + N T`).

### Special Functions
- **MAC_LOCK**: Triggers a system-specific lock command.

---

## Tap Dance Actions
Tap dance actions allow a key to perform multiple functions depending on the number of taps.

### **DANCE_0**
- **Single Tap**: Escape key (useful for exiting insert mode in Neovim).
- **Single Hold**: `Ctrl + Up` (scrolls up in Neovim or switches buffers).
- **Double Tap**: Sends double Escape (useful for quickly leaving insert mode in Neovim).

### **DANCE_1**
- **Single Tap**: Grave (`~`) (for quick access to tilde in Vim commands).
- **Single Hold**: `&` (used in Tmux for window management).
- **Double Tap**: Sends double grave (`~~`).

### **DANCE_2**
- **Single Tap**: Spacebar (default action).
- **Single Hold**: `Cmd + Space` (Spotlight search on macOS, also used for command execution in Neovim).
- **Double Tap**: Sends double space (quick spacing in text documents).

### **DANCE_3**
- **Single Tap**: `0` (moves cursor to the beginning of a line in Neovim).
- **Single Hold**: `=` (resizes panes in Tmux).
- **Double Tap**: Sends double `0`.

---

## Layer Functions
The keyboard supports multiple layers for different functionalities.

### **Layer 0 (Default Layer - Neovim and Tmux Focused)**
- **Neovim shortcuts**: Efficient navigation and command execution.
- **Tmux pane/window management**: Quick switching and resizing.

### **Layer 1 (Function & Symbols Layer)**
- **F-keys (F1–F12)**
- **Media and RGB controls**
- **Special characters (`@, $, %, &, *, etc.`)**

### **Layer 2 (Macros & Shortcuts Layer)**
- **Macro functions for Neovim (`ST_MACRO_1–15`)**
- **Media and navigation shortcuts**

### **Layer 3 (Navigation & Window Management Layer)**
- **Arrow keys and window movement shortcuts**
- **Undo, cut, paste, and system controls**
- **Tmux session switching and splits**

### **Layer 4 (Mouse & Boot Mode Layer)**
- **Mouse controls and screenshot shortcuts**
- **Boot mode activation (`QK_BOOT`)**

---

## Special Modifiers
- **MO(n)**: Momentary activation of layer `n`.
- **LT(n, key)**: Hold for layer `n`, tap for `key`.
- **TG(n)**: Toggle layer `n` on/off.

This structured keymap provides an overview of the keyboard's advanced functionality, integrating Neovim, Tmux, and QMK efficiently.
