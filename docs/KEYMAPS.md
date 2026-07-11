# Complete Keymaps Reference

**Leader Key: `<Space>`**

## Table of Contents
- [General](#general)
- [Personal Workflow](#personal-workflow)
- [Navigation (fzf-lua)](#navigation-fzf-lua)
- [LSP & Code Intelligence](#lsp--code-intelligence)
- [File Management](#file-management)
- [Editing](#editing)
- [Git](#git)
- [Debugging (DAP)](#debugging-dap)
- [Codetyper & AI](#codetyper--ai)
- [Terminal](#terminal)
- [Window Management](#window-management)
- [HTTP Client (rest.nvim)](#http-client-restnvim)
- [Text Wrapping](#text-wrapping)
- [Folding (nvim-ufo)](#folding-nvim-ufo)
- [Session Management](#session-management)
- [Commands](#commands)

---

## General

| Key | Mode | Action |
|-----|------|--------|
| `jj` | i | Exit insert mode |
| `<leader>nh` | n | Clear search highlights |
| `<leader>Q` | n | Quit all |

---

## Personal Workflow

### File Management
| Key | Mode | Action |
|-----|------|--------|
| `<leader>w` | n | Save file |
| `<leader>q` | n | Quit |
| `<leader>xa` | n | Save and close all |
| `<leader>vr` | n | Reload current file (`:source %`) |
| `<leader>no` | n | Clear search highlight |

### Editing Shortcuts
| Key | Mode | Action |
|-----|------|--------|
| `<leader>u` | n | Select entire file |
| `<leader>4` | n | Duplicate line below |
| `<leader>+` | n | Increment number |
| `<leader>-` | n | Decrement number |
| `<leader>sy` | n | Re-indent entire file |
| `<C-e>` | n | Fast scroll down (10 lines) |
| `<C-y>` | n | Fast scroll up (10 lines) |

### Buffer Management
| Key | Mode | Action |
|-----|------|--------|
| `<leader>bd` | n | Close buffer (safe, prompts if modified) |
| `<leader>bD` | n | Force close buffer |
| `<C-p>` | n | Next buffer |
| `<C-n>` | n | Previous buffer |

### Coding Shortcuts
| Key | Mode | Action |
|-----|------|--------|
| `<leader>re` | n | Insert React import at top |
| `<leader>,` | n | Add comma at end of line |
| `<leader>;` | n | Add semicolon at end of line |
| `<leader>xr` | n | Run file with Node.js |

### Quickfix Navigation
| Key | Mode | Action |
|-----|------|--------|
| `<leader>xn` | n | Next quickfix item |
| `<leader>xp` | n | Previous quickfix item |
| `<leader>xo` | n | Open quickfix list |
| `<leader>xQ` | n | Close quickfix list |
| `<leader>xf` | n | First quickfix item |
| `<leader>xL` | n | Last quickfix item |

### Location List Navigation
| Key | Mode | Action |
|-----|------|--------|
| `<leader>ln` | n | Next location item |
| `<leader>lp` | n | Previous location item |
| `<leader>lL` | n | Open location list |
| `<leader>lq` | n | Close location list |

---

## Navigation (fzf-lua)

### File Navigation
| Key | Mode | Action |
|-----|------|--------|
| `<leader>ff` | n | Find files |
| `<leader>fs` | n | Live grep |
| `<leader>fr` | n | Recent files |

### Buffer & Utility Search
| Key | Mode | Action |
|-----|------|--------|
| `<leader>fb` | n | Find buffers |
| `<leader>fh` | n | Help tags |
| `<leader>fm` | n | Find marks |
| `<leader>fk` | n | Find keymaps |
| `<leader>fc` | n | Find commands |

### Git
| Key | Mode | Action |
|-----|------|--------|
| `<leader>fG` | n | Git commits |
| `<leader>fB` | n | Git buffer commits |
| `<leader>fg` | n | Git branches |
| `<leader>gs` | n | Git status |

### TODO Search
| Key | Mode | Action |
|-----|------|--------|
| `<leader>ft` | n | Find TODOs (TodoFzfLua) |

---

## LSP & Code Intelligence

### Navigation (fzf-lua)
| Key | Mode | Action |
|-----|------|--------|
| `gd` | n | Go to definition |
| `gi` | n | Go to implementation |
| `gr` | n | Show references |
| `gt` | n | Go to type definition |

### Symbols
| Key | Mode | Action |
|-----|------|--------|
| `<leader>ds` | n | Document symbols |
| `<leader>lw` | n | Workspace symbols |

### Code Actions & Rename
| Key | Mode | Action |
|-----|------|--------|
| `<leader>la` | n, v | LSP code actions (lspsaga) |
| `<leader>li` | n | LSP incoming calls |
| `<leader>lo` | n | LSP outgoing calls |
| `<leader>ld` | n | LSP cursor/buffer diagnostics (lspsaga) |
| `<leader>rn` | n | Rename symbol (inc-rename) |
| `H` | n | Hover documentation |

### Diagnostics
| Key | Mode | Action |
|-----|------|--------|
| `<leader>D` | n | Workspace diagnostics |
| `<leader>dd` | n | Line diagnostics (float) |
| `[d` | n | Previous diagnostic |
| `]d` | n | Next diagnostic |

### Formatting
| Key | Mode | Action |
|-----|------|--------|
| `<leader>mm` | n, v | Format with conform |

---

## File Management

### File Explorer (nvim-tree)
| Key | Mode | Action |
|-----|------|--------|
| `<leader>e` | n | Toggle file explorer |

Inside nvim-tree:
| Key | Action |
|-----|--------|
| `o` | Open file |
| `s` | Open in vertical split |
| `i` | Open in horizontal split |
| `a` | Create new file |
| `r` | Rename |
| `d` | Delete |
| `x` | Cut |
| `y` | Copy |
| `p` | Paste |
| `u` | Go up one directory |
| `<leader>f` | Change root to node |

### Buffer Cycling
| Key | Mode | Action |
|-----|------|--------|
| `<S-l>` | n | Next buffer |
| `<S-h>` | n | Previous buffer |

---

## Editing

### Comments (Comment.nvim)
| Key | Mode | Action |
|-----|------|--------|
| `<leader>/` | n, v | Toggle comment |
| `gcc` | n | Toggle line comment |
| `gc` | n | Toggle comment |
| `gco` | n | Insert comment below |
| `gcO` | n | Insert comment above |
| `gcA` | n | Insert comment at end of line |
| `gb` | n | Toggle block comment |
| `gbc` | n | Toggle block comment |

### Substitute (substitute.nvim)
| Key | Mode | Action |
|-----|------|--------|
| `<leader>sub` | n | Substitute with motion |
| `<leader>sl` | n | Substitute line |
| `<leader>S` | n | Substitute to end of line |

### Surround (nvim-surround)
| Key | Mode | Action |
|-----|------|--------|
| `<leader>sa` | n | Add surrounding |
| `<leader>sd` | n | Delete surrounding |
| `cs<from><to>` | n | Replace surrounding (native nvim-surround) |
| `ys` | n | Add surrounding (classic) |
| `yss` | n | Add surrounding to line |
| `yS` | n | Add surrounding on new lines |
| `ySS` | n | Add surrounding to line on new lines |

### Console.log
| Key | Mode | Action |
|-----|------|--------|
| `<leader>cl` | n | Insert console.log snippet |

### TODO Comments
| Key | Mode | Action |
|-----|------|--------|
| `<leader>xt` | n | Open TODOs in Trouble |

---

## Git

### LazyGit
| Key | Mode | Action |
|-----|------|--------|
| `<leader>gg` | n | Open LazyGit |

### Gitsigns (buffer-local)
| Key | Mode | Action |
|-----|------|--------|
| `]h` | n | Next hunk |
| `[h` | n | Previous hunk |
| `<leader>hs` | n, v | Stage hunk |
| `<leader>hr` | n, v | Reset hunk |
| `<leader>hS` | n | Stage buffer |
| `<leader>hR` | n | Reset buffer |
| `<leader>hu` | n | Undo stage hunk |
| `<leader>hp` | n | Preview hunk |
| `<leader>hb` | n | Blame line (full) |
| `<leader>hB` | n | Toggle line blame |
| `<leader>hd` | n | Diff this |
| `<leader>hD` | n | Diff this ~ |
| `ih` | o, x | Select hunk (text object) |

### Trouble (Diagnostics Panel)
| Key | Mode | Action |
|-----|------|--------|
| `<leader>Xx` | n | Toggle Trouble |
| `<leader>Xw` | n | Workspace diagnostics |
| `<leader>Xd` | n | Document diagnostics |
| `<leader>Xl` | n | Location list |
| `<leader>Xq` | n | Quickfix list |

---

## Debugging (DAP)

### Debug Control
| Key | Mode | Action |
|-----|------|--------|
| `<leader>dcr` | n | Start/Continue debugging |
| `<leader>do` | n | Step over |
| `<leader>di` | n | Step into |
| `<leader>dot` | n | Step out |
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dB` | n | Set conditional breakpoint |
| `<leader>dr` | n | Open REPL |
| `<leader>dl` | n | Run last debug config |
| `<leader>du` | n | Toggle DAP UI |
| `<leader>dq` | n | Stop debugging |
| `<leader>drt` | n | Reset DAP UI layout |

### Debug Navigation
| Key | Mode | Action |
|-----|------|--------|
| `<leader>dcf` | n | List/select DAP configs |
| `<leader>dcb` | n | List breakpoints |
| `<leader>dco` | n | DAP Commands (REPL) |

### Dynamic Attach
| Key | Mode | Action |
|-----|------|--------|
| `<leader>jd` | n | Debug attach (dynamic port, Bun/Node) |

### Project Run/Debug
| Key | Mode | Action |
|-----|------|--------|
| `<leader>pr` | n | Run project |
| `<leader>pd` | n | Debug project |
| `<leader>p` | n | Run project (quick) |

---

## Codetyper & AI

### Codetyper (custom multi-provider AI assistant)
| Key | Mode | Action |
|-----|------|--------|
| `<leader>co` | n | Open Coder view |
| `<leader>ct` | n | Toggle Coder view |
| `<leader>cp` | n | Process prompt |
| `<leader>cs` | n | Show status |
| `<leader>cf` | n | Switch focus |
| `<leader>cv` | n | View tree |
| `<leader>cr` | n | Refresh tree |
| `<leader>ca` | n | Open Ask panel |
| `<leader>cx` | n | Clear Ask history |
| `<leader>cd` | n | Open Diff Review |
| `<leader>ctt` | n, v | Transform tag(s) at cursor/selection |

### Java (nvim-jdtls — buffer-local, Java files only)
| Key | Mode | Action |
|-----|------|--------|
| `<leader>jco` | n | Organize imports |
| `<leader>jrv` | n, v | Extract variable |
| `<leader>jrc` | n, v | Extract constant |
| `<leader>jrm` | v | Extract method |

Copilot and CopilotChat were removed — use the CLI or codetyper for AI workflows.

---

## Terminal

### ToggleTerm
| Key | Mode | Action |
|-----|------|--------|
| `<leader>tf` | n | Float terminal |
| `<leader>th` | n | Horizontal split terminal |
| `<leader>tv` | n | Vertical split terminal |

### Terminal Mode
| Key | Mode | Action |
|-----|------|--------|
| `<C-h>` | t | Switch to left window |
| `<C-t>` | t | Close terminal |
| `<C-\><C-\>` | t | Escape terminal mode |

---

## Window Management

### Splits
| Key | Mode | Action |
|-----|------|--------|
| `<leader>sv` | n | Split vertical |
| `<leader>sh` | n | Split horizontal |
| `<leader>se` | n | Make splits equal |
| `<leader>sx` | n | Close current split |

### Tabs
| Key | Mode | Action |
|-----|------|--------|
| `<leader>to` | n | Open new tab |
| `<leader>xc` | n | Close current tab |
| `<leader>tn` | n | Next tab |
| `<leader>tp` | n | Previous tab |
| `<leader>tt` | n | Open buffer in new tab |

### Resize Splits
| Key | Mode | Action |
|-----|------|--------|
| `<C-h>` | n | Increase width (+5) |
| `<C-l>` | n | Decrease width (-5) |
| `<C-k>` | n | Increase height (+5) |
| `<C-j>` | n | Decrease height (-5) |

---

## HTTP Client (rest.nvim)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>kr` | n | Run HTTP request (in .http file) |
| `<leader>ka` | n | Run all HTTP requests |

---

## Text Wrapping

### Wrapping Controls
| Key | Mode | Action |
|-----|------|--------|
| `<leader>tw` | n | Toggle line wrapping |
| `<leader>tl` | n | Toggle line break |
| `<leader>tx` | n | Show 80-char column guide |
| `<leader>tH` | n | Hide column guide |

### Format Text
| Key | Mode | Action |
|-----|------|--------|
| `<leader>tpg` | n | Format paragraph |
| `<leader>tf` | v | Format selection |
| `<leader>tF` | n | Format entire file |

### Text Width
| Key | Mode | Action |
|-----|------|--------|
| `<leader>t80` | n | Set textwidth to 80 |
| `<leader>t100` | n | Set textwidth to 100 |
| `<leader>t120` | n | Set textwidth to 120 |
| `<leader>t0` | n | Disable textwidth |

### Auto-wrap Controls
| Key | Mode | Action |
|-----|------|--------|
| `<leader>ta` | n | Enable auto-wrap text |
| `<leader>tA` | n | Disable auto-wrap text |
| `<leader>tc` | n | Enable auto-wrap comments |
| `<leader>tC` | n | Disable auto-wrap comments |
| `<leader>ti` | n | Toggle break indent |
| `<leader>tB` | n | Show break indicator |
| `<leader>tb` | n | Hide break indicator |

---

## Folding (nvim-ufo)

| Key | Mode | Action |
|-----|------|--------|
| `zR` | n | Open all folds |
| `zM` | n | Close all folds |
| `zr` | n | Open folds except kinds |
| `zm` | n | Close folds by level |
| `K` | n | Peek fold or LSP hover |

---

## Session Management

| Key | Mode | Action |
|-----|------|--------|
| `<leader>Ss` | n | Session: Save |
| `<leader>Sr` | n | Session: Restore |

---

## Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Plugin manager |
| `:Mason` | LSP server manager |
| `:Outline` | Symbol outline |
| `:LazyGit` | Git TUI (merge conflicts included) |
| `:GrugFar` | Search & replace |
| `:Octo` | GitHub PRs/issues |
| `:OverseerRun` | Run tasks |
| `:ZenMode` | Distraction-free mode |
| `:Hardtime toggle` | Toggle vim training |
| `:TSJToggle` | Toggle split/join |
| `:WordCount` | Show word count (excluding symbols) |
| `:RunProject` | Run project command |
| `:DebugProject` | Debug project command |

---

*Last Updated: July 10, 2026*
