# Database Setup Guide

## Current Status: ✅ **FIXED**

The database error has been resolved! The database plugins are now configured to prevent automatic connections that were causing the startup error.

## What Was Fixed

1. **Disabled Auto-Connections**: Set `db_ui_auto_execute_table_helpers = 0` to prevent automatic database connections
2. **Removed Keymap Conflicts**: Temporarily disabled database keymaps to prevent accidental triggers
3. **Safe Configuration**: Database plugins are loaded but won't attempt to connect automatically

## To Re-Enable Database Functionality

When you want to use database features, you can:

### 1. Re-enable Database Keymaps
Uncomment the database keymaps in `lua/cargdev/core/keymaps/plugins.lua`:

```lua
-- Change from:
-- keymap.set("n", "<leader>du", "<cmd>DBUI<CR>", { desc = "Open Database UI" })

-- To:
keymap.set("n", "<leader>du", "<cmd>DBUI<CR>", { desc = "Open Database UI" })
```

### 2. Manual Database Usage
You can still use database features manually:

- **Open Database UI**: `:DBUI`
- **Add Connection**: `:DBUIAddConnection`
- **Execute SQL**: `:DBExecute`
- **Format SQL**: `:SQLFormat`

### 3. Database Keymaps (when re-enabled)
- **`<leader>du`** - Open Database UI
- **`<leader>dua`** - Add database connection
- **`<leader>due`** - Execute SQL query
- **`<leader>dus`** - Select SQL query
- **`<leader>dut`** - Create table
- **`<leader>duf`** - Format SQL query

## Supported Databases

- **SQLite**: `sqlite3`
- **MySQL**: `mysql`
- **PostgreSQL**: `psql`
- **Redis**: `redis-cli`

## Installation Requirements

Make sure you have the database clients installed:

```bash
# macOS
brew install mysql redis mongodb/brew/mongodb-community

# Ubuntu/Debian
sudo apt install mysql-client postgresql-client redis-tools

# CentOS/RHEL
sudo yum install mysql postgresql redis
```

## Troubleshooting

If you encounter database errors again:

1. **Check for saved connections**: Look for `.dadbod` files in your project directories
2. **Clear database cache**: Remove any saved database sessions
3. **Verify adapters**: Ensure database clients are properly installed
4. **Check keymaps**: Make sure there are no conflicting keymaps

## Current Configuration

The database plugins are configured with:
- ✅ **No automatic connections**
- ✅ **Manual trigger only**
- ✅ **Proper adapters configured**
- ✅ **No startup errors**

Your Neovim should now start cleanly without any database errors! 🎉 