-- ============================================================================
-- CODETYPER.NVIM: AI-powered coding assistant plugin
-- ============================================================================
-- A local development plugin that provides AI-assisted coding capabilities
-- using various LLM providers (Ollama, Claude, OpenAI, Gemini).
-- Features include: inline code transformation with /@ @/ tags, Ask panel
-- for interactive queries, Agent panel for autonomous coding tasks,
-- Tree-sitter integration for scope detection, and diff review.
--
-- Key keymaps:
--   <leader>co - Open Coder view        <leader>ca - Open Ask panel
--   <leader>ct - Toggle Coder view      <leader>cg - Open Agent panel
--   <leader>cp - Process prompt         <leader>cd - Open Diff Review
--   <leader>ctt - Transform tag at cursor (also works in visual mode)
-- ============================================================================

-- Get local config (loaded in core/init.lua)
local local_cfg = vim.g.cargdev_local or {}

local repo = "CarGDev/codetyper.nvim"
local localDir = nil

-- If requested to run codetyper locally and a path is provided, use it.
if local_cfg.RUN_CODETYPER_LOCAL and local_cfg.CODE_TYPER_DIR and #local_cfg.CODE_TYPER_DIR > 0 then
  localDir = local_cfg.CODE_TYPER_DIR
end

return {
  -- Codetyper.nvim - AI-powered coding partner
  -- Local development version
  repo,
  dir = localDir,
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
    -- Ask commands
    "CoderAsk",
    "CoderAskToggle",
    "CoderAskClear",
    -- Agent commands
    "CoderAgent",
    "CoderAgentToggle",
    "CoderAgentStop",
    "CoderMode",
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
    -- Agent panel commands
    { "<leader>cg", "<cmd>Coder agent<cr>", desc = "Coder: Open Agent panel" },
    { "<leader>cG", "<cmd>Coder agent-toggle<cr>", desc = "Coder: Toggle Agent panel" },
    { "<leader>cS", "<cmd>Coder agent-stop<cr>", desc = "Coder: Stop Agent" },
    { "<leader>cd", "<cmd>CoderDiffReview<cr>", desc = "Coder: Open Diff Review" },
    -- Transform commands (inline /@ @/ replacement)
    { "<leader>ctt", mode = "n", desc = "Coder: Transform tag at cursor" },
    { "<leader>ctt", mode = "v", desc = "Coder: Transform selected tags" },
    { "<leader>ctT", "<cmd>Coder transform<cr>", desc = "Coder: Transform all tags" },
  },
  config = function()
    require("codetyper").setup({
      llm = {
        -- Available providers: "ollama", "copilot", "claude"
        provider = "claude", -- Using Claude API
        smart_selection = false, -- Disabled smart provider selection

        -- Ollama (local LLM)
        ollama = {
          host = "http://localhost:11434",
          model = "deepseek-coder:6.7b",
          ask_model = nil,
        },

        -- GitHub Copilot
        copilot = {
          model = "claude-sonnet-4", -- Uses GitHub Copilot authentication
          ask_model = "gpt-5-mini", -- Cheaper model for question/explain calls
        },

        -- Claude API (Anthropic)
        claude = {
          api_key = nil, -- Uses ANTHROPIC_API_KEY environment variable
          model = "claude-3-5-sonnet-20241022", -- Claude 3.5 Sonnet (best for coding)
          ask_model = "claude-3-5-sonnet-20241022", -- Claude 3 Haiku (faster for questions)
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
      auto_gitignore = false, -- Disabled - no longer creating project folders
      auto_open_ask = false, -- Don't auto-open Ask panel on startup
      scheduler = {
        enabled = true,
        escalation_threshold = 0.7,
        max_concurrent = 2,
        completion_delay_ms = 100, -- Delay before checking completion visibility
        apply_delay_ms = 2000, -- Wait 2 seconds before applying code
      },
    })
  end,
}
