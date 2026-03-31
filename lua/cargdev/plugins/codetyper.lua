-- ============================================================================
-- CODETYPER.NVIM: AI-powered coding assistant plugin
-- ============================================================================
-- A local development plugin that provides AI-assisted coding capabilities
-- using various LLM providers (Ollama, Claude, OpenAI, Gemini, Copilot).
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

localDir = "CarGDev/codetyper.nvim"

if local_cfg.RUN_CODETYPER_LOCAL then
  -- Skip plugin if local config is missing required values
  if not local_cfg.CODE_TYPER_DIR then
    return {}
  end
  localDir = local_cfg.CODE_TYPER_DIR
end

return {
  -- Codetyper.nvim - AI-powered coding partner
  -- Local development version
  localDir,
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
        -- Available providers: "ollama", "claude", "openai", "gemini", "copilot"
        provider = "copilot", -- Using GitHub Copilot

        -- Ollama (local LLM)
        ollama = {
          host = "http://localhost:11434",
          model = "deepseek-coder:6.7b",
          -- model = "codellama:7b",
          -- model = "qwen2.5-coder:7b",
        },

        -- GitHub Copilot (uses OAuth from copilot.vim/copilot.lua)
        copilot = {
          model = "gpt-4o", -- or "gpt-4", "gpt-3.5-turbo"
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
      auto_open_ask = false, -- Don't auto-open Ask panel on startup
      scheduler = {
        enabled = true,
        ollama_scout = false, -- Disabled since using Copilot directly
        escalation_threshold = 0.7,
        max_concurrent = 2,
        completion_delay_ms = 100, -- Delay before checking completion visibility
        apply_delay_ms = 2000, -- Wait 2 seconds before applying code
      },
    })
  end,
}
