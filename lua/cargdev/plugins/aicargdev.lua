return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Always pull the latest change
    opts = {
      provider = "cargdev", -- API provider configuration
      providers = {
        cargdev = {
          name = "cargdev", -- Optional
          endpoint = "https://api-ai.cargdev.io", -- API endpoint
          api_key_name = "CARGDEV_API_KEY", -- reference the ENV VAR below
          model = "deepseek-r1:latest",
          __inherited_from = "ollama", -- ensures compatibility
          max_tokens = 8192,
        },
      },
    },
    -- Optional: Build from source if required
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- Syntax highlighting support
      "stevearc/dressing.nvim", -- UI elements
      "nvim-lua/plenary.nvim", -- Utility library
      "MunifTanjim/nui.nvim", -- UI library for modal components
      -- Optional dependencies:
      "nvim-tree/nvim-web-devicons", -- Icons support
      "zbirenbaum/copilot.lua", -- Copilot integration
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
          })
        end,
      },
    },
  },
}
