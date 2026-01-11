# Changelog

All notable changes to this Neovim configuration will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [Unreleased]

### Added
- **Avante.nvim AI Assistant**: Added Avante.nvim with local LLM support to README documentation
- **Bash Treesitter Parser**: Installed bash parser for noice.nvim cmdline highlighting
- **Local Configuration Support**: `local.lua` is now loaded at startup and exposed via `vim.g.cargdev_local`
  - Enables machine-specific paths without hardcoding
  - Safe loading with `pcall` (won't error if file doesn't exist)
  - Plugins gracefully skip if required config is missing

### Changed
- **Avante Plugin**: Now uses `local.lua` for all paths and settings
  - `avante_dev_path` for plugin directory
  - `avante_endpoint`, `avante_api_key_name`, `avante_model` for provider config
- **IdeaDrop Plugin**: Now uses `IDEA_DIR` from `local.lua` instead of environment variable

### Removed
- **Hardcoded Paths**: Removed all hardcoded user paths from plugin configs
  - `avante.lua` - uses `local.lua` values
  - `ideaMap.lua` - uses `local.lua` values
  - `leetcode.lua` - removed commented hardcoded path
  - `lazygit.lua` - removed commented hardcoded path

### Fixed
- **Auto-session Lazy Loading**: Changed from `event = "VeryLazy"` to `lazy = false` to enable session auto-restore on startup
- **Alpha Dashboard Config**: Fixed `enable` to `enabled` (correct lazy.nvim spec key)
- **Snacks vs Alpha Conflict**: Disabled `Snacks.dashboard` in favor of `alpha-nvim` for CARGDEV branding

### Added
- **Java Debug & Run Keymaps**: New keybindings for Java development
  - `<leader>jd` - Debug Class (DAP)
  - `<leader>jt` - Test Class
  - `<leader>jn` - Test Nearest Method
  - `<leader>jr` - Run Java File
  - `<leader>jm` - Run Maven Project
  - `<leader>jg` - Run Gradle Project
- **Java Debug Dependencies**: Added `java-debug-adapter` and `java-test` to Mason ensure_installed

### Changed
- **Colorscheme Configuration**: Enhanced `cargdev-cyberpunk` setup
  - Enabled transparency
  - Enabled italic comments
  - Enabled bold keywords, functions, and types
  - Enabled terminal colors

### Fixed
- **Java DAP Configuration**: Fixed debug adapter not loading
  - Changed `bundles = {}` to `bundles = bundles` to properly load debug JARs
  - Added `on_attach` callback to setup DAP after JDTLS attaches
  - Enables hot code replacement during debugging
- **Broken Java DAP Adapter**: Removed manual Java adapter with undefined `port` variable
  - Now handled automatically by nvim-jdtls via `jdtls.setup_dap()`

---

## [2026-01-10]

### Added
- **Custom Colorscheme**: Using `cargdev-cyberpunk` theme
  - Vibrant, high-contrast cyberpunk aesthetic with neon colors
  - Hot pink keywords, electric purple types, cyan strings, green functions
  - Full TypeScript/LSP/Treesitter support
  - Deep blue backgrounds with neon accents
  - Loaded with high priority for consistent UI
- **Which-Key Group Names**: Added organized group names for better keymap discoverability
  - Groups: Buffer, Code/Copilot, Debug, Explorer, Find/Files, Git, LSP, Format, Quickfix, Session, Tab/Terminal, Trouble, Copilot Chat
- **Auto-Format on Save**: Enabled smart auto-formatting with conform.nvim
  - Skips certain filetypes (sql, markdown)
  - Skips files in node_modules
  - Added `:FormatToggle` command to enable/disable
- **Diagnostic Float on Hover**: Diagnostics now appear automatically when cursor holds
- **Safe Buffer Close**: `<leader>bd` now prompts for unsaved changes
  - Options: Save & Close, Discard & Close, Cancel
  - `<leader>bD` for force close without confirmation
- **Quickfix Navigation Keymaps**:
  - `<leader>qn` - Next quickfix item
  - `<leader>qp` - Previous quickfix item
  - `<leader>qo` - Open quickfix list
  - `<leader>qq` - Close quickfix list
  - `<leader>qf` - First quickfix item
  - `<leader>ql` - Last quickfix item
- **Location List Navigation Keymaps**:
  - `<leader>ln` - Next location item
  - `<leader>lp` - Previous location item
  - `<leader>lo` - Open location list
  - `<leader>lq` - Close location list
- **Configuration Validation**: Startup checks for:
  - Neovim version (0.9+ recommended)
  - Required executables (git, rg, node)
- **Plugin Update Notifications**: Lazy.nvim now notifies about available updates (daily check)
- **CheckConfig Command**: Quick access to health checks

### Changed
- **Session Keymaps**: Renamed to avoid conflicts with substitute
  - `<leader>ss` → `<leader>sS` (Session Save)
  - `<leader>sr` → `<leader>sR` (Session Restore)
- **Substitute Keymaps**: Reorganized to avoid conflicts
  - `<leader>ss` → `<leader>sl` (Substitute Line)
  - `<leader>sub` remains for substitute with motion
  - `<leader>S` remains for substitute to end of line
- **Keymap Descriptions**: Standardized format (e.g., "Session: Save", "Substitute: Line")

### Fixed
- **Duplicate Window Management Keymaps**: Removed duplicates from `personal.lua`, centralized in `window.lua`
- **Duplicate Resize Keymaps**: Removed duplicates, centralized in `window.lua`
- **Redundant Filetype Detection**: Now only runs if filetype is not already detected
- **Double Function Loading**: Functions now load once on VimEnter with flag protection
- **Duplicate synmaxcol Setting**: Removed duplicate (was 240 then 200), kept 200
- **Duplicate foldmethod Setting**: Removed duplicate, kept `indent` (faster than `syntax`)
- **Duplicate foldlevel Setting**: Removed duplicate setting
- **Environment Variable Validation**: `IDEA_DIR` now validated before Obsidian link setup

### Removed
- **Temporary Files**:
  - `kkk` - Unknown purpose temporary file
  - `cleanup_deprecated_adapters.lua` - Cleanup script no longer needed
- **IMPROVEMENTS.md**: All issues resolved, file removed
- **Commented Code**:
  - Tmux navigation keymaps from `personal.lua`
  - Commented `x` keymap explanation from `general.lua`
  - Commented `project_config` bootstrap from `init.lua`

### Performance
- Optimized filetype detection (conditional execution)
- Reduced redundant option settings
- Single function loading instead of double

---

## [Previous] - Pre-Changelog

### Features Present
- Lazy.nvim plugin management
- Full LSP support with Mason
- nvim-cmp completion
- Snacks.nvim + Telescope file navigation
- nvim-tree file explorer
- LazyGit integration
- GitHub Copilot + Copilot Chat
- DAP debugging with UI
- Conform.nvim formatting
- Trouble.nvim diagnostics
- Native auto-wrapping configuration
- Custom lualine theme with word count

### Migration History
- Migrated from Telescope to Snacks for primary navigation
- Kept Telescope for git-specific features
- See [TELESCOPE_TO_SNACKS_MIGRATION.md](./TELESCOPE_TO_SNACKS_MIGRATION.md) for details

---

## File Changes Summary

### Modified Files
| File | Changes |
|------|---------|
| `lua/cargdev/core/keymaps/personal.lua` | Removed duplicates, added quickfix/location keymaps, safe buffer close |
| `lua/cargdev/core/keymaps/plugins.lua` | Fixed session/substitute keymap conflicts |
| `lua/cargdev/core/keymaps/general.lua` | Added vault_path validation, removed commented code |
| `lua/cargdev/core/keymaps/window.lua` | Centralized window management keymaps |
| `lua/cargdev/core/init.lua` | Fixed double loading, added diagnostic hover, config validation, loads `local.lua` |
| `lua/cargdev/plugins/avante.lua` | Uses `local.lua` for paths and settings, removed hardcoded values |
| `lua/cargdev/plugins/ideaMap.lua` | Uses `local.lua` for `IDEA_DIR`, removed env var fallback |
| `lua/cargdev/plugins/leetcode.lua` | Removed commented hardcoded path |
| `lua/cargdev/plugins/lazygit.lua` | Removed commented hardcoded path |
| `lua/cargdev/core/options.lua` | Removed duplicate settings (synmaxcol, foldmethod, foldlevel) |
| `lua/cargdev/plugins/which-key.lua` | Added group names configuration |
| `lua/cargdev/plugins/formatting.lua` | Enabled auto-format on save with smart filtering |
| `lua/cargdev/lazy.lua` | Enabled plugin update notifications |
| `README.md` | Complete rewrite with proper documentation |

### Deleted Files
| File | Reason |
|------|--------|
| `kkk` | Temporary file, unknown purpose |
| `cleanup_deprecated_adapters.lua` | One-time cleanup script, no longer needed |
| `IMPROVEMENTS.md` | All issues resolved |

### New Files
| File | Purpose |
|------|---------|
| `CHANGELOG.md` | Track configuration changes |

---

## Keymap Reference

### New/Changed Keymaps

| Keymap | Action | File |
|--------|--------|------|
| `<leader>sS` | Session: Save | plugins.lua |
| `<leader>sR` | Session: Restore | plugins.lua |
| `<leader>sl` | Substitute: Line | plugins.lua |
| `<leader>bd` | Buffer: Close (safe) | personal.lua |
| `<leader>bD` | Buffer: Force close | personal.lua |
| `<leader>qn` | Quickfix: Next | personal.lua |
| `<leader>qp` | Quickfix: Previous | personal.lua |
| `<leader>qo` | Quickfix: Open | personal.lua |
| `<leader>qq` | Quickfix: Close | personal.lua |
| `<leader>qf` | Quickfix: First | personal.lua |
| `<leader>ql` | Quickfix: Last | personal.lua |
| `<leader>ln` | Location: Next | personal.lua |
| `<leader>lp` | Location: Previous | personal.lua |
| `<leader>lo` | Location: Open | personal.lua |
| `<leader>lq` | Location: Close | personal.lua |

---

*Last Updated: January 10, 2026*
