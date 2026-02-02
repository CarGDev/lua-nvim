# Complete Keymaps Reference

**Leader Key: `<Space>`**

## Table of Contents
- [Navigation](#navigation)
- [File Management](#file-management)
- [Editing](#editing)
- [LSP & Code Intelligence](#lsp--code-intelligence)
- [Git](#git)
- [Debugging](#debugging)
- [Search & Replace](#search--replace)
- [Tasks & HTTP](#tasks--http)
- [UI & Productivity](#ui--productivity)
- [Language Specific](#language-specific)
- [Window Management](#window-management)

---

## Navigation

### Flash (Jump Anywhere)
| Key | Mode | Action |
|-----|------|--------|
| `s` | n, x, o | Flash jump (type chars to jump) |
| `S` | n, x, o | Flash treesitter select |
| `r` | o | Remote flash |
| `R` | o, x | Treesitter search |
| `<C-s>` | c | Toggle flash in search |

### Harpoon (Quick File Marks)
| Key | Action |
|-----|--------|
| `<leader>ha` | Add current file to harpoon |
| `<leader>hh` | Open harpoon menu |
| `<leader>hp` | Previous harpoon file |
| `<leader>hn` | Next harpoon file |

### Portal (Jumplist Navigation)
| Key | Action |
|-----|--------|
| `<leader>pj` | Portal jumplist backward |
| `<leader>pk` | Portal jumplist forward |
| `<leader>pc` | Portal changelist backward |
| `<leader>pq` | Portal quickfix backward |

### Navbuddy (Code Structure)
| Key | Action |
|-----|--------|
| `<leader>nb` | Open Navbuddy |

Inside Navbuddy:
- `h/j/k/l` - Navigate
- `<Enter>` - Select
- `0` - Go to root
- `q` - Close

### Telescope
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fs` | Live grep (search text) |
| `<leader>fg` | Git files |
| `<leader>fF` | Find all files |
| `<leader>fr` | Recent files |

---

## File Management

### File Explorer (nvim-tree)
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>ee` | Toggle file explorer |
| `<leader>nt` | Find current file in tree |
| `<leader>ec` | Collapse file explorer |
| `<leader>er` | Refresh file explorer |

Inside nvim-tree:
- `o` - Open file
- `s` - Open in vertical split
- `i` - Open in horizontal split
- `a` - Create new file
- `r` - Rename
- `d` - Delete
- `x` - Cut
- `y` - Copy
- `p` - Paste
- `u` - Go up one directory

### Buffers
| Key | Action |
|-----|--------|
| `<S-l>` | Next buffer |
| `<S-h>` | Previous buffer |
| `<leader>bd` | Close buffer |
| `<leader>bD` | Force close buffer |

---

## Editing

### Multi-Cursor (vim-visual-multi)
| Key | Action |
|-----|--------|
| `<C-d>` | Select word under cursor / Add next occurrence |
| `<C-Down>` | Add cursor below |
| `<C-Up>` | Add cursor above |
| `<C-S-l>` | Select all occurrences |
| `<C-x>` | Skip current match |
| `<C-p>` | Remove current cursor |
| `<Esc>` | Exit multi-cursor |

### Yanky (Yank Ring)
| Key | Mode | Action |
|-----|------|--------|
| `y` | n, x | Yank |
| `p` | n, x | Put after |
| `P` | n, x | Put before |
| `<leader>yh` | n | Open yank history |
| `]p` | n | Put indented after |
| `[p` | n | Put indented before |

### Treesj (Split/Join)
| Key | Action |
|-----|--------|
| `<leader>tj` | Toggle split/join |
| `<leader>ts` | Split code block |
| `<leader>tJ` | Join code block |

### Dial (Smart Increment)
| Key | Mode | Action |
|-----|------|--------|
| `<C-a>` | n, v | Increment |
| `<C-x>` | n, v | Decrement |
| `g<C-a>` | n, v | Increment (sequence) |
| `g<C-x>` | n, v | Decrement (sequence) |

Works on: numbers, booleans, dates, CSS units, HTTP methods, operators, and more!

### Surround
| Key | Action |
|-----|--------|
| `ys{motion}{char}` | Add surround |
| `ds{char}` | Delete surround |
| `cs{old}{new}` | Change surround |

Examples:
- `ysiw"` - Surround word with quotes
- `ds"` - Delete surrounding quotes
- `cs"'` - Change " to '

### Comments
| Key | Mode | Action |
|-----|------|--------|
| `gcc` | n | Toggle line comment |
| `gc` | v | Toggle comment selection |
| `gbc` | n | Toggle block comment |
| `<leader>/` | n, v | Toggle comment |

### Substitute
| Key | Action |
|-----|--------|
| `<leader>sub` | Substitute with motion |
| `<leader>sl` | Substitute line |
| `<leader>S` | Substitute to end of line |

### Undo Tree
| Key | Action |
|-----|--------|
| `<leader>tu` | Toggle undo tree |

---

## LSP & Code Intelligence

### LSP Saga
| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `gd` | Peek definition |
| `gD` | Go to definition |
| `gt` | Peek type definition |
| `gT` | Go to type definition |
| `gh` | LSP finder (refs + impl) |
| `gr` | Rename |
| `gR` | Rename (project-wide) |
| `<leader>ca` | Code actions |
| `<leader>sl` | Show line diagnostics |
| `<leader>sc` | Show cursor diagnostics |
| `<leader>sb` | Show buffer diagnostics |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>ci` | Incoming calls |
| `<leader>co` | Outgoing calls |
| `<leader>so` | Toggle LSP outline |

### Inc-Rename (Live Preview)
| Key | Action |
|-----|--------|
| `<leader>rn` | Rename with live preview |

### Outline
| Key | Action |
|-----|--------|
| `<leader>cs` | Toggle symbol outline |

### Formatting
| Key | Action |
|-----|--------|
| `<leader>f` | Format buffer |
| `<leader>mm` | Format with conform |

### Regexplainer
| Key | Action |
|-----|--------|
| `<leader>rx` | Toggle regex explanation |

---

## Git

### LazyGit
| Key | Action |
|-----|--------|
| `<leader>gg` | Open LazyGit |

### Neogit
| Key | Action |
|-----|--------|
| `<leader>gn` | Open Neogit |
| `<leader>gnc` | Neogit commit |
| `<leader>gnp` | Neogit push |
| `<leader>gnl` | Neogit pull |
| `<leader>gnb` | Neogit branch |

### Diffview
| Key | Action |
|-----|--------|
| `<leader>gd` | Open diffview |
| `<leader>gD` | Close diffview |
| `<leader>gh` | File history (current file) |
| `<leader>gH` | File history (repo) |

### Git Blame
| Key | Action |
|-----|--------|
| `<leader>gB` | Toggle git blame |
| `<leader>gbc` | Copy commit SHA |
| `<leader>gbo` | Open commit URL |
| `<leader>gbf` | Open file URL |

### Octo (GitHub)
| Key | Action |
|-----|--------|
| `<leader>oi` | List issues |
| `<leader>oI` | Create issue |
| `<leader>op` | List PRs |
| `<leader>oP` | Create PR |
| `<leader>or` | List repos |
| `<leader>os` | Search issues/PRs |
| `<leader>oa` | Octo actions |

### Gitsigns
| Key | Action |
|-----|--------|
| `]c` | Next hunk |
| `[c` | Previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |

---

## Debugging

### DAP (Debug Adapter Protocol)
| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dcc` | Start/Continue debugging |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dr` | Toggle REPL |
| `<leader>dl` | Run last debug config |
| `<leader>du` | Toggle DAP UI |
| `<leader>dt` | Float element |
| `<leader>dco` | DAP commands |
| `<leader>dcf` | List DAP configs |
| `<leader>dcb` | List breakpoints |

### Java Debugging
| Key | Action |
|-----|--------|
| `<leader>jd` | Debug class |
| `<leader>jt` | Test class |
| `<leader>jn` | Test nearest method |
| `<leader>jr` | Run Java file |

---

## Search & Replace

### Grug-Far (Project-Wide)
| Key | Mode | Action |
|-----|------|--------|
| `<leader>sr` | n | Open search & replace |
| `<leader>sR` | n | Search current word |
| `<leader>sR` | v | Search selection |

Inside Grug-Far:
- `<localleader>r` - Replace
- `<localleader>R` - Replace all
- `<Enter>` - Go to location
- `q` - Close

### SSR (Structural Search/Replace)
| Key | Mode | Action |
|-----|------|--------|
| `<leader>sR` | n, x | Structural search/replace |

---

## Tasks & HTTP

### Overseer (Task Runner)
| Key | Action |
|-----|--------|
| `<leader>or` | Run task |
| `<leader>ot` | Toggle task list |
| `<leader>oa` | Task action |
| `<leader>oq` | Quick action |
| `<leader>ob` | Build |
| `<leader>oc` | Run shell command |

### Kulala (HTTP Client)
| Key | Action |
|-----|--------|
| `<leader>kr` | Run HTTP request |
| `<leader>ka` | Run all requests |
| `<leader>kp` | Previous request |
| `<leader>kn` | Next request |
| `<leader>ki` | Inspect request |
| `<leader>kt` | Toggle headers/body |
| `<leader>kc` | Copy as cURL |
| `<leader>ke` | Set environment |

---

## UI & Productivity

### Zen Mode & Focus
| Key | Action |
|-----|--------|
| `<leader>zz` | Toggle Zen mode |
| `<leader>zt` | Toggle Twilight (dim code) |

### Session
| Key | Action |
|-----|--------|
| `<leader>qs` | Restore session |
| `<leader>ql` | Restore last session |
| `<leader>qd` | Don't save session |

### Learning Vim
| Key | Action |
|-----|--------|
| `<leader>ht` | Toggle Hardtime |
| `<leader>vp` | Toggle Precognition hints |
| `<leader>vP` | Peek Precognition |

### Screenkey (Demo Mode)
| Key | Action |
|-----|--------|
| `<leader>sk` | Toggle Screenkey |

### Trouble (Diagnostics)
| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle Trouble |
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `<leader>xl` | Location list |
| `<leader>xq` | Quickfix list |
| `<leader>xt` | Open TODOs in Trouble |

### Todo Comments
| Key | Action |
|-----|--------|
| `]t` | Next TODO |
| `[t` | Previous TODO |

---

## Language Specific

### Python
| Key | Action |
|-----|--------|
| `<leader>vs` | Select Python venv |
| `<leader>vc` | Select cached venv |

### JavaScript/TypeScript (package.json)
| Key | Action |
|-----|--------|
| `<leader>ns` | Show package versions |
| `<leader>nh` | Hide package info |
| `<leader>nu` | Update package |
| `<leader>nd` | Delete package |
| `<leader>ni` | Install package |
| `<leader>nc` | Change version |

### Rust (Cargo.toml)
| Key | Action |
|-----|--------|
| `<leader>ct` | Toggle crates |
| `<leader>cr` | Reload crates |
| `<leader>cv` | Show versions popup |
| `<leader>cf` | Show features popup |
| `<leader>cd` | Show dependencies |
| `<leader>cu` | Update crate |
| `<leader>cU` | Upgrade crate |

### LeetCode
| Key | Action |
|-----|--------|
| `<leader>lr` | Run code |
| `<leader>ls` | Submit code |
| `<leader>ld` | Daily challenge |
| `<leader>ll` | List problems |
| `<leader>lc` | Open console |
| `<leader>lh` | Show hints |

---

## Window Management

### Splits
| Key | Action |
|-----|--------|
| `<leader>sv` | Split vertical |
| `<leader>sh` | Split horizontal |
| `<leader>se` | Equal splits |
| `<leader>sx` | Close split |
| `<leader>sm` | Maximize split |

### Navigation
| Key | Action |
|-----|--------|
| `<C-h>` | Move to left window |
| `<C-j>` | Move to down window |
| `<C-k>` | Move to up window |
| `<C-l>` | Move to right window |

### Resize
| Key | Action |
|-----|--------|
| `<C-Up>` | Increase height |
| `<C-Down>` | Decrease height |
| `<C-Left>` | Decrease width |
| `<C-Right>` | Increase width |

---

## General

| Key | Action |
|-----|--------|
| `jj` | Exit insert mode |
| `<leader>nh` | Clear search highlights |
| `<leader>w` | Save file |
| `<leader>q` | Close file |
| `<leader>Q` | Quit all |
| `<leader>xa` | Save and close all |

---

## Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Plugin manager |
| `:Mason` | LSP server manager |
| `:Navbuddy` | Code navigation |
| `:Outline` | Symbol outline |
| `:Neogit` | Git interface |
| `:DiffviewOpen` | Diff view |
| `:GrugFar` | Search & replace |
| `:Octo` | GitHub |
| `:OverseerRun` | Run tasks |
| `:ZenMode` | Zen mode |
| `:Hardtime toggle` | Toggle hardtime |
| `:Screenkey` | Show keypresses |
| `:TSJToggle` | Toggle split/join |
