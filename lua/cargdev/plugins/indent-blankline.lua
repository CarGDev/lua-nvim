return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = { 
      char = "┊",
    },
    exclude = {
      filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
      buftypes = { "terminal", "nofile", "quickfix", "prompt" },
    },
    scope = { 
      enabled = false 
    },
  },
}

