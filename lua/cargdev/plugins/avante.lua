return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Always pull the latest change
    opts = {
      provider = "claude", -- API provider configuration
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-3-haiku-20240307",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 4096,
          },
        },
      },
    },
    -- Optional: Build from source if required
    build = "make",
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
        priority = 1000,
        config = function()
          require("snacks").setup({
            -- Enable all snacks modules
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = true },
            image = { enabled = true },
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
          vim.ui.input = require("snacks.input").input
          vim.ui.select = require("snacks.picker").select
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
          })
        end,
      },
    },
  },
}
