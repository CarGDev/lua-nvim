return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    { "<leader>sr", "<cmd>GrugFar<cr>", desc = "Search and Replace" },
    {
      "<leader>sR",
      function()
        require("grug-far").grug_far({ prefills = { search = vim.fn.expand("<cword>") } })
      end,
      desc = "Search current word",
    },
    {
      "<leader>sR",
      function()
        require("grug-far").with_visual_selection()
      end,
      mode = "v",
      desc = "Search selection",
    },
  },
  opts = {
    headerMaxWidth = 80,
    icons = {
      enabled = true,
      actionEntryBullet = " ",
      searchInput = " ",
      replaceInput = " ",
      filesFilterInput = " ",
      flagsInput = "󰮚 ",
      resultsStatusReady = "󱩊 ",
      resultsStatusError = " ",
      resultsStatusSuccess = "󰗡 ",
      resultsActionMessage = "  ",
      resultsChangeIndicator = "│",
      historyTitle = "  ",
    },
    startInInsertMode = false,
    windowCreationCommand = "vsplit",
    transitionDuration = 80,
    keymaps = {
      replace = { n = "<localleader>r" },
      qflist = { n = "<localleader>q" },
      syncLocations = { n = "<localleader>s" },
      syncLine = { n = "<localleader>l" },
      close = { n = "q" },
      historyOpen = { n = "<localleader>t" },
      historyAdd = { n = "<localleader>a" },
      refresh = { n = "<localleader>f" },
      gotoLocation = { n = "<enter>" },
      pickHistoryEntry = { n = "<enter>" },
      abort = { n = "<localleader>b" },
    },
  },
}
