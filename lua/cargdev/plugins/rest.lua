return {
  "rest-nvim/rest.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "http")
    end,
  },
  config = function()
    -- Basic configuration for rest.nvim
    vim.g.rest_nvim = {
      -- Enable request highlighting
      highlight = {
        enable = true,
        timeout = 750,
      },
      -- Enable response formatting
      response = {
        hooks = {
          format = true,
          decode_url = true,
        },
      },
      -- Enable cookies
      cookies = {
        enable = true,
      },
      -- Enable environment variables
      env = {
        enable = true,
        pattern = ".*%.env.*",
      },
      -- UI configuration
      ui = {
        winbar = true,
        keybinds = {
          prev = "H",
          next = "L",
        },
      },
    }
  end,
}
