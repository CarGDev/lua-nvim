# Changelog

All notable changes to this Neovim configuration will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [2026-07-11] - Java Debugging Documentation & Verification

### Added
- **README.md**: Expanded Java debugging section with:
  - Java 21+ requirement note for macOS (JDK 21+ for JDTLS runtime)
  - Explicit `:MasonInstall` commands for `java-debug-adapter`, `java-test`, and `jdtls`
  - Maven Spring Boot debug run command with JVM debug args
  - Debugger verification commands (`nc -zv`, `lsof -i :5005`) with expected output
  - Verified working badge confirming end-to-end setup

---

## [2026-07-10] - Major Cleanup & Platform Guard

### Removed - Plugins
- **copilot.lua** + **copilot-cmp** — GitHub Copilot ghost text and cmp source (codetyper.nvim remains as sole AI assistant)
- **Comment.nvim** — commenting (keymaps retained via native `gc`/`gcc` motions)
- **diffview.nvim** — side-by-side diffs (lazygit conflict resolver covers this)
- **flutter-tools.nvim** — Flutter development (not actively used)
- **git-blame.nvim** — inline blame (gitsigns already provides it)
- **hardtime.nvim** — vim motion training
- **kulala.nvim** — HTTP client (replaced by rest.nvim)
- **leetcode.nvim** — LeetCode integration
- **mcphub.nvim** — MCP server hub
- **navbuddy.nvim** + **nvim-navic** — symbol popup (dropbar + outline.nvim cover it)
- **neogit** — Magit-style git UI (lazygit handles workflows)
- **obsidian.nvim** — Obsidian vault integration
- **precognition.nvim** — vim motion hints
- **telescope.nvim** + telescope-fzf-native + telescope-dap — fully replaced by fzf-lua
- **twilight.nvim** — dim-inactive focus mode
- **undotree.nvim** — visual undo history
- **venv-selector.nvim** — Python venv picker
- **vim-maximizer.nvim** — split maximizer (native `<C-w>_`/`<C-w>|` suffice)
- **vim-visual-multi** — multi-cursor (native `<C-d>` + visual multi retained)
- **wakatime.nvim** — coding time tracking
- **yanky.nvim** — yank ring (native registers suffice)
- **zen-mode.nvim** — distraction-free mode

### Added
- **rest.nvim** — HTTP client replacing kulala (uses `.http` files, treesitter `http` parser)

### Changed - Plugins
- **noice.nvim**: Simplified to cmdline-only mode. Messages use `mini` view, `notify` disabled, LSP progress left to fidget. Removed nvim-notify config block.
- **nvim-tree**: Simplified config — removed custom `FileRemoved` handler, uses `nvim-web-devicons` instead of `vim-devicons`, adds `VimEnter` autocmd to clean up stale `FileExplorer` augroup.
- **nvim-cmp**: Removed copilot source. Added `enabled` function to disable completion in prompt/nofile buffers (pickers, floating inputs).
- **octo.nvim**: Switched picker from `telescope` to `fzf-lua`. Keymaps `<leader>or`/`<leader>oa` → `<leader>oL`/`<leader>oA`.
- **treesitter**: Removed Copilot file disabling guard.

### Changed - Keymaps
| Old | New | Purpose |
|-----|-----|---------|
| `<leader>cs` | `<leader>so` | Symbol outline toggle |
| `<leader>nh` (package-info) | `<leader>nH` | Hide package info (`<leader>nh` kept for `:nohl`) |
| `<leader>sR` (SSR) | `<leader>sX` | Structural search/replace |
| `<leader>or` / `<leader>oa` (octo) | `<leader>oL` / `<leader>oA` | Octo repo list / actions |

### Changed - Platform
- **vimtex**: Added macOS guard (`has('mac')`) — uses Skim on macOS, zathura elsewhere.

### Fixed
- **dropbar**: Rendering fixes.
- **nvim-tree**: Fixed paste-related issues.
- **noice**: Fixed configuration issues.

### Removed - Misc
- `scripts/detect_keymap_conflicts.lua` — keymap conflict detection script.
- `docs/CHANGELOG_OLD.md` — old changelog archive.
- `kkk` — temporary file.

---

## [2026-04-14] - Pruning & Keymap Deconfliction

### Removed - Plugins
- **modicator.nvim** - mode-colored line numbers (already shown by lualine)
- **vim-maximizer** - split maximizer (native `<C-w>_`/`<C-w>|` suffice)
- **precognition.nvim** - vim motion hints (training wheels no longer needed)
- **twilight.nvim** - dim-inactive focus mode (rarely used)
- **git-blame.nvim** - inline blame (gitsigns already provides it)
- **navbuddy.nvim** + **nvim-navic** - symbol popup (dropbar + outline.nvim cover it)
- **FixCursorHold.nvim** - legacy CursorHold perf fix, unneeded on modern Neovim
- **telescope.nvim** + **telescope-fzf-native** + **telescope-dap** - replaced fully by fzf-lua
- **neogit** - duplicate git UI (lazygit handles workflows including conflicts)
- **diffview.nvim** - lazygit's built-in conflict resolver replaces it
- **CopilotChat.nvim** - chat workflow moved to CLI + codetyper.nvim

### Added
- **noice.nvim** restored in cmdline-only mode: centered floating `:` / `/` popup, with messages/popupmenu/LSP features disabled so snacks.notifier and fidget keep owning notifications and LSP progress
- `opt.colorcolumn = "80"` visual guide in `core/options.lua`

### Changed - Keymap Deconfliction
Reserved `<leader>c*` for codetyper. Moved conflicting bindings:

| Old | New | Purpose |
|-----|-----|---------|
| `<leader>cs` | `<leader>so` | Outline toggle |
| `<leader>ca` | `<leader>la` | LSP code action (lspsaga) |
| `<leader>ci` / `<leader>co` | `<leader>li` / `<leader>lo` | LSP incoming/outgoing calls |
| `<leader>cp` / `<leader>cs` / `<leader>cD` / `<leader>cE` | `<leader>ip` / `<leader>iS` / `<leader>iD` / `<leader>iE` | Copilot panel/status/disable/enable |
| `<leader>cx` | `<leader>xc` | Close current tab |
| `<leader>rn` (native) | _removed_ | inc-rename owns `<leader>rn` |
| `<leader>sS` / `<leader>sR` (sessions) | `<leader>Ss` / `<leader>Sr` | SessionSave/Restore (freed `<leader>s*` for search) |
| `<leader>sR` (SSR) | `<leader>sX` | Structural search/replace |
| `<leader>sr` (surround) | _removed, use native `cs<from><to>`_ | nvim-surround replace |
| `<leader>sl` (saga line diag) | _removed_ | redundant with native `<leader>dd` |
| `<leader>or` / `<leader>oa` (octo) | `<leader>oL` / `<leader>oA` | Octo repo list / actions (`<leader>or` kept for Overseer run) |
| `<leader>xt` (TodoTrouble dup) | _removed_ | trouble.lua already registered it |
| `<leader>xq` / `<leader>xl` (quickfix) | `<leader>xQ` / `<leader>xL` | Quickfix close/last (freed for Trouble) |
| `<leader>ts` / `<leader>tS` (showbreak) | `<leader>tB` / `<leader>tb` | Show/hide break indicator |
| `<leader>lo` (lopen) | `<leader>lL` | Location-list open (freed `<leader>lo` for LSP outgoing) |
| `<leader>so` (`:source %`) | `<leader>vr` | Reload current file (freed `<leader>so` for Outline) |
| `<leader>nh` (package-info) | `<leader>nH` | Hide package info (`<leader>nh` kept for `:nohl`) |

Removed all `<leader>z*` / `<leader>c*` CopilotChat bindings.

### Added
- Dashboard actions switched from `:Telescope` to `:FzfLua`.
- `TodoTelescope` → `TodoFzfLua`.
- Octo and Neogit (before its removal) and yaml.nvim: migrated telescope dep to fzf-lua.

### Note
- WakaTime is still configured (`plugins/wakatime.lua`). Dropping it remains on the todo; see the audit at `~/Nextcloud/ObsidianVault/nvim-plugin-audit-2026-04-14.md`.

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

*Last Updated: July 10, 2026*
