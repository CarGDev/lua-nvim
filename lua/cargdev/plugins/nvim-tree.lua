return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "ryanoasis/vim-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- 🧼 Remove invalid autocommand (FileExplorer) if it exists
    vim.api.nvim_create_autocmd("VimEnter", {
      once = true,
      callback = function()
        pcall(vim.cmd, "autocmd! FileExplorer *")
      end,
    })

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
