--- Plugin-specific keymaps. Centralizes keybindings for third-party plugins: NvimTree, Comment,
--- LazyGit, DAP/DAP-UI, Trouble, ToggleTerm, sessions, formatting,
--- Substitute, Surround, LeetCode, Telescope/safe_files, database clients,
--- text wrapping, and auto-wrap controls.
--- @module keymaps.plugins

local keymap = vim.keymap

-- =============================================================================
-- PLUGIN KEYMAPS
-- =============================================================================

--- Toggle the NvimTree file explorer sidebar.
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

--- Buffer management — cycle through listed buffers with Shift+L / Shift+H.
keymap.set("n", "<S-l>", ":bnext<CR>", { noremap = true, silent = true })
keymap.set("n", "<S-h>", ":bprevious<CR>", { noremap = true, silent = true })

--- Comment.nvim — toggle line/block comments in normal and visual mode.
keymap.set(
  "n",
  "<leader>/",
  "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>",
  { desc = "Toggle comment" }
)
keymap.set(
  "v",
  "<leader>/",
  "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
  { desc = "Toggle comment" }
)

--- Open LazyGit in a floating terminal.
keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })

--- Trouble — diagnostics, workspace errors, location list, and quickfix viewer.
keymap.set("n", "<leader>Xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
keymap.set("n", "<leader>Xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace diagnostics" })
keymap.set("n", "<leader>Xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document diagnostics" })
keymap.set("n", "<leader>Xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Location list" })
keymap.set("n", "<leader>Xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix list" })

--- ToggleTerm — open terminals as float, horizontal, or vertical splits.
keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" })
keymap.set(
  "n",
  "<leader>th",
  "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
  { desc = "ToggleTerm horizontal split" }
)
keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "ToggleTerm vertical split" })

--- Session management — under <leader>S* to keep <leader>s* for search.
keymap.set("n", "<leader>Ss", "<cmd>SessionSave<cr>", { desc = "Session: Save" })
keymap.set("n", "<leader>Sr", "<cmd>SessionRestore<cr>", { desc = "Session: Restore" })

--- Format the current buffer using the attached LSP formatter.
--- TODO: add format buffer keymap
--- keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<cr>", { desc = "Format buffer" })

--- Substitute.nvim — operator, line, and end-of-line substitution.
keymap.set("n", "<leader>sub", "<cmd>lua require('substitute').operator()<cr>", { desc = "Substitute: With motion" })
keymap.set("n", "<leader>sl", "<cmd>lua require('substitute').line()<cr>", { desc = "Substitute: Line" })
keymap.set("n", "<leader>S", "<cmd>lua require('substitute').eol()<cr>", { desc = "Substitute: To end of line" })

--- nvim-surround — add, delete, and replace surrounding pairs.
keymap.set("n", "<leader>sa", "<cmd>lua require('nvim-surround').surround_add()<cr>", { desc = "Add surrounding" })
keymap.set(
  "n",
  "<leader>sd",
  "<cmd>lua require('nvim-surround').surround_delete()<cr>",
  { desc = "Delete surrounding" }
)
-- nvim-surround replace is available via native `cs<from><to>` (e.g. cs"')


-- Git conflicts (moved to lua/cargdev/core/keymaps/gitconflict.lua)

--- Run project command via project_commands module.
keymap.set(
  "n",
  "<leader>p",
  "<cmd>lua require('cargdev.core.function.project_commands').run_project()<cr>",
  { desc = "Run project" }
)

--- Insert a `console.log()` snippet on the line below and enter insert mode.
keymap.set("n", "<leader>cl", "oconsole.log()<ESC>i", { desc = "Add console.log" })

--- nvim-surround classic-style mappings (ys, yss, yS, ySS).
keymap.set("n", "ys", "<cmd>lua require('nvim-surround').surround_add()<cr>", { desc = "Add surrounding" })
keymap.set("n", "yss", "<cmd>lua require('nvim-surround').surround_add()<cr>", { desc = "Add surrounding to line" })
keymap.set("n", "yS", "<cmd>lua require('nvim-surround').surround_add()<cr>", { desc = "Add surrounding on new lines" })
keymap.set(
  "n",
  "ySS",
  "<cmd>lua require('nvim-surround').surround_add()<cr>",
  { desc = "Add surrounding to line on new lines" }
)

--- Comment.nvim classic-style mappings (gc, gcc, gco, gcO, gcA, gb, gbc).
keymap.set("n", "gc", "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>", { desc = "Toggle comment" })
keymap.set(
  "n",
  "gcc",
  "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>",
  { desc = "Toggle current line comment" }
)
keymap.set("n", "gco", "<cmd>lua require('Comment.api').insert_below()<cr>", { desc = "Insert comment below" })
keymap.set("n", "gcO", "<cmd>lua require('Comment.api').insert_above()<cr>", { desc = "Insert comment above" })
keymap.set("n", "gcA", "<cmd>lua require('Comment.api').insert_eol()<cr>", { desc = "Insert comment at end of line" })
keymap.set(
  "n",
  "gb",
  "<cmd>lua require('Comment.api').toggle_current_blockwise()<cr>",
  { desc = "Toggle block comment" }
)
keymap.set(
  "n",
  "gbc",
  "<cmd>lua require('Comment.api').toggle_current_blockwise()<cr>",
  { desc = "Toggle current block comment" }
)

-- =============================================================================
-- TELESCOPE KEYMAPS (Enhanced with safe file searching)
-- =============================================================================

-- =============================================================================
-- DATABASE KEYMAPS (Temporarily disabled to prevent conflicts)
-- =============================================================================

-- -- Dadbod UI
-- keymap.set("n", "<leader>du", "<cmd>DBUI<CR>", { desc = "Open Database UI" })
-- keymap.set("n", "<leader>dul", "<cmd>DBUILastQueryInfo<CR>", { desc = "Show last query info" })
-- keymap.set("n", "<leader>duf", "<cmd>DBUIFindBuffer<CR>", { desc = "Find database buffer" })

-- -- Database connections
-- keymap.set("n", "<leader>dua", "<cmd>DBUIAddConnection<CR>", { desc = "Add database connection" })
-- keymap.set("n", "<leader>dur", "<cmd>DBUIRenameBuffer<CR>", { desc = "Rename database buffer" })
-- keymap.set("n", "<leader>dud", "<cmd>DBUIRefresh<CR>", { desc = "Refresh database" })

-- -- Database queries
-- keymap.set("n", "<leader>due", "<cmd>DBExecute<CR>", { desc = "Execute SQL query" })
-- keymap.set("n", "<leader>dus", "<cmd>DBSelect<CR>", { desc = "Select SQL query" })
-- keymap.set("n", "<leader>dui", "<cmd>DBInsert<CR>", { desc = "Insert SQL query" })
-- keymap.set("n", "<leader>duu", "<cmd>DBUpdate<CR>", { desc = "Update SQL query" })
-- keymap.set("n", "<leader>dudel", "<cmd>DBDelete<CR>", { desc = "Delete SQL query" })

-- -- Database table operations
-- keymap.set("n", "<leader>dut", "<cmd>DBUITableCreate<CR>", { desc = "Create table" })
-- keymap.set("n", "<leader>duti", "<cmd>DBUITableIndex<CR>", { desc = "Show table indexes" })
-- keymap.set("n", "<leader>dutc", "<cmd>DBUITableCount<CR>", { desc = "Count table rows" })
-- keymap.set("n", "<leader>dutx", "<cmd>DBUITableExplain<CR>", { desc = "Explain table query" })
-- keymap.set("n", "<leader>dutz", "<cmd>DBUITableSize<CR>", { desc = "Show table size" })

-- -- SQL formatting
-- keymap.set("n", "<leader>duf", "<cmd>SQLFormat<CR>", { desc = "Format SQL query" })

-- -- Database utilities
-- keymap.set("n", "<leader>duh", "<cmd>DBUIHideNotifications<CR>", { desc = "Hide database notifications" })
-- keymap.set("n", "<leader>dus", "<cmd>DBUISaveBuffer<CR>", { desc = "Save database buffer" })
-- keymap.set("n", "<leader>dul", "<cmd>DBUILoadBuffer<CR>", { desc = "Load database buffer" })

--- Redis CLI — open, list keys, show info.
keymap.set("n", "<leader>rds", "<cmd>Redis<CR>", { desc = "Open Redis" })
keymap.set("n", "<leader>rdk", "<cmd>RedisKeys<CR>", { desc = "Show Redis keys" })
keymap.set("n", "<leader>rdi", "<cmd>RedisInfo<CR>", { desc = "Show Redis info" })

--- MongoDB — open shell, connect, disconnect.
keymap.set("n", "<leader>mdb", "<cmd>MongoDB<CR>", { desc = "Open MongoDB" })
keymap.set("n", "<leader>mdc", "<cmd>MongoDBConnect<CR>", { desc = "Connect to MongoDB" })
keymap.set("n", "<leader>mdd", "<cmd>MongoDBDisconnect<CR>", { desc = "Disconnect from MongoDB" })

-- =============================================================================
-- NATIVE AUTO WRAPPER KEYMAPS
-- =============================================================================

--- Text wrapping controls — toggle wrap, linebreak, and column guide.
keymap.set("n", "<leader>tw", "<cmd>set wrap!<cr>", { desc = "Toggle line wrapping" })
keymap.set("n", "<leader>tl", "<cmd>set linebreak!<cr>", { desc = "Toggle line break" })
keymap.set("n", "<leader>tx", "<cmd>set colorcolumn=80<cr>", { desc = "Show 80 char column" })
keymap.set("n", "<leader>tH", "<cmd>set colorcolumn=<cr>", { desc = "Hide column guide" })

--- Format text using native Neovim `gq` command (paragraph, selection, file).
keymap.set("n", "<leader>tpg", "gqap", { desc = "Format paragraph" })
keymap.set("v", "<leader>tf", "gq", { desc = "Format selection" })
keymap.set("n", "<leader>tF", "gggqG", { desc = "Format entire file" })

--- Text width adjustments — set to 80, 100, 120, or disable (0).
keymap.set("n", "<leader>t80", "<cmd>set textwidth=80<cr>", { desc = "Set text width to 80" })
keymap.set("n", "<leader>t100", "<cmd>set textwidth=100<cr>", { desc = "Set text width to 100" })
keymap.set("n", "<leader>t120", "<cmd>set textwidth=120<cr>", { desc = "Set text width to 120" })
keymap.set("n", "<leader>t0", "<cmd>set textwidth=0<cr>", { desc = "Disable text width" })

--- Auto-wrap controls — toggle `formatoptions` flags for text and comments.
keymap.set("n", "<leader>ta", "<cmd>set formatoptions+=t<cr>", { desc = "Enable auto-wrap text" })
keymap.set("n", "<leader>tA", "<cmd>set formatoptions-=t<cr>", { desc = "Disable auto-wrap text" })
keymap.set("n", "<leader>tc", "<cmd>set formatoptions+=c<cr>", { desc = "Enable auto-wrap comments" })
keymap.set("n", "<leader>tC", "<cmd>set formatoptions-=c<cr>", { desc = "Disable auto-wrap comments" })

--- Indent and wrap — toggle break indent and show/hide break indicator.
keymap.set("n", "<leader>ti", "<cmd>set breakindent!<cr>", { desc = "Toggle break indent" })
keymap.set("n", "<leader>tB", "<cmd>set showbreak=↪ <cr>", { desc = "Show break indicator" })
keymap.set("n", "<leader>tb", "<cmd>set showbreak=<cr>", { desc = "Hide break indicator" })
