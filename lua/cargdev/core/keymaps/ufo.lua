--- nvim-ufo folding keymaps.
--- Overrides the default `z` fold commands with nvim-ufo equivalents for
--- improved fold rendering. Also overrides `K` to peek folded lines under
--- the cursor, falling back to LSP hover when no fold is present.
--- All keymaps are only registered when nvim-ufo loads successfully.
--- @module keymaps.ufo

local ok_ufo, ufo = pcall(require, "ufo")
local keymap = vim.keymap.set

if ok_ufo then
  --- Open every fold in the buffer.
  keymap("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })

  --- Close every fold in the buffer.
  keymap("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })

  --- Open folds except specific kinds (e.g. imports, comments).
  keymap("n", "zr", ufo.openFoldsExceptKinds, { desc = "Open folds except kinds" })

  --- Incrementally close folds by level.
  keymap("n", "zm", ufo.closeFoldsWith, { desc = "Close folds with" })

  --- Peek the folded lines under the cursor; fall back to LSP hover.
  keymap("n", "K", function()
    local winid = ufo.peekFoldedLinesUnderCursor()
    if not winid then
      vim.lsp.buf.hover()
    end
  end, { desc = "Peek fold or hover" })
end
