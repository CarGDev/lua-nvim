-- ============================================================================
-- NVIM-TREE: File explorer sidebar
-- ============================================================================
-- Tree-style file browser on the left side. Keymaps: a=create, d=delete,
-- r=rename, o=open, s=vsplit, i=hsplit, u=parent dir. Has BufWipeout autocmd
-- to track deleted file buffers. Disables netrw (vim's built-in explorer).
-- ============================================================================
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "ryanoasis/vim-devicons",
  init = function()
    -- Disable netrw before it loads (must be in init, not config)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    -- Create empty FileExplorer group to suppress E216 error from nvim-tree
    vim.api.nvim_create_augroup("FileExplorer", { clear = true })
  end,
  config = function()
    local nvimtree = require("nvim-tree")
    local api = require("nvim-tree.api")

    -- Handle file deletion: switch to another buffer or create new one
    local Event = api.events.Event
    api.events.subscribe(Event.FileRemoved, function(data)
      vim.schedule(function()
        -- Close nvim-tree first
        pcall(function() api.tree.close() end)

        -- Get all listed buffers with real files (excluding deleted one)
        local deleted_path = data.fname
        local bufs = vim.tbl_filter(function(b)
          if not vim.api.nvim_buf_is_valid(b) then return false end
          if not vim.bo[b].buflisted then return false end
          local name = vim.api.nvim_buf_get_name(b)
          if name == "" or name == deleted_path then return false end
          if vim.bo[b].buftype ~= "" then return false end
          return true
        end, vim.api.nvim_list_bufs())

        -- Switch to another buffer or create new one
        if #bufs > 0 then
          pcall(function() vim.cmd("buffer " .. bufs[1]) end)
        else
          pcall(function() vim.cmd("enew") end)
        end
      end)
    end)

    nvimtree.setup({
      view = {
        width = 35,
        side = "left",
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          quit_on_open = true,
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
      on_attach = function(bufnr) -- Correct way to set keymaps
        local api = require("nvim-tree.api")
        local opts = { noremap = true, silent = true, nowait = true, buffer = bufnr }

        -- Open file in vertical split
        vim.keymap.set("n", "s", api.node.open.vertical, opts)

        -- Open file in horizontal split
        vim.keymap.set("n", "i", api.node.open.horizontal, opts)

        -- Open file in the current window
        vim.keymap.set("n", "o", api.node.open.edit, opts)

        -- Navigate Up (Back One Folder Level)
        vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts)

        -- Navigate Forward (Enter a Folder)
        vim.keymap.set("n", "<leader>f", api.tree.change_root_to_node, opts)

        -- File Management keybindings
        vim.keymap.set("n", "a", function() -- Add a new file
          vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
          api.fs.create()
        end, opts)

        vim.keymap.set("n", "r", function() -- Rename file
          vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
          api.fs.rename()
        end, opts)

        vim.keymap.set("n", "d", function() -- Delete file
          vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
          api.fs.remove()
        end, opts)

        vim.keymap.set("n", "x", function() -- Cut (move) file
          vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
          api.fs.cut()
        end, opts)

        vim.keymap.set("n", "p", function() -- Paste file
          vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
          api.fs.paste()
        end, opts)

        vim.keymap.set("n", "y", function() -- Copy file
          vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
          api.fs.copy.node()
        end, opts)
      end,
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>nt", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
  end,
}
