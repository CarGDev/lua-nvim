-- Get local config (loaded in core/init.lua)
local local_cfg = vim.g.cargdev_local or {}

-- Skip plugin if local config is missing required values
if not local_cfg.avante_dev_path then
  return {}
end

return {
  {
    dir = local_cfg.avante_dev_path,
    event = "VeryLazy",
    lazy = false,
    version = false,
    build = "make BUILD_FROM_SOURCE=true",
    opts = {
      provider = "cargdev",
      mode = "agentic",
      debug = true,
      providers = {
        cargdev = {
          name = "cargdev",
          endpoint = local_cfg.avante_endpoint,
          api_key_name = local_cfg.avante_api_key_name,
          model = local_cfg.avante_model,
          __inherited_from = "ollama",
          max_tokens = 8192,
          disable_tools = false,
          use_ReAct_prompt = false,
        },
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.pick",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
      "stevearc/dressing.nvim",
      "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "Avante" },
        config = function()
          require("render-markdown").setup({
            file_types = { "markdown", "Avante" },
            latex = { enabled = false },
            html = { enabled = false },
            yaml = { enabled = false },
          })
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
