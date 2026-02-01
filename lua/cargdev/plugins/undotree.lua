return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    { "<leader>tu", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
  },
  config = function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_SplitWidth = 35
    vim.g.undotree_DiffpanelHeight = 10
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_TreeNodeShape = "◉"
    vim.g.undotree_TreeVertShape = "│"
    vim.g.undotree_TreeSplitShape = "╱"
    vim.g.undotree_TreeReturnShape = "╲"
    vim.g.undotree_DiffAutoOpen = 1
    vim.g.undotree_HighlightChangedText = 1
    vim.g.undotree_HighlightChangedWithSign = 1
    vim.g.undotree_HighlightSyntaxAdd = "DiffAdd"
    vim.g.undotree_HighlightSyntaxChange = "DiffChange"
    vim.g.undotree_HighlightSyntaxDel = "DiffDelete"
  end,
}
