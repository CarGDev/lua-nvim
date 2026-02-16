-- ============================================================================
-- DROPBAR: Winbar with breadcrumb navigation
-- ============================================================================
-- Shows current code location as clickable breadcrumbs in the winbar.
-- Displays file path, class, function, etc. Click to navigate or use
-- telescope integration. Uses LSP and treesitter for accurate symbols.
-- Has BufUnload autocmd to clean up LSP references when buffers close.
-- ============================================================================
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
        file_icon = function(path)
          local file_icon = "󰈙 "
          local file_icon_hl = "DropBarIconKindFile"
          local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
          if not devicons_ok then
            return file_icon, file_icon_hl
          end
          local devicon, devicon_hl = devicons.get_icon(
            vim.fs.basename(path),
            vim.fn.fnamemodify(path, ":e"),
            { default = false }
          )
          if not devicon then
            local buf = vim.iter(vim.api.nvim_list_bufs()):find(function(b)
              return vim.api.nvim_buf_get_name(b) == path
            end)
            if buf then
              local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
              devicon, devicon_hl = devicons.get_icon_by_filetype(filetype)
            end
          end
          file_icon = devicon and devicon .. " " or file_icon
          file_icon_hl = devicon_hl or file_icon_hl
          return file_icon, file_icon_hl
        end,
        dir_icon = function(_)
          return " ", "DropBarIconKindFolder"
        end,
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
