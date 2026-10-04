-- ============================================================================
-- REST.NVIM: HTTP client
-- ============================================================================
-- Send HTTP requests straight from .http files and read the formatted response,
-- with cookie and .env variable support. Needs the treesitter `http` parser.
-- Example: write `GET https://example.com/api` in a .http file and run the request.
-- ============================================================================
return {
  -- Add the "http" parser (previously nested by mistake inside rest.nvim's `dependencies`)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "http")
    end,
  },
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      -- Basic configuration for rest.nvim
      vim.g.rest_nvim = {
        highlight = { enable = true, timeout = 750 },
        response = { hooks = { format = true, decode_url = true } },
        cookies = { enable = true },
        env = { enable = true, pattern = ".*%.env.*" },
        ui = { winbar = true, keybinds = { prev = "H", next = "L" } },
      }
    end,
  },
}
