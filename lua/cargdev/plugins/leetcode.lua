return {
  "kawre/leetcode.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  cmd = { "Leet" }, -- lazy load on command
  opts = {
    ---@type string
    arg = "leetcode.nvim", -- for CLI mode
    ---@type lc.lang
    lang = "python3", -- or "cpp", "java", etc.
    logging = true,
    cn = {
      enabled = false, -- enable for leetcode.cn
      translator = true,
      translate_problems = true,
    },

    ---@type lc.storage
    storage = {
      home = vim.fn.stdpath("data") .. "/leetcode",
      cache = vim.fn.stdpath("cache") .. "/leetcode",
    },

    ---@type table<string, boolean>
    plugins = {
      non_standalone = true, -- allow use inside your regular session
    },

    ---@type boolean
    logging = true,

    cache = {
      update_interval = 60 * 60 * 24 * 7, ---@type integer 7 days
    },

    console = {
      open_on_runcode = true, ---@type boolean
      dir = "row", ---@type lc.direction
      size = { ---@type lc.size
        width = "90%",
        height = "75%",
      },
      result = {
        size = "60%", ---@type boolean
      },
      testcase = {
        virt_text = true, ---@type boolean
        size = "40%", ---@type lc.size
      },
    },

    description = {
      position = "left", ---@type lc.position
      width = "40%", ---@type lc.size
      show_stats = true, ---@type boolean
    },

    ---@type lc.picker
    picker = { provider = "telescope" },

    hooks = {
      ---@type fun()[]
      ["enter"] = {},

      ---@type fun(question: lc.ui.Question)[]
      ["question_enter"] = {},

      ---@type fun()[]
      ["leave"] = {},
    },

    injector = { ---@type table<lc.lang, lc.inject>
      ["python3"] = {
        before = true,
      },
    },

    keys = {
      toggle = { "q" }, ---@type string|string[]
      confirm = { "<CR>" }, ---@type string|string[]

      reset_testcases = "r", ---@type string
      use_testcase = "U", ---@type string
      focus_testcases = "H", ---@type string
      focus_result = "L", ---@type string
    },

    ---@type lc.highlights
    theme = {},

    ---@type boolean
    image_support = false,
  },
}
