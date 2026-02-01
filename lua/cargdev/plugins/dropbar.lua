return {
  "Bekaboo/dropbar.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
  },
  opts = {
    bar = {
      hover = true,
      sources = function(buf, _)
        local sources = require("dropbar.sources")
        local utils = require("dropbar.utils")
        if vim.bo[buf].ft == "markdown" then
          return { sources.markdown }
        end
        if vim.bo[buf].buftype == "terminal" then
          return { sources.terminal }
        end
        return {
          sources.path,
          utils.source.fallback({
            sources.lsp,
            sources.treesitter,
          }),
        }
      end,
      padding = {
        left = 1,
        right = 1,
      },
      pick = {
        pivots = "abcdefghijklmnopqrstuvwxyz",
      },
      truncate = true,
    },
    icons = {
      enable = true,
      kinds = {
        use_devicons = true,
        symbols = {
          Array = "󰅪 ",
          Boolean = " ",
          BreakStatement = "󰙧 ",
          Call = "󰃷 ",
          CaseStatement = "󱃙 ",
          Class = " ",
          Color = "󰏘 ",
          Constant = "󰏿 ",
          Constructor = " ",
          ContinueStatement = "→ ",
          Copilot = " ",
          Declaration = "󰙠 ",
          Delete = "󰩺 ",
          DoStatement = "󰑖 ",
          Enum = " ",
          EnumMember = " ",
          Event = " ",
          Field = " ",
          File = "󰈙 ",
          Folder = " ",
          ForStatement = "󰑖 ",
          Function = "󰊕 ",
          Identifier = "󰀫 ",
          IfStatement = "󰇉 ",
          Interface = " ",
          Keyword = "󰌋 ",
          List = "󰅪 ",
          Log = "󰦪 ",
          Lsp = " ",
          Macro = "󰁌 ",
          MarkdownH1 = "󰉫 ",
          MarkdownH2 = "󰉬 ",
          MarkdownH3 = "󰉭 ",
          MarkdownH4 = "󰉮 ",
          MarkdownH5 = "󰉯 ",
          MarkdownH6 = "󰉰 ",
          Method = "󰆧 ",
          Module = "󰏗 ",
          Namespace = "󰅩 ",
          Null = "󰟢 ",
          Number = "󰎠 ",
          Object = "󰅩 ",
          Operator = "󰆕 ",
          Package = "󰏗 ",
          Property = " ",
          Reference = "󰈇 ",
          Regex = " ",
          Repeat = "󰑖 ",
          Scope = "󰅩 ",
          Snippet = " ",
          Specifier = "󰦪 ",
          Statement = "󰅩 ",
          String = "󰉾 ",
          Struct = " ",
          SwitchStatement = "󰺟 ",
          Text = " ",
          Type = " ",
          TypeParameter = "󰆩 ",
          Unit = " ",
          Value = "󰎠 ",
          Variable = "󰀫 ",
          WhileStatement = "󰑖 ",
        },
      },
      ui = {
        bar = {
          separator = "  ",
          extends = "…",
        },
        menu = {
          separator = " ",
          indicator = " ",
        },
      },
    },
    menu = {
      quick_navigation = true,
      entry = {
        padding = {
          left = 1,
          right = 1,
        },
      },
      keymaps = {
        ["q"] = "<C-w>q",
        ["<Esc>"] = "<C-w>q",
      },
    },
    sources = {
      path = {
        relative_to = function()
          return vim.fn.getcwd()
        end,
      },
    },
  },
}
