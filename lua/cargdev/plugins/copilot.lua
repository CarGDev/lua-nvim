return {
  {
    -- Main Copilot plugin
    "zbirenbaum/copilot.lua",
    lazy = false, -- Load at startup
    enabled = true,
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right | horizontal | vertical
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          trigger_on_accept = true,
          keymap = {
            accept = "<C-l>", -- Accept suggestion
            next = "<C-j>", -- Next suggestion
            prev = "<C-k>", -- Previous suggestion
            dismiss = "<C-x>", -- Dismiss suggestion
          },
        },
        filetypes = {
          markdown = true,
          ["*"] = true, -- Enable for all filetypes
        },
        copilot_node_command = "node", -- Ensure your system's Node.js is v20+
      })
    end,
  },
  {
    -- Copilot Chat plugin
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- Or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- For curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      layout = {
        position = "right", -- Position of the chat window
        ratio = 0.5,
      },
      floating = {
        enabled = true,
        border = "rounded",
      },
      prompts = {
        Rename = {
          prompt = "Please rename the variable correctly in given selection based on context",
          selection = function(source)
            local select = require("CopilotChat.select")
            return select.visual(source)
          end,
        },
      },
      keys = {
        { "<leader>zn", ":CopilotChatRename<CR>", mode = "v", desc = "Rename the variable" },
        { "<leader>zc", ":CopilotChat<CR>", mode = "n", desc = "Chat with Copilot" },
        { "<leader>ze", ":CopilotChatExplain<CR>", mode = "v", desc = "Explain Code" },
        { "<leader>zr", ":CopilotChatReview<CR>", mode = "v", desc = "Review Code" },
        { "<leader>zf", ":CopilotChatFix<CR>", mode = "v", desc = "Fix Code Issues" },
        { "<leader>zo", ":CopilotChatOptimize<CR>", mode = "v", desc = "Optimize Code" },
        { "<leader>zd", ":CopilotChatDocs<CR>", mode = "v", desc = "Generate Docs" },
      },
    },
  },
}
