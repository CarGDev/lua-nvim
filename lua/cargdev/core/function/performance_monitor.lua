-- Performance monitoring and diagnostics
local M = {}

-- Function to check Neovim performance
function M.check_performance()
  local start_time = vim.loop.hrtime()
  
  -- Check startup time
  local startup_time = vim.g.startup_time or 0
  
  -- Check memory usage
  local memory_info = vim.loop.get_memory_info()
  local memory_mb = math.floor(memory_info.used / 1024 / 1024)
  
  -- Check buffer count
  local buffer_count = #vim.api.nvim_list_bufs()
  
  -- Check window count
  local window_count = #vim.api.nvim_list_wins()
  
  -- Check tab count
  local tab_count = #vim.api.nvim_list_tabpages()
  
  -- Check if any LSP servers are running
  local active_clients = vim.lsp.get_active_clients()
  local lsp_count = #active_clients
  
  -- Check if treesitter is active
  local ts_available, ts = pcall(require, "nvim-treesitter")
  local ts_active = ts_available and ts.status() and "Active" or "Inactive"
  
  -- Check LSP errors and warnings
  local diagnostics = vim.diagnostic.get()
  local error_count = 0
  local warning_count = 0
  
  for _, diag in ipairs(diagnostics) do
    if diag.severity == vim.diagnostic.severity.ERROR then
      error_count = error_count + 1
    elseif diag.severity == vim.diagnostic.severity.WARN then
      warning_count = warning_count + 1
    end
  end
  
  -- Check current buffer file type and potential issues
  local current_buf = vim.api.nvim_get_current_buf()
  local current_filename = vim.api.nvim_buf_get_name(current_buf)
  local current_filetype = vim.api.nvim_buf_get_option(current_buf, "filetype")
  local current_line_count = vim.api.nvim_buf_line_count(current_buf)
  
  -- Check if current file might cause LSP issues
  local problematic_extensions = {
    "png", "jpg", "jpeg", "gif", "svg", "ico", "bmp", "webp",
    "mp4", "avi", "mov", "wmv", "flv", "webm", "mkv",
    "mp3", "wav", "flac", "aac", "ogg",
    "pdf", "doc", "docx", "xls", "xlsx", "ppt", "pptx",
    "zip", "rar", "7z", "tar", "gz", "bz2",
    "exe", "dll", "so", "dylib", "bin"
  }
  
  local is_problematic_file = false
  local file_extension = ""
  
  for _, ext in ipairs(problematic_extensions) do
    if current_filename:match("%." .. ext .. "$") then
      is_problematic_file = true
      file_extension = ext
      break
    end
  end
  
  -- Performance recommendations
  local recommendations = {}
  
  if memory_mb > 500 then
    table.insert(recommendations, "High memory usage: " .. memory_mb .. "MB - Consider disabling heavy plugins")
  end
  
  if buffer_count > 20 then
    table.insert(recommendations, "Many buffers open: " .. buffer_count .. " - Close unused buffers")
  end
  
  if lsp_count > 5 then
    table.insert(recommendations, "Many LSP servers: " .. lsp_count .. " - Consider disabling unused language servers")
  end
  
  if startup_time > 1000 then
    table.insert(recommendations, "Slow startup: " .. startup_time .. "ms - Check plugin loading order")
  end
  
  if error_count > 10 then
    table.insert(recommendations, "Many LSP errors: " .. error_count .. " - Check file syntax and LSP configuration")
  end
  
  if is_problematic_file then
    table.insert(recommendations, "Current file type (" .. file_extension .. ") may cause LSP issues - Use safe file search")
  end
  
  if current_line_count > 10000 then
    table.insert(recommendations, "Large file (" .. current_line_count .. " lines) - Consider disabling heavy features")
  end
  
  -- Display results
  local output = string.format([[
Performance Report:
==================
Startup Time: %dms
Memory Usage: %dMB
Active Buffers: %d
Active Windows: %d
Active Tabs: %d
LSP Servers: %d
Treesitter: %s
LSP Errors: %d
LSP Warnings: %d

Current File Analysis:
=====================
Filename: %s
Filetype: %s
Line Count: %d
Potential Issues: %s

Performance Recommendations:
]], startup_time, memory_mb, buffer_count, window_count, tab_count, lsp_count, ts_active, error_count, warning_count, 
   current_filename, current_filetype, current_line_count, is_problematic_file and "Yes (" .. file_extension .. ")" or "No")
  
  if #recommendations > 0 then
    for _, rec in ipairs(recommendations) do
      output = output .. "- " .. rec .. "\n"
    end
  else
    output = output .. "- No immediate performance issues detected\n"
  end
  
  -- Add LSP-specific recommendations
  if lsp_count > 0 then
    output = output .. "\nLSP Status:\n"
    for _, client in ipairs(active_clients) do
      local status = "Unknown"
      if client.is_stopped then
        status = "Stopped"
      elseif client.workspace_folders then
        status = "Active"
      end
      output = output .. "- " .. client.name .. ": " .. status .. "\n"
    end
  end
  
  -- Create a new buffer to display the report
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = 80,
    height = 25,
    row = 2,
    col = 2,
    style = "minimal",
    border = "rounded",
  })
  
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, "\n"))
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
  
  -- Add keymaps to close the window
  local opts = { buffer = buf, noremap = true, silent = true }
  vim.keymap.set("n", "q", "<cmd>close<CR>", opts)
  vim.keymap.set("n", "<ESC>", "<cmd>close<CR>", opts)
  
  -- Auto-close after 15 seconds
  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, 15000)
  
  local end_time = vim.loop.hrtime()
  local function_time = (end_time - start_time) / 1000000
  print("Performance check completed in " .. string.format("%.2f", function_time) .. "ms")
end

-- Function to profile a specific operation
function M.profile_operation(operation_name, operation_func)
  local start_time = vim.loop.hrtime()
  
  -- Run the operation
  local success, result = pcall(operation_func)
  
  local end_time = vim.loop.hrtime()
  local duration = (end_time - start_time) / 1000000
  
  if success then
    print(string.format("Operation '%s' completed in %.2fms", operation_name, duration))
    return result
  else
    print(string.format("Operation '%s' failed after %.2fms: %s", operation_name, duration, result))
    return nil
  end
end

-- Function to check if specific plugins are causing issues
function M.check_plugin_performance()
  local plugins_to_check = {
    "nvim-treesitter",
    "nvim-lspconfig",
    "nvim-cmp",
    "telescope.nvim",
    "which-key.nvim",
  }
  
  local results = {}
  
  for _, plugin_name in ipairs(plugins_to_check) do
    local start_time = vim.loop.hrtime()
    local success, plugin = pcall(require, plugin_name)
    local end_time = vim.loop.hrtime()
    local load_time = (end_time - start_time) / 1000000
    
    table.insert(results, {
      name = plugin_name,
      loaded = success,
      load_time = load_time,
      status = success and "OK" or "Failed"
    })
  end
  
  -- Display results
  local output = "Plugin Performance Check:\n=======================\n"
  for _, result in ipairs(results) do
    output = output .. string.format("%s: %s (%.2fms)\n", 
      result.name, result.status, result.load_time)
  end
  
  print(output)
  return results
end

-- Function to optimize current buffer
function M.optimize_buffer()
  local buf = vim.api.nvim_get_current_buf()
  local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
  
  -- Disable heavy features for large files
  local line_count = vim.api.nvim_buf_line_count(buf)
  
  if line_count > 10000 then
    -- Disable treesitter for very large files
    vim.api.nvim_buf_set_option(buf, "syntax", "off")
    print("Large file detected (" .. line_count .. " lines). Disabled syntax highlighting for performance.")
  end
  
  -- Optimize buffer-specific settings
  vim.api.nvim_buf_set_option(buf, "foldmethod", "manual")
  vim.api.nvim_buf_set_option(buf, "foldlevel", 99)
  
  print("Buffer optimized for performance")
end

-- Function to check LSP health and fix common issues
function M.check_lsp_health()
  local active_clients = vim.lsp.get_active_clients()
  local output = "LSP Health Check:\n================\n"
  
  if #active_clients == 0 then
    output = output .. "No LSP clients active\n"
  else
    for _, client in ipairs(active_clients) do
      local status = "Unknown"
      if client.is_stopped then
        status = "Stopped"
      elseif client.workspace_folders then
        status = "Active"
      end
      
      output = output .. string.format("- %s: %s\n", client.name, status)
      
      -- Check for common LSP issues
      if client.config and client.config.flags then
        if not client.config.flags.debounce_text_changes then
          output = output .. "  ⚠️  No text change debouncing\n"
        end
      end
    end
  end
  
  -- Check current buffer LSP status
  local current_buf = vim.api.nvim_get_current_buf()
  local attached_clients = vim.lsp.get_clients({ bufnr = current_buf })
  
  if #attached_clients > 0 then
    output = output .. "\nCurrent Buffer LSP:\n"
    for _, client in ipairs(attached_clients) do
      output = output .. string.format("- %s attached\n", client.name)
    end
  else
    output = output .. "\nNo LSP attached to current buffer\n"
  end
  
  print(output)
  return active_clients
end

-- Function to safely restart LSP for current buffer
function M.restart_lsp()
  local current_buf = vim.api.nvim_get_current_buf()
  local attached_clients = vim.lsp.get_clients({ bufnr = current_buf })
  
  if #attached_clients > 0 then
    for _, client in ipairs(attached_clients) do
      client.stop()
      print("Stopped LSP client: " .. client.name)
    end
    
    -- Restart LSP after a short delay
    vim.defer_fn(function()
      vim.cmd("LspStart")
      print("LSP restarted for current buffer")
    end, 100)
  else
    print("No LSP clients attached to current buffer")
  end
end

return M
