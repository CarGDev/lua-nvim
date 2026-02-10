--- Performance and LSP health monitoring utilities.
--- Provides functions to inspect memory usage, startup time, loaded plugins,
--- active LSP clients, and per-buffer diagnostic summaries.
--- @module performance_monitor
local M = {}

local fn = vim.fn
local notify = vim.notify
local lsp = vim.lsp

--- Collect and display overall Neovim performance statistics.
--- Reports memory usage, open buffer count, active LSP clients, and
--- (when lazy.nvim is available) loaded plugin count and startup time.
--- Results are shown via `vim.notify` at INFO level.
function M.check_performance()
  local stats = {}

  -- Startup time
  stats.startup = fn.reltimefloat(fn.reltime(vim.g.start_time or fn.reltime()))

  -- Memory usage
  local mem = collectgarbage("count")
  stats.memory_kb = math.floor(mem)
  stats.memory_mb = string.format("%.2f", mem / 1024)

  -- Buffer count
  stats.buffers = #fn.getbufinfo({ buflisted = 1 })

  -- Loaded plugins (lazy.nvim)
  local lazy_ok, lazy = pcall(require, "lazy")
  if lazy_ok then
    local lazy_stats = lazy.stats()
    stats.plugins_loaded = lazy_stats.loaded
    stats.plugins_total = lazy_stats.count
    stats.startup_ms = string.format("%.2f", lazy_stats.startuptime)
  end

  -- Active LSP clients
  stats.lsp_clients = #lsp.get_clients()

  -- Display results
  local lines = {
    "Performance Stats",
    string.rep("-", 40),
    string.format("Memory Usage: %s MB (%d KB)", stats.memory_mb, stats.memory_kb),
    string.format("Open Buffers: %d", stats.buffers),
    string.format("Active LSP Clients: %d", stats.lsp_clients),
  }

  if stats.plugins_loaded then
    table.insert(lines, string.format("Plugins: %d/%d loaded", stats.plugins_loaded, stats.plugins_total))
    table.insert(lines, string.format("Startup Time: %s ms", stats.startup_ms))
  end

  notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "Performance" })
end

--- Check LSP health for the current buffer.
--- Lists all attached LSP clients with their root directory and
--- server capabilities (completion, hover, definition, references,
--- formatting, code_actions), followed by a diagnostic severity summary.
--- Warns if no LSP clients are attached.
function M.check_lsp_health()
  local clients = lsp.get_clients({ bufnr = 0 })

  if #clients == 0 then
    notify("No LSP clients attached to this buffer", vim.log.levels.WARN, { title = "LSP Health" })
    return
  end

  local lines = {
    "LSP Health Report",
    string.rep("-", 40),
  }

  for _, client in ipairs(clients) do
    table.insert(lines, "")
    table.insert(lines, string.format("Client: %s (id: %d)", client.name, client.id))
    table.insert(lines, string.format("  Root: %s", client.config.root_dir or "N/A"))

    -- Check capabilities
    local caps = {}
    if client.server_capabilities.completionProvider then
      table.insert(caps, "completion")
    end
    if client.server_capabilities.hoverProvider then
      table.insert(caps, "hover")
    end
    if client.server_capabilities.definitionProvider then
      table.insert(caps, "definition")
    end
    if client.server_capabilities.referencesProvider then
      table.insert(caps, "references")
    end
    if client.server_capabilities.documentFormattingProvider then
      table.insert(caps, "formatting")
    end
    if client.server_capabilities.codeActionProvider then
      table.insert(caps, "code_actions")
    end

    table.insert(lines, string.format("  Capabilities: %s", table.concat(caps, ", ")))
  end

  -- Diagnostics summary
  local diagnostics = vim.diagnostic.get(0)
  local counts = { errors = 0, warnings = 0, hints = 0, info = 0 }
  for _, d in ipairs(diagnostics) do
    if d.severity == vim.diagnostic.severity.ERROR then
      counts.errors = counts.errors + 1
    elseif d.severity == vim.diagnostic.severity.WARN then
      counts.warnings = counts.warnings + 1
    elseif d.severity == vim.diagnostic.severity.HINT then
      counts.hints = counts.hints + 1
    elseif d.severity == vim.diagnostic.severity.INFO then
      counts.info = counts.info + 1
    end
  end

  table.insert(lines, "")
  table.insert(
    lines,
    string.format(
      "Diagnostics: %d errors, %d warnings, %d hints, %d info",
      counts.errors,
      counts.warnings,
      counts.hints,
      counts.info
    )
  )

  notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "LSP Health" })
end

return M
