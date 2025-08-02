-- Plugin-specific keymaps
local keymap = vim.keymap

-- =============================================================================
-- PLUGIN KEYMAPS
-- =============================================================================

-- NvimTree
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Buffer management
keymap.set("n", "<S-l>", ":bnext<CR>", { noremap = true, silent = true })
keymap.set("n", "<S-h>", ":bprevious<CR>", { noremap = true, silent = true })

-- Comment
keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", { desc = "Toggle comment" })
keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", { desc = "Toggle comment" })

-- Git
keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })

-- DAP
keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "Toggle breakpoint" })
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { desc = "Continue" })
keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", { desc = "Step into" })
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", { desc = "Step over" })
keymap.set("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", { desc = "Step out" })
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { desc = "Toggle REPL" })
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", { desc = "Run last" })
keymap.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", { desc = "Toggle DAP UI" })
keymap.set("n", "<leader>dt", "<cmd>lua require'dapui'.float_element()<cr>", { desc = "Float element" })

-- Trouble
keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace diagnostics" })
keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document diagnostics" })
keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Location list" })
keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix list" })

-- Terminal
keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" })
keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "ToggleTerm horizontal split" })
keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "ToggleTerm vertical split" })

-- Session management
keymap.set("n", "<leader>ss", "<cmd>SessionSave<cr>", { desc = "Save session" })
keymap.set("n", "<leader>sr", "<cmd>SessionRestore<cr>", { desc = "Restore session" })

-- Formatting
keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<cr>", { desc = "Format buffer" })

-- Substitute
keymap.set("n", "<leader>s", "<cmd>lua require('substitute').operator()<cr>", { desc = "Substitute with motion" })
keymap.set("n", "<leader>ss", "<cmd>lua require('substitute').line()<cr>", { desc = "Substitute line" })
keymap.set("n", "<leader>S", "<cmd>lua require('substitute').eol()<cr>", { desc = "Substitute to end of line" })

-- Surround
keymap.set("n", "<leader>sa", "<cmd>lua require('nvim-surround').surround_add()<cr>", { desc = "Add surrounding" })
keymap.set("n", "<leader>sd", "<cmd>lua require('nvim-surround').surround_delete()<cr>", { desc = "Delete surrounding" })
keymap.set("n", "<leader>sr", "<cmd>lua require('nvim-surround').surround_replace()<cr>", { desc = "Replace surrounding" })

-- Git conflicts
keymap.set("n", "]x", "<Plug>(git-conflict-next-conflict)", { desc = "Go to next git conflict" })
keymap.set("n", "[x", "<Plug>(git-conflict-prev-conflict)", { desc = "Go to previous git conflict" })
keymap.set("n", "<leader>co", "<Plug>(git-conflict-ours)", { desc = "Choose ours (git conflict)" })
keymap.set("n", "<leader>ct", "<Plug>(git-conflict-theirs)", { desc = "Choose theirs (git conflict)" })
keymap.set("n", "<leader>cb", "<Plug>(git-conflict-both)", { desc = "Choose both (git conflict)" })
keymap.set("n", "<leader>c0", "<Plug>(git-conflict-none)", { desc = "Choose none (git conflict)" })
keymap.set("n", "<leader>cq", "<Plug>(git-conflict-list)", { desc = "List all git conflicts" })

-- LeetCode
keymap.set("n", "<leader>lr", "<cmd>Leet run<CR>", { desc = "LeetCode: Run Code" })
keymap.set("n", "<leader>ls", "<cmd>Leet submit<CR>", { desc = "LeetCode: Submit Code" })
keymap.set("n", "<leader>ld", "<cmd>Leet daily<CR>", { desc = "LeetCode: Daily Challenge" })
keymap.set("n", "<leader>ll", "<cmd>Leet list<CR>", { desc = "LeetCode: List Problems" })
keymap.set("n", "<leader>lc", "<cmd>Leet console<CR>", { desc = "LeetCode: Open Console" })
keymap.set("n", "<leader>lu", "<cmd>Leet cookie update<CR>", { desc = "LeetCode: Update Cookie" })
keymap.set("n", "<leader>lh", "<cmd>Leet hints<cr>", { desc = "LeetCode: Open hints" })
keymap.set("n", "<leader>lls", "<cmd>Leet last<cr>", { desc = "LeetCode: Get latest submission" })

-- Linting
keymap.set("n", "<leader>l", "<cmd>Lint<cr>", { desc = "Lint current file" })

-- Project commands
keymap.set("n", "<leader>p", "<cmd>lua require('cargdev.core.function.project_commands').run_project()<cr>", { desc = "Run project" })

-- Console log (different from personal <leader>con)
keymap.set("n", "<leader>cl", "oconsole.log()<ESC>i", { desc = "Add console.log" })

-- DAP UI reset
keymap.set("n", "<leader>drt", "<cmd>lua require('dapui').float_element()<cr>", { desc = "Reset DAP UI layout" })

-- DAP commands
keymap.set("n", "<leader>dco", "<cmd>lua require('dap').commands()<cr>", { desc = "DAP commands" })
keymap.set("n", "<leader>dcf", "<cmd>lua require('dap').list_breakpoints()<cr>", { desc = "DAP configs" })
keymap.set("n", "<leader>dcb", "<cmd>lua require('dap').list_breakpoints()<cr>", { desc = "List breakpoints" })

-- Step out
keymap.set("n", "<leader>dot", "<cmd>lua require('dap').step_out()<cr>", { desc = "Step out" })

-- Todos in trouble
keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Open todos in trouble" })

-- Surround mappings
keymap.set("n", "ys", "<cmd>lua require('nvim-surround').surround_add()<cr>", { desc = "Add surrounding" })
keymap.set("n", "yss", "<cmd>lua require('nvim-surround').surround_add()<cr>", { desc = "Add surrounding to line" })
keymap.set("n", "yS", "<cmd>lua require('nvim-surround').surround_add()<cr>", { desc = "Add surrounding on new lines" })
keymap.set("n", "ySS", "<cmd>lua require('nvim-surround').surround_add()<cr>", { desc = "Add surrounding to line on new lines" })

-- Comment mappings
keymap.set("n", "gc", "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>", { desc = "Toggle comment" })
keymap.set("n", "gcc", "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>", { desc = "Toggle current line comment" })
keymap.set("n", "gco", "<cmd>lua require('Comment.api').insert_below()<cr>", { desc = "Insert comment below" })
keymap.set("n", "gcO", "<cmd>lua require('Comment.api').insert_above()<cr>", { desc = "Insert comment above" })
keymap.set("n", "gcA", "<cmd>lua require('Comment.api').insert_eol()<cr>", { desc = "Insert comment at end of line" })
keymap.set("n", "gb", "<cmd>lua require('Comment.api').toggle_current_blockwise()<cr>", { desc = "Toggle block comment" })
keymap.set("n", "gbc", "<cmd>lua require('Comment.api').toggle_current_blockwise()<cr>", { desc = "Toggle current block comment" })

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

-- Redis specific
keymap.set("n", "<leader>rds", "<cmd>Redis<CR>", { desc = "Open Redis" })
keymap.set("n", "<leader>rdk", "<cmd>RedisKeys<CR>", { desc = "Show Redis keys" })
keymap.set("n", "<leader>rdi", "<cmd>RedisInfo<CR>", { desc = "Show Redis info" })

-- MongoDB specific
keymap.set("n", "<leader>mdb", "<cmd>MongoDB<CR>", { desc = "Open MongoDB" })
keymap.set("n", "<leader>mdc", "<cmd>MongoDBConnect<CR>", { desc = "Connect to MongoDB" })
keymap.set("n", "<leader>mdd", "<cmd>MongoDBDisconnect<CR>", { desc = "Disconnect from MongoDB" }) 

-- =============================================================================
-- NATIVE AUTO WRAPPER KEYMAPS
-- =============================================================================

-- Text wrapping controls
keymap.set("n", "<leader>tw", "<cmd>set wrap!<cr>", { desc = "Toggle line wrapping" })
keymap.set("n", "<leader>tl", "<cmd>set linebreak!<cr>", { desc = "Toggle line break" })
keymap.set("n", "<leader>tc", "<cmd>set colorcolumn=80<cr>", { desc = "Show 80 char column" })
keymap.set("n", "<leader>tC", "<cmd>set colorcolumn=<cr>", { desc = "Hide column guide" })

-- Format text using native Neovim commands
keymap.set("n", "<leader>tf", "gqap", { desc = "Format paragraph" })
keymap.set("v", "<leader>tf", "gq", { desc = "Format selection" })
keymap.set("n", "<leader>tF", "gggqG", { desc = "Format entire file" })

-- Text width adjustments
keymap.set("n", "<leader>t80", "<cmd>set textwidth=80<cr>", { desc = "Set text width to 80" })
keymap.set("n", "<leader>t100", "<cmd>set textwidth=100<cr>", { desc = "Set text width to 100" })
keymap.set("n", "<leader>t120", "<cmd>set textwidth=120<cr>", { desc = "Set text width to 120" })
keymap.set("n", "<leader>t0", "<cmd>set textwidth=0<cr>", { desc = "Disable text width" })

-- Auto-wrap controls
keymap.set("n", "<leader>ta", "<cmd>set formatoptions+=t<cr>", { desc = "Enable auto-wrap text" })
keymap.set("n", "<leader>tA", "<cmd>set formatoptions-=t<cr>", { desc = "Disable auto-wrap text" })
keymap.set("n", "<leader>tc", "<cmd>set formatoptions+=c<cr>", { desc = "Enable auto-wrap comments" })
keymap.set("n", "<leader>tC", "<cmd>set formatoptions-=c<cr>", { desc = "Disable auto-wrap comments" })

-- Indent and wrap
keymap.set("n", "<leader>ti", "<cmd>set breakindent!<cr>", { desc = "Toggle break indent" })
keymap.set("n", "<leader>ts", "<cmd>set showbreak=↪ <cr>", { desc = "Show break indicator" })
keymap.set("n", "<leader>tS", "<cmd>set showbreak=<cr>", { desc = "Hide break indicator" }) 