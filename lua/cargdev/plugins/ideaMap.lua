return {
  --[[dir = "/Volumes/Carlos_SSD/Documents/projects/ideaDrop",]]
  "CarGDev/ideadrop.nvim",
  name = "ideaDrop",
  dependencies = {
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("ideaDrop").setup({
      idea_dir = "/Users/carlos/Nextcloud/ObsidianVault",
    })
    
    -- Set up convenient keymaps for ideaDrop
    vim.keymap.set("n", "<leader>id", ":IdeaRight<CR>", { desc = "Open today's idea in right buffer" })
    vim.keymap.set("n", "<leader>in", ":IdeaRight ", { desc = "Open named idea in right buffer" })
    vim.keymap.set("n", "<leader>it", ":IdeaTree<CR>", { desc = "Open idea tree browser" })
    vim.keymap.set("n", "<leader>is", ":IdeaSearch ", { desc = "Search ideas" })
    vim.keymap.set("n", "<leader>ig", ":IdeaTags<CR>", { desc = "Browse tags" })
    vim.keymap.set("n", "<leader>if", ":Idea<CR>", { desc = "Open today's idea in float" })
    
    -- Optional: Override the default :Idea command to use right buffer instead of float
    -- Uncomment the line below if you want :Idea to always use the right buffer
    -- vim.api.nvim_create_user_command("Idea", function(opts) vim.cmd("IdeaRight " .. (opts.args or "")) end, { nargs = "?" })
  end,
}
