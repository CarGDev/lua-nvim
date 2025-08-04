-- =============================================================================
-- DATABASE KEYMAPS
-- =============================================================================

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- =============================================================================
-- GLOBAL DATABASE KEYMAPS
-- =============================================================================

-- Open database interface
keymap.set("n", "<leader>db", function()
  require("dbee").open()
end, { desc = "Open Database Interface" })

-- Close database interface
keymap.set("n", "<leader>dc", function()
  require("dbee").close()
end, { desc = "Close Database Interface" })

-- Execute current query (when in database editor)
keymap.set("n", "<leader>dq", function()
  require("dbee").api.ui.execute_query()
end, { desc = "Execute Query" })

-- Store results to file
keymap.set("n", "<leader>ds", function()
  require("dbee").store("csv", "file", { extra_arg = "~/query_results.csv" })
end, { desc = "Store Results to File" })

-- Yank results to clipboard
keymap.set("n", "<leader>dy", function()
  require("dbee").store("json", "yank", {})
end, { desc = "Yank Results to Clipboard" })

-- =============================================================================
-- NVIM-DBEE INTERNAL KEYMAPS
-- =============================================================================

-- Set up nvim-dbee internal keymaps
local function setup_dbee_keymaps()
  -- Drawer mappings (left panel)
  keymap.set("n", "<CR>", function()
    require("dbee").api.ui.open_connection()
  end, { buffer = true, desc = "Open Connection" })
  
  keymap.set("n", "a", function()
    require("dbee").api.ui.add_connection()
  end, { buffer = true, desc = "Add Connection" })
  
  keymap.set("n", "e", function()
    require("dbee").api.ui.edit_connection()
  end, { buffer = true, desc = "Edit Connection" })
  
  keymap.set("n", "d", function()
    require("dbee").api.ui.delete_connection()
  end, { buffer = true, desc = "Delete Connection" })
  
  keymap.set("n", "r", function()
    require("dbee").api.ui.refresh_connections()
  end, { buffer = true, desc = "Refresh Connections" })

  -- Editor mappings (query editor)
  keymap.set("n", "BB", function()
    require("dbee").api.ui.execute_query()
  end, { buffer = true, desc = "Execute Query" })
  
  keymap.set("n", "cc", function()
    require("dbee").api.ui.clear_results()
  end, { buffer = true, desc = "Clear Results" })
  
  keymap.set("n", "ss", function()
    require("dbee").api.ui.save_scratchpad()
  end, { buffer = true, desc = "Save Scratchpad" })

  -- Result mappings (results buffer)
  keymap.set("n", "L", function()
    require("dbee").api.ui.result_page_next()
  end, { buffer = true, desc = "Next Page" })
  
  keymap.set("n", "H", function()
    require("dbee").api.ui.result_page_prev()
  end, { buffer = true, desc = "Previous Page" })
  
  keymap.set("n", "F", function()
    require("dbee").api.ui.result_page_first()
  end, { buffer = true, desc = "First Page" })
  
  keymap.set("n", "E", function()
    require("dbee").api.ui.result_page_last()
  end, { buffer = true, desc = "Last Page" })
  
  keymap.set("n", "yaj", function()
    require("dbee").api.ui.yank_row_json()
  end, { buffer = true, desc = "Yank Row as JSON" })
  
  keymap.set("n", "yac", function()
    require("dbee").api.ui.yank_row_csv()
  end, { buffer = true, desc = "Yank Row as CSV" })
  
  keymap.set("n", "yaJ", function()
    require("dbee").api.ui.yank_all_json()
  end, { buffer = true, desc = "Yank All as JSON" })
  
  keymap.set("n", "yaC", function()
    require("dbee").api.ui.yank_all_csv()
  end, { buffer = true, desc = "Yank All as CSV" })
end

-- Apply dbee keymaps when dbee buffers are created
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dbee-drawer", "dbee-editor", "dbee-result" },
  callback = setup_dbee_keymaps,
}) 