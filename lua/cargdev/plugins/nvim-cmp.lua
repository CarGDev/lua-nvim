return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "hrsh7th/cmp-nvim-lsp", -- LSP completion source
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")

    local luasnip = require("luasnip")

    local lspkind = require("lspkind")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
        -- Performance optimizations
        keyword_length = 2, -- Start completion after 2 characters
        keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]], -- Better keyword pattern
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        -- Tab is reserved for Copilot inline suggestions ONLY
        -- Use <C-j>/<C-k> to navigate cmp menu, <CR> to confirm
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- Check for Copilot inline suggestion first (highest priority)
          local copilot_ok, copilot_suggestion = pcall(require, "copilot.suggestion")
          if copilot_ok and copilot_suggestion.is_visible() then
            copilot_suggestion.accept()
            return
          end
          -- If no Copilot suggestion, handle snippet jumping
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            -- Default Tab behavior (insert tab character)
            fallback()
          end
        end, { "i", "s" }),
        -- Shift-Tab to go back in snippets
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000},
        { name = "copilot", priority = 900 }, -- GitHub Copilot suggestions
        { name = "luasnip", priority = 750 }, -- snippets
        { name = "buffer", priority = 500, keyword_length = 3 }, -- text within current buffer
        { name = "path", priority = 250 }, -- file system paths
      }),

      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
      
      -- Performance optimizations
      performance = {
        debounce = 50, -- Debounce completion requests
        throttle = 100, -- Throttle completion requests
        fetching_timeout = 200, -- Timeout for fetching completions
      },
      
      -- Reduce completion menu size for better performance
      window = {
        completion = {
          border = "rounded",
          scrollbar = false,
          col_offset = -3,
          side_padding = 0,
        },
        documentation = {
          border = "rounded",
          scrollbar = false,
        },
      },
    })
  end,
}
