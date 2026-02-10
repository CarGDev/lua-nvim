# Changelog

All notable changes to this Neovim configuration will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [2026-02-10]

### Added
- **Documentation restructure**: Moved all documentation into `docs/` directory
  - `docs/KEYMAPS.md` - Complete keybinding reference (rewritten from actual keymap files)
  - `docs/PLUGINS.md` - Plugin list and descriptions
  - `docs/NATIVE_AUTO_WRAPPER_GUIDE.md` - Text wrapping configuration
  - `docs/TELESCOPE_TO_SNACKS_MIGRATION.md` - Migration notes
  - `docs/keyboard_mappings.md` - QMK keyboard layout reference
  - `docs/CHANGELOG_OLD.md` - Previous changelog archive
- **Keymap conflict detection script**: `scripts/detect_keymap_conflicts.lua`

### Changed
- **README.md**: Updated documentation links to point to `docs/`, removed references to deleted plugins (flash, harpoon, dial, screenkey, persistence, mini.animate), updated keymap tables to reflect current state
- **KEYMAPS.md**: Complete rewrite based on actual current keymap definitions

---

## [2026-02-08]

### Fixed
- **hlchunk.nvim**: Fixed rendering issues with scope highlighting
- **lspconfig**: Fixed LSP configuration issues
- **lualine**: Fixed statusline rendering and word count display
- **nvim-ufo**: Fixed folding behavior and peek integration

---

## [2026-02-05] - Major Cleanup & Refactor

### Removed - Plugins
- **codetyper.lua**: Removed locally-developed plugin (reduced maintenance surface)
- **curls.lua**: Removed local HTTP/curl plugin (replaced by kulala)
- **edgy.lua**: Removed window layout management plugin
- **flash.lua**: Removed flash.nvim jump plugin
- **sudoku.lua**: Removed sudoku game plugin
- **screenkey.lua**: Removed screenkey plugin (show keypresses)
- **persistence.lua**: Removed persistence session management
- **auto-session.lua**: Removed auto-session plugin
- **dial.lua**: Removed smart increment/decrement plugin
- **mini-animate.lua**: Removed smooth animations plugin
- **harpoon.lua**: Removed harpoon quick file marks
- **colorful-winsep.lua**: Removed colorful window separators
- **dressing.lua**: Removed vim.ui improvements (handled by snacks/noice)
- **ship.lua**: Removed ship plugin
- **fileOperations.lua**: Removed file operations plugin

### Removed - Keymaps & Docs
- **keymaps/README.md**: Removed stale keymaps documentation
- **keymaps/sudoku.lua**: Removed sudoku keymaps
- **NVIM_PERFORMANCE_ANALYSIS.md**: Removed performance analysis doc

### Changed - Core Refactors
- **Notification manager** (`notification_manager.lua`): Major refactor with local aliases, improved docs, dashboard-aware handling, nvim-notify fallback, safer notification tracking and cleanup
- **Performance monitor** (`performance_monitor.lua`): Refactored with local references and better notify usage
- **Project commands** (`project_commands.lua`): Added docs, local API/fn/notify aliases, clearer RunProject/DebugProject commands
- **Terminal helper** (`openTerminal.lua`): Module docs and refactored with local cmd/api aliases

### Changed - Keymaps
- **Reworked keymap files**: Added docstrings to all keymap modules, renamed/moved mappings to avoid conflicts
- **DAP keymaps**: Moved all DAP keymaps from `keymaps/dap.lua` into `plugins/dap.lua` config function (ensures nvim-dap is loaded before keybindings reference it)
- **Quickfix keymaps**: Moved from `<leader>q` prefix to `<leader>x` prefix to avoid conflict with quit
- **LSP navigation**: Switched from Snacks pickers to fzf-lua for `gd`, `gi`, `gr`, `gt`, symbols, and diagnostics

### Changed - Plugins & Integrations
- **DAP** (`dap.lua`): Added Bun launch config, dynamic debug attach (`<leader>jd` with port input), moved all DAP keymaps here
- **Copilot** (`copilot.lua`): Reorganized Copilot/Copilot-cmp/CopilotChat config, added copilot source to nvim-cmp, added CopilotChat keymaps (`<leader>cc`, `<leader>cq`, `<leader>ce`, `<leader>cr`, `<leader>cf`, `<leader>co`, `<leader>cd`, `<leader>ct`, `<leader>cm`)
- **nvim-cmp** (`nvim-cmp.lua`): Added copilot completion source
- **Formatting** (`formatting.lua`): Disabled google-java-format fallback for Java (prefer JDTLS formatter)
- **Java/JDTLS** (`ftplugin/java.lua`): Pinned to JDK 25, switched to mac_arm config, enabled LSP formatter, declared multiple runtimes (JavaSE-17, JavaSE-25)
- **nvim-tree**: Expanded configuration with more custom mappings
- **bufferline**: Updated configuration
- **hlchunk**: Adjusted scope highlighting settings
- **linting**: Configuration tweaks
- **vim-visual-multi**: Updated configuration

### Added - Plugin Stubs
Added minimal plugin configuration stubs for better organization (each plugin in its own file):
`autopairs`, `colorscheme`, `comments`, `crates`, `dadbod`, `diffview`, `dropbar`, `fidget`, `flutter`, `git-blame`, `gitsigns`, `grug-far`, `hardtime`, `ideaMap`, `inc-rename`, `indent-blankline`, `kulala`, `lazygit`, `leetcode`, `lspsaga`, `marks`, `mcphub`, `modicator`, `navbuddy`, `neogit`, `noice`, `nvim-cmp`, `nvim-highlight-colors`, `nvim-jdtls`, `nvim-lightbulb`, `nvim-treesitter-context`, `nvim-treesitter-text-objects`, `nvim-ts-autotag`, `obsidian`, `octo`, `outline`, `overseer`, `package-info`, `portal`, `precognition`, `reactive`, `regexplainer`, `render-markdown`, `satellite`, `snacks`, `ssr`, `substitute`, `surround`, `telescope`, `termcolor`, `tiny-inline-diagnostic`, `tmux`, `todo-comments`, `transparence`, `treesitter`, `treesj`, `trouble`, `ts-comments`, `twilight`, `undotree`, `venv-selector`, `vim-maximizer`, `vimtex`, `wakatime`, `which-key`, `yaml`, `yanky`, `zen-mode`

---

## [2026-01-15] - Bumping Version

### Changed
- General version bump and plugin updates

---

## [2026-01-13] - Fixing Issues

### Fixed
- Multiple bug fixes across configuration
- Fixed issues with closing Neovim
- Fixed rendering issues

---

## [2026-01-10]

### Added
- **Custom Colorscheme**: Using `cargdev-cyberpunk` theme
- **Which-Key Group Names**: Added organized group names for better keymap discoverability
- **Auto-Format on Save**: Enabled with conform.nvim (skips sql, markdown, node_modules)
- **Diagnostic Float on Hover**: Diagnostics appear automatically on cursor hold
- **Safe Buffer Close**: `<leader>bd` prompts for unsaved changes
- **Quickfix Navigation Keymaps**: `<leader>qn/qp/qo/qq/qf/ql`
- **Location List Navigation**: `<leader>ln/lp/lo/lq`
- **Configuration Validation**: Startup checks for Neovim version and required executables
- **Plugin Update Notifications**: Daily lazy.nvim update check

### Changed
- **Session Keymaps**: `<leader>ss` -> `<leader>sS`, `<leader>sr` -> `<leader>sR`
- **Substitute Keymaps**: `<leader>ss` -> `<leader>sl`

### Fixed
- Duplicate window management keymaps (centralized in `window.lua`)
- Duplicate resize keymaps
- Redundant filetype detection
- Double function loading
- Duplicate settings (synmaxcol, foldmethod, foldlevel)

### Removed
- Temporary files (`kkk`, `cleanup_deprecated_adapters.lua`)
- IMPROVEMENTS.md (all issues resolved)
- Commented-out code (tmux keymaps, project_config bootstrap)

---

## [Previous] - Pre-Changelog

### Features Present
- Lazy.nvim plugin management
- Full LSP support with Mason
- nvim-cmp completion
- Snacks.nvim + Telescope file navigation
- nvim-tree file explorer
- LazyGit integration
- GitHub Copilot
- DAP debugging with UI
- Conform.nvim formatting
- Trouble.nvim diagnostics
- Native auto-wrapping configuration
- Custom lualine theme with word count

### Migration History
- Migrated from Telescope to Snacks for primary file navigation
- Kept Telescope for git-specific features and TODOs
- See [Telescope to Snacks Migration](./docs/TELESCOPE_TO_SNACKS_MIGRATION.md) for details

---

*Last Updated: February 10, 2026*
