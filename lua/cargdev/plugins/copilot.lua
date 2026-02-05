-- ============================================================================
-- COPILOT: GitHub AI code completion and chat
-- ============================================================================
-- AI-powered code suggestions that appear as ghost text while typing.
-- Includes copilot-cmp for completion menu integration and codecompanion
-- for AI chat/refactoring. Disabled for LaTeX files. Accept with <C-l>.
-- ============================================================================
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true, -- Codetyper will use copilot when available
          auto_trigger = true,
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
          tex = false, -- Disable Copilot for LaTeX files by default
          ["."] = true,
        },
        copilot_node_command = "node", -- Node.js version must be > 16.x
        server_opts_overrides = {},
      })

      -- Disable Copilot when opening .tex files
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
        pattern = "tex",
        callback = function()
          -- Safely dismiss any active suggestions
          local ok, suggestion = pcall(require, "copilot.suggestion")
          if ok and suggestion and suggestion.is_visible() then
            suggestion.dismiss()
          end
          -- Disable Copilot for this buffer
          vim.cmd("Copilot disable")
        end,
        desc = "Disable Copilot for LaTeX files",
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = { "CodeCompanion" },
    config = function()
      require("codecompanion").setup({
        -- Use GitHub Copilot as the provider
        providers = {
          copilot = {
            enabled = true,
          },
        },
        -- Configure the UI
        ui = {
          window = {
            width = 0.8,
            height = 0.8,
          },
        },
      })
    end,
  },
}
