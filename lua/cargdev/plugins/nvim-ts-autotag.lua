-- ============================================================================
-- NVIM-TS-AUTOTAG: Auto close and rename HTML/XML tags
-- ============================================================================
-- Automatically closes HTML/XML tags when you type '>'. Also renames matching
-- tags when you edit one. Uses treesitter for accurate tag detection.
-- Has BufDelete autocmd to clean up tag tracking when buffers close.
-- ============================================================================
return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = true,
    },
    per_filetype = {
      ["html"] = {
        enable_close = true,
      },
    },
  },
}
