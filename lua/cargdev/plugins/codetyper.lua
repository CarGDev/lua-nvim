return {
  -- Codetyper.nvim - AI-powered coding partner
  -- Local development version
  dir = "/Volumes/Carlos_SSD/Documents/projects/nvim.plugins/codetyper.nvim",
  name = "codetyper.nvim",
  lazy = false, -- Load on startup to create .coder folder
  priority = 100, -- Load early
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required: async utilities
    -- "nvim-treesitter/nvim-treesitter", -- Required: scope detection via Tree-sitter
    -- "nvim-treesitter/nvim-treesitter-textobjects", -- Optional: better text object support
    "MunifTanjim/nui.nvim", -- Optional: UI components
  },
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
        -- Available providers: "ollama", "claude", "openai", "gemini", "copilot"
        provider = "ollama",

        -- Ollama (local LLM)
        ollama = {
          host = "http://localhost:11434",
          model = "deepseek-coder:6.7b",
          -- model = "codellama:7b",
          -- model = "qwen2.5-coder:7b",
        },

        -- Claude (Anthropic) - https://console.anthropic.com/
        -- claude = {
        --   api_key = vim.env.ANTHROPIC_API_KEY, -- or hardcode: "sk-ant-..."
        --   model = "claude-sonnet-4-20250514",
        --   -- model = "claude-3-5-sonnet-20241022",
        --   -- model = "claude-3-haiku-20240307",
        -- },

        -- OpenAI - https://platform.openai.com/api-keys
        -- openai = {
        --   api_key = vim.env.OPENAI_API_KEY, -- or hardcode: "sk-..."
        --   model = "gpt-4o",
        --   -- model = "gpt-4o-mini",
        --   -- model = "gpt-4-turbo",
        -- },

        -- Google Gemini - https://aistudio.google.com/apikey
        -- gemini = {
        --   api_key = vim.env.GEMINI_API_KEY, -- or hardcode: "AI..."
        --   model = "gemini-1.5-pro",
        --   -- model = "gemini-1.5-flash",
        --   -- model = "gemini-2.0-flash-exp",
        -- },

        -- GitHub Copilot (requires copilot.vim or copilot.lua plugin)
        -- copilot = {
        --   enabled = true,
        -- },
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
      scheduler = {
        enabled = true,
        ollama_scout = true, -- Use ollama first, escalate if low confidence
        escalation_threshold = 0.7,
        max_concurrent = 2,
        completion_delay_ms = 100, -- Delay before checking completion visibility
        apply_delay_ms = 2000, -- Wait 2 seconds before applying code
      },
    })
  end,
}
