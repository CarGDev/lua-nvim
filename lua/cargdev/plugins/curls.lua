return {
  "CarGDev/rest.nvim",
  build = function()
    -- Install LuaRocks dependencies for Lua 5.1 (Neovim uses LuaJIT which is Lua 5.1 compatible)
    local packages = { "mimetypes", "xml2lua" }
    for _, pkg in ipairs(packages) do
      local result = vim.fn.system("luarocks install --local --lua-version=5.1 " .. pkg .. " 2>&1")
      if vim.v.shell_error ~= 0 and not result:match("already installed") then
        vim.notify("Warning: Failed to install " .. pkg .. ": " .. result, vim.log.levels.WARN)
      end
    end
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "http")
    end,
  },
  config = function()
    -- Verify LuaRocks dependencies are available
    local function check_dependency(name)
      local success = pcall(require, name)
      if not success then
        vim.notify(
          string.format(
            "rest.nvim: Missing dependency '%s'. Please run: luarocks install --local %s",
            name,
            name
          ),
          vim.log.levels.WARN
        )
      end
      return success
    end

    -- Check for required dependencies
    check_dependency("mimetypes")
    check_dependency("xml2lua")

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
