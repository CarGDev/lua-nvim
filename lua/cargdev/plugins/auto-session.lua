return {
  "rmagatti/auto-session",
  event = "VeryLazy",
  opts = {
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = false,
    auto_session_use_git_branch = true,
    auto_session_create_enabled = true,
    auto_session_enable_last_session = false,
    -- Don't auto-restore on startup to allow alpha to show
    auto_session_restore_on_startup = false,
  },
  config = function(_, opts)
    require("auto-session").setup(opts)
    
    -- Set recommended sessionoptions
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
  end,
}
