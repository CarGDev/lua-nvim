-- ============================================================================
-- GRUG-FAR: Search and replace
-- ============================================================================
-- Powerful find and replace plugin with live preview and regex support.
-- Provides project-wide search/replace with ripgrep backend.
-- Keymaps: <leader>sr for search, <leader>[sR for current word search.
-- ============================================================================

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
      replace = { n = "<leader>[r" },
      qflist = { n = "<leader>[q" },
      syncLocations = { n = "<leader>[s" },
      syncLine = { n = "<leader>[l" },
      close = { n = "q" },
      historyOpen = { n = "<leader>[t" },
      historyAdd = { n = "<leader>[a" },
      refresh = { n = "<leader>[f" },
      gotoLocation = { n = "<enter>[" },
      pickHistoryEntry = { n = "<enter>[" },
      Abort = { n = "<leader>[b" },
    },
  },
}
