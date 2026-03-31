-- ============================================================================
-- COLORSCHEME: Custom cyberpunk theme
-- ============================================================================
-- Custom color scheme with cyberpunk aesthetics. Supports transparency,
-- italic comments, bold keywords/functions/types. Loaded first (priority 1000)
-- to ensure consistent UI colors before other plugins load.
-- ============================================================================
-- Get local config (loaded in core/init.lua)
local local_cfg = vim.g.cargdev_local or {}

local repo = "CarGDev/cargdev-cyberpunk"
local localDir = nil

-- If requested to run color schema locally and a path is provided, use it.
if local_cfg.RUN_LOCAL_SCHEMA and local_cfg.SCHEMA_DIR and #local_cfg.SCHEMA_DIR > 0 then
  localDir = local_cfg.SCHEMA_DIR
end

return {
  repo,
  dir = localDir,
  name = "cargdev-cyberpunk",
  lazy = false,
  priority = 1000, -- Load before other plugins for consistent UI
  config = function()
    local opt = vim.opt
    opt.termguicolors = true
    opt.background = "dark"

    require("cargdev-cyberpunk").setup({
      transparent = true,
      italic_comments = true,
      bold_keywords = true,
      bold_functions = true,
      bold_types = true,

      -- Enable terminal colors
      terminal_colors = true,
    })
  end,
}
