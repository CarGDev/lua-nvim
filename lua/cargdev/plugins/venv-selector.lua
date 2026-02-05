-- ============================================================================
-- VENV-SELECTOR: Python virtual environment manager
-- ============================================================================
-- Provides a Telescope-based picker to select and activate Python virtual
-- environments. Supports multiple venv types: anaconda, pipenv, poetry, hatch,
-- pyenv, and standard virtualenvs. Automatically activates cached venvs.
-- Keymaps:
--   <leader>vs - Open venv selector picker
--   <leader>vc - Select cached venv
-- Autocmd:
--   Auto-retrieves cached venv when opening Python files with pyproject.toml
-- ============================================================================

return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
    "mfussenegger/nvim-dap-python",
  },
  ft = "python",
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
    { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select cached venv" },
  },
  opts = {
    settings = {
      search = {
        root = vim.fn.getcwd(),
        workspace = true,
        file = true,
        anaconda_envs = true,
        anaconda_base = true,
        pipenv = true,
        poetry = true,
        hatch = true,
        virtualenvs = true,
        pyenv = true,
        venv = true,
      },
      options = {
        on_venv_activate_callback = nil,
        enable_default_searches = true,
        enable_cached_venvs = true,
        cached_venv_automatic_activation = true,
        activate_venv_in_terminal = true,
        set_environment_variables = true,
        notify_user_on_venv_activation = true,
      },
    },
  },
  config = function(_, opts)
    require("venv-selector").setup(opts)

    -- Auto-select venv when opening Python files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function()
        local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
        if venv ~= "" then
          require("venv-selector").retrieve_from_cache()
        end
      end,
      once = true,
    })
  end,
}
