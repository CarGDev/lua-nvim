return {
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
}
