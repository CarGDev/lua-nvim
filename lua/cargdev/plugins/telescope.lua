return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "nvim-telescope/telescope-dap.nvim",
    "nvim-telescope/telescope-session-lens.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.open,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
    })

    -- Load extensions
    telescope.load_extension("fzf")
    telescope.load_extension("dap")
    telescope.load_extension("session-lens")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    -- File navigation
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    
    -- LSP navigation (these work when LSP is attached)
    keymap.set("n", "<leader>fd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Go to definition" })
    keymap.set("n", "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", { desc = "Go to implementation" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "Show references" })
    keymap.set("n", "<leader>ft", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Go to type definition" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document symbols" })
    keymap.set("n", "<leader>fw", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Workspace symbols" })
    keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Show diagnostics" })
    
    -- Buffer and session management
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
    keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Find marks" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Find commands" })
    
    -- Git
    keymap.set("n", "<leader>fg", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
    keymap.set("n", "<leader>fG", "<cmd>Telescope git_bcommits<cr>", { desc = "Git buffer commits" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
  end,
}
