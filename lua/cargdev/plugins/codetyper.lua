return {
  -- Codetyper.nvim - AI-powered coding partner
  -- Local development version
  dir = "/Volumes/Carlos_SSD/Documents/projects/nvim.plugins/codetyper.nvim",
  name = "codetyper.nvim",
  lazy = false, -- Load on startup to create .coder folder
  priority = 100, -- Load early
  event = {
    "BufReadPre *.coder.*",
    "BufNewFile *.coder.*",
  },
  cmd = {
    "Coder",
    "CoderOpen",
    "CoderClose",
    "CoderToggle",
    "CoderProcess",
    "CoderTree",
    "CoderTreeView",
    "CoderAsk",
    "CoderAskToggle",
    "CoderAskClear",
  },
  keys = {
    -- Coder view commands
    { "<leader>co", "<cmd>Coder open<cr>", desc = "Coder: Open view" },
    { "<leader>cC", "<cmd>Coder close<cr>", desc = "Coder: Close view" },
    { "<leader>ct", "<cmd>Coder toggle<cr>", desc = "Coder: Toggle view" },
    { "<leader>cp", "<cmd>Coder process<cr>", desc = "Coder: Process prompt" },
    { "<leader>cs", "<cmd>Coder status<cr>", desc = "Coder: Show status" },
    { "<leader>cf", "<cmd>Coder focus<cr>", desc = "Coder: Switch focus" },
    { "<leader>cv", "<cmd>Coder tree-view<cr>", desc = "Coder: View tree" },
    { "<leader>cr", "<cmd>Coder tree<cr>", desc = "Coder: Refresh tree" },
    -- Ask panel commands
    { "<leader>ca", "<cmd>Coder ask<cr>", desc = "Coder: Open Ask panel" },
    { "<leader>cA", "<cmd>Coder ask-toggle<cr>", desc = "Coder: Toggle Ask panel" },
    { "<leader>cx", "<cmd>Coder ask-clear<cr>", desc = "Coder: Clear Ask history" },
    -- Transform commands (inline /@ @/ replacement)
    { "<leader>ctt", mode = "n", desc = "Coder: Transform tag at cursor" },
    { "<leader>ctt", mode = "v", desc = "Coder: Transform selected tags" },
    { "<leader>ctT", "<cmd>Coder transform<cr>", desc = "Coder: Transform all tags" },
  },
  config = function()
    require("codetyper").setup({
      llm = {
        provider = "ollama",
        ollama = {
          host = "http://localhost:11434",
          model = "deepseek-coder:6.7b",
        },
      },
      window = {
        width = 0.25, -- 1/4 of window
        position = "left",
        border = "rounded",
      },
      patterns = {
        open_tag = "/@",
        close_tag = "@/",
        file_pattern = "*.coder.*",
      },
      auto_gitignore = true,
      auto_open_ask = false, -- Always open Ask panel on startup
      agent_mode = false,
    })
  end,
}
