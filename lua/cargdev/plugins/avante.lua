-- Get local config (loaded in core/init.lua)
local local_cfg = vim.g.cargdev_local or {}

-- Skip plugin if local config is missing required values
if not local_cfg.avante_dev_path then
  return {}
end

return {
  {
    dir = local_cfg.avante_dev_path,
    -- "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Always pull the latest change
    build = "make",  -- This will build on first load
    opts = {
      provider = "cargdev", -- API provider configuration
      mode = "agentic", -- Enable agentic mode for tool support
      debug = true, -- Enable debug logging to troubleshoot tools
      providers = {
        cargdev = {
          name = "cargdev", -- Optional
          endpoint = local_cfg.avante_endpoint,
          api_key_name = local_cfg.avante_api_key_name,
          model = local_cfg.avante_model,
          __inherited_from = "ollama", -- ensures compatibility
          max_tokens = 8192,
          -- Explicitly ensure tools are enabled
          disable_tools = false,
          -- Tool format: false = function calling (JSON tools in request), true = XML tool format (tools in prompt)
          use_ReAct_prompt = false, -- Use function calling format (OpenAI-compatible)
        },
      },
    },
    -- Build from source for development
    -- Run `make BUILD_FROM_SOURCE=true` to build Rust components
    -- You can also build manually: cd <avante_dev_path> && make
    build = "make BUILD_FROM_SOURCE=true",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      {
        "folke/snacks.nvim", -- for input provider snacks
        lazy = false,
        priority = 1001, -- Higher than dressing to override it
        dependencies = {
          "stevearc/dressing.nvim", -- Load after dressing to override it
        },
        config = function()
          require("snacks").setup({
            -- Enable all snacks modules
            bigfile = { enabled = true },
            dashboard = { 
              enabled = false, -- Disabled: using alpha-nvim for CARGDEV branding
            },
            explorer = { enabled = true },
            image = { 
              enabled = true,
              -- Auto-detect terminal (will try: kitty, wezterm, ghostty in order)
              -- If none found, image rendering will be disabled with warnings
              -- Note: LaTeX and Mermaid features require external tools:
              --   - LaTeX: tectonic or pdflatex
              --   - Mermaid: mmdc (Mermaid CLI)
              -- These warnings are informational and won't prevent basic image rendering
              terminal = nil, -- nil = auto-detect
            },
            input = { enabled = true },
            lazygit = { enabled = true },
            notifier = { enabled = true },
            picker = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            terminal = { enabled = true },
            toggle = { enabled = true },
            words = { 
              enabled = true,
              lsp = { enabled = false }, -- Disable LSP to prevent crashes
              hl = { enabled = true },
            },
          })

          -- Set up vim.ui.input and vim.ui.select for snacks
          -- Use vim.schedule to ensure this runs after all plugins are loaded
          vim.schedule(function()
            vim.ui.input = require("snacks.input").input
            vim.ui.select = require("snacks.picker").select
          end)
        end,
      },
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        "HakonHarnes/img-clip.nvim", -- Image pasting support
        event = "VeryLazy",
        opts = {
          -- Recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true, -- For Windows users
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "Avante" },
        config = function()
          require("render-markdown").setup({
            file_types = { "markdown", "Avante" },
            latex = { enabled = false }, -- Disable latex to avoid warning
            html = { enabled = false }, -- Disable html support to avoid warnings
            yaml = { enabled = false }, -- Disable yaml support to avoid warnings
          })
          -- Enable treesitter highlighter for markdown buffers
          vim.api.nvim_create_autocmd("FileType", {
            pattern = { "markdown", "Avante" },
            callback = function()
              vim.treesitter.start()
            end,
          })
        end,
      },
    },
  },
}
