-- ============================================================================
-- CODETYPER.NVIM: AI-powered coding assistant plugin
-- ============================================================================
-- A local development plugin that provides AI-assisted coding capabilities
-- using GitHub Copilot (auth-gated, tried first) or Ollama (local fallback
-- when Copilot isn't authenticated). Features include inline /@ ... @/ prompt
-- tags, visual-selection transforms, a project indexer, cost/usage tracking,
-- and an event-driven scheduler with confidence scoring and completion-aware
-- code injection.
--
-- Key keymaps:
--   <leader>ctt - Transform tag/selection at cursor (normal + visual mode)
--   <leader>ctp - Manually process /@ @/ tags in current buffer
--   <leader>cta - Toggle auto-trigger for /@ @/ tags (auto/manual)
--   <leader>cc  - Toggle Cost estimation window
--   <leader>cq  - Toggle prompt Queue window
--   <leader>ck  - Toggle Terminal window
--   <leader>cm  - Quick switch Copilot model
--   <leader>cu  - Connect to GitHub Copilot (only runs if not already connected)
--   <leader>ci  - Index the entire project
--   <leader>cI  - Show project index status
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
  lazy = false, -- Load on startup (registers /@ @/ tag autocmds immediately)
  priority = 100, -- Load early
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required: async utilities
    "MunifTanjim/nui.nvim", -- Optional: UI components
  },
  event = {
    "BufReadPre *.coder.*",
    "BufNewFile *.coder.*",
  },
  cmd = {
    "Coder",
    "CoderTransformSelection",
    "CoderIndexProject",
    "CoderIndexStatus",
    "CoderCost",
    "CoderAutotrigger",
    "CoderProcess",
    "CoderCredentials",
    "CoderSwitchProvider",
    "CoderModel",
    "CoderAuth",
  },
  keys = {
    -- Prompt tag processing (/@ ... @/)
    {
      "<leader>ctt",
      "<cmd>CoderTransformSelection<cr>",
      mode = { "n", "v" },
      desc = "Coder: Transform selection with custom prompt",
    },
    { "<leader>ctp", "<cmd>CoderProcess<cr>", desc = "Coder: Process /@ @/ tags in buffer" },
    { "<leader>cta", "<cmd>CoderAutotrigger<cr>", desc = "Coder: Toggle /@ @/ auto-trigger" },
    -- Windows
    { "<leader>cc", "<cmd>CoderCost<cr>", desc = "Coder: Toggle cost estimation window" },
    { "<leader>cq", "<cmd>Coder queue<cr>", desc = "Coder: Toggle prompt queue window" },
    { "<leader>ck", "<cmd>Coder terminal<cr>", desc = "Coder: Toggle terminal window" },
    -- Provider / auth / model
    { "<leader>cu", "<cmd>CoderAuth<cr>", desc = "Coder: Connect to GitHub Copilot" },
    { "<leader>cP", "<cmd>CoderSwitchProvider<cr>", desc = "Coder: Switch active LLM provider" },
    { "<leader>cm", "<cmd>CoderModel<cr>", desc = "Coder: Switch Copilot model" },
    { "<leader>cC", "<cmd>CoderCredentials<cr>", desc = "Coder: Show credentials status" },
    -- Project indexer
    { "<leader>ci", "<cmd>CoderIndexProject<cr>", desc = "Coder: Index project" },
    { "<leader>cI", "<cmd>CoderIndexStatus<cr>", desc = "Coder: Show index status" },
  },
  config = function()
    require("codetyper").setup({
      llm = {
        -- Copilot is always tried first (auth-gated via a real token check).
        -- Ollama is only used automatically when Copilot auth is unavailable.
        provider = "copilot",
        smart_selection = false,

        -- Ollama (local LLM) — used as fallback when Copilot isn't authenticated
        ollama = {
          host = "http://localhost:11434",
          model = "gemma4:26b",
          ask_model = nil,
        },

        -- GitHub Copilot — connect via <leader>cu / :CoderAuth if not already
        -- authenticated (uses OAuth from copilot.vim/copilot.lua if present,
        -- otherwise runs its own device-flow login)
        copilot = {
          model = "claude-sonnet-5",
          ask_model = "gpt-5-mini", -- Cheaper model for question/explain calls
        },
      },
      patterns = {
        open_tag = "/@",
        close_tag = "@/",
        file_pattern = "*.coder.*",
      },
      auto_gitignore = false,
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
