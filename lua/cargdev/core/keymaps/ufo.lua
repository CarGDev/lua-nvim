-- nvim-ufo folding keymaps
local ok_ufo, ufo = pcall(require, "ufo")
local keymap = vim.keymap.set

if ok_ufo then
  keymap("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
  keymap("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
  keymap("n", "zr", ufo.openFoldsExceptKinds, { desc = "Open folds except kinds" })
  keymap("n", "zm", ufo.closeFoldsWith, { desc = "Close folds with" })
  keymap("n", "K", function()
    local winid = ufo.peekFoldedLinesUnderCursor()
    if not winid then
      vim.lsp.buf.hover()
    end
  end, { desc = "Peek fold or hover" })
end
