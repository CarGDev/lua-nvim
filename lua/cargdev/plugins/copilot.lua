-- ============================================================================
-- COPILOT: GitHub AI code completion and chat
-- ============================================================================
-- AI-powered code suggestions (ghost text + cmp menu) and chat.
-- Autocomplete: <C-l> accept ghost text, also shows in cmp menu.
-- Chat: <leader>cc toggle, <leader>cq quick chat, <leader>ce explain.
--
-- MODEL SELECTION:
--   Chat:         :CopilotChatModels   (pick from gpt-4o, claude-sonnet-4, o3-mini, etc.)
--   Autocomplete: controlled server-side by GitHub, not user-selectable.
-- ============================================================================
return {
  -- Copilot core: ghost text suggestions + LSP backend
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        copilot_model = "gpt-41-copilot",
        panel = {
          enabled = true,
          auto_refresh = false,
          layout = {
            position = "bottom",
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = false,
          debounce = 75,
          keymap = {
            accept = "<C-l>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          markdown = true,
          help = true,
          gitcommit = true,
          gitrebase = true,
          hgcommit = true,
          svn = true,
          cvs = true,
          tex = false,
          ["."] = true,
        },
        copilot_node_command = "node",
        server_opts_overrides = {},
      })

      -- Disable Copilot when opening .tex files
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
        pattern = "tex",
        callback = function()
          local ok, suggestion = pcall(require, "copilot.suggestion")
          if ok and suggestion and suggestion.is_visible() then
            suggestion.dismiss()
          end
          vim.cmd("Copilot disable")
        end,
        desc = "Disable Copilot for LaTeX files",
      })
    end,
  },

  -- Copilot CMP: adds Copilot as a completion source in nvim-cmp menu
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- CopilotChat: full chat interface with model selection
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
    },
    build = "make tiktoken",
    cmd = {
      "CopilotChat",
      "CopilotChatToggle",
      "CopilotChatModels",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatTests",
      "CopilotChatCommit",
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat: Toggle chat window" },
      {
        "<leader>cq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "CopilotChat: Quick chat (whole buffer)",
      },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", mode = { "n", "v" }, desc = "CopilotChat: Explain code" },
      { "<leader>cr", "<cmd>CopilotChatReview<cr>", mode = { "n", "v" }, desc = "CopilotChat: Review code" },
      { "<leader>cf", "<cmd>CopilotChatFix<cr>", mode = { "n", "v" }, desc = "CopilotChat: Fix code" },
      { "<leader>co", "<cmd>CopilotChatOptimize<cr>", mode = { "n", "v" }, desc = "CopilotChat: Optimize code" },
      { "<leader>cd", "<cmd>CopilotChatDocs<cr>", mode = { "n", "v" }, desc = "CopilotChat: Generate docs" },
      { "<leader>ctg", "<cmd>CopilotChatTests<cr>", mode = { "n", "v" }, desc = "CopilotChat: Generate tests" },
      { "<leader>cm", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat: Select model" },
    },
    config = function()
      require("CopilotChat").setup({
        -- Default model (change with :CopilotChatModels at runtime)
        -- Options include: gpt-4o, claude-sonnet-4, o3-mini, gemini-2.0-flash, etc.
        model = "claude-sonnet-4",
        window = {
          layout = "vertical",
          width = 0.35,
          border = "rounded",
        },
        mappings = {
          complete = { insert = "<Tab>" },
          close = { normal = "q", insert = "<C-c>" },
          reset = { normal = "<C-x>", insert = "<C-x>" },
          submit_prompt = { normal = "<CR>", insert = "<C-s>" },
        },
      })
    end,
  },
}
