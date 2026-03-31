-- ============================================================================
-- FZF-LUA: Fuzzy finder with LSP integration
-- ============================================================================
-- High-performance fuzzy finder written in Lua. Provides fast file search,
-- grep, LSP navigation (definitions, references, implementations), git operations,
-- and more. Replaces Telescope for better performance and native fzf feel.
-- ============================================================================
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
    { "<leader>fs", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
    { "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "Find help" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
    { "<leader>fc", "<cmd>FzfLua commands<cr>", desc = "Find commands" },
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Find keymaps" },
    { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "Find commands" },
    { "<leader>fG", "<cmd>FzfLua git_commits<cr>", desc = "Git commits" },
    { "<leader>fB", "<cmd>FzfLua git_bcommits<cr>", desc = "Git buffer commits" },
    { "<leader>fg", "<cmd>FzfLua git_branches<cr>", desc = "Git branches" },
    { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Git status" },
  },
  opts = {
    "default",
    winopts = {
      height = 0.85,
      width = 0.80,
      preview = {
        horizontal = "right:50%",
      },
    },
    keymap = {
      builtin = {
        ["<C-f>"] = "toggle-fullscreen",
        ["<C-r>"] = "toggle-preview-wrap",
        ["<C-p>"] = "toggle-preview",
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up",
      },
      fzf = {
        ["ctrl-a"] = "toggle-all",
        ["ctrl-d"] = "preview-page-down",
        ["ctrl-u"] = "preview-page-up",
      },
    },
    fzf_opts = {
      ["--layout"] = "reverse",
      ["--info"] = "inline",
    },
  },
}
