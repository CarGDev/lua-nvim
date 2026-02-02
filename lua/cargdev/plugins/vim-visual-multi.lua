return {
  "mg979/vim-visual-multi",
  branch = "master",
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    -- Configuration must be set before plugin loads
    vim.g.VM_default_mappings = 1
    vim.g.VM_mouse_mappings = 1
    vim.g.VM_theme = "iceblue"

    vim.g.VM_maps = {
      ["Find Under"] = "<C-d>",           -- Like VS Code Ctrl+D
      ["Find Subword Under"] = "<C-d>",   -- Like VS Code Ctrl+D
      ["Select All"] = "<C-S-l>",         -- Like VS Code Ctrl+Shift+L
      ["Add Cursor Down"] = "<C-Down>",   -- Like VS Code
      ["Add Cursor Up"] = "<C-Up>",       -- Like VS Code
      ["Skip Region"] = "<C-x>",          -- Skip current and go to next
      ["Remove Region"] = "<C-S-p>",      -- Remove current cursor (changed from C-p)
      ["Undo"] = "u",
      ["Redo"] = "<C-r>",
    }

    -- Disable C-n and C-p in vim-visual-multi (reserved for buffer navigation)
    vim.g.VM_maps["Select Cursor Down"] = ""
    vim.g.VM_maps["Select Cursor Up"] = ""

    -- Highlight settings
    vim.g.VM_Mono_hl = "DiffText"
    vim.g.VM_Extend_hl = "DiffAdd"
    vim.g.VM_Cursor_hl = "Visual"
    vim.g.VM_Insert_hl = "DiffChange"

    -- Other settings
    vim.g.VM_leader = "\\"
    vim.g.VM_show_warnings = 1
    vim.g.VM_silent_exit = 0
    vim.g.VM_quit_after_leaving_insert_mode = 0
    vim.g.VM_skip_empty_lines = 1
    vim.g.VM_case_setting = "smart"
  end,
}
