# Telescope Migration Notes

> **Historical note:** Telescope was fully removed from this configuration on 2026-04-14. The current fuzzy finder is **fzf-lua** (see [PLUGINS.md](./PLUGINS.md)). Dashboard entries use `:FzfLua`, `TodoTelescope` → `TodoFzfLua`, and LSP navigation uses `FzfLua lsp_*` commands. This document is kept for reference only.

## Migration Path

Telescope was used through two migration phases:

1. **Telescope → Snacks** (early 2026): Primary file/grep navigation moved to Snacks pickers
2. **Snacks → fzf-lua** (2026-04-14): All fuzzy finding consolidated to fzf-lua for better performance and native fzf feel

## Current State

All fuzzy finding now uses **fzf-lua**:
- `<leader>ff` — Find files (`FzfLua files`)
- `<leader>fs` — Live grep (`FzfLua live_grep`)
- `<leader>fr` — Recent files (`FzfLua oldfiles`)
- `<leader>fb` — Find buffers (`FzfLua buffers`)
- `gd`/`gi`/`gr`/`gt` — LSP navigation via fzf-lua
- `<leader>fG`/`<leader>fB`/`<leader>fg`/`<leader>gs` — Git pickers
- `<leader>ft` — TODO search via `TodoFzfLua`