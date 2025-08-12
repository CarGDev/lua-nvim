return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = { 
      char = "┊",
      exclude_filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" }
    },
    scope = { 
      enabled = false 
    },
    exclude = {
      filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" }
    }
  },
}
