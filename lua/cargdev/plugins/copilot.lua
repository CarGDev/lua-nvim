-- ============================================================================
-- COPILOT: GitHub AI code completion
-- ============================================================================
-- AI-powered code suggestions (ghost text + cmp menu).
-- Autocomplete: <C-l> accept ghost text, also shows in cmp menu.
-- Autocomplete model is controlled server-side by GitHub, not user-selectable.
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
}
