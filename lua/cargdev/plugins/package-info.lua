return {
  "vuki656/package-info.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  ft = "json",
  opts = {
    colors = {
      up_to_date = "#3C4048",
      outdated = "#d19a66",
    },
    icons = {
      enable = true,
      style = {
        up_to_date = "|  ",
        outdated = "|  ",
      },
    },
    autostart = true,
    hide_up_to_date = false,
    hide_unstable_versions = false,
    package_manager = "npm",
  },
  keys = {
    { "<leader>ns", "<cmd>lua require('package-info').show()<cr>", desc = "Show package info" },
    { "<leader>nh", "<cmd>lua require('package-info').hide()<cr>", desc = "Hide package info" },
    { "<leader>nu", "<cmd>lua require('package-info').update()<cr>", desc = "Update package" },
    { "<leader>nd", "<cmd>lua require('package-info').delete()<cr>", desc = "Delete package" },
    { "<leader>ni", "<cmd>lua require('package-info').install()<cr>", desc = "Install package" },
    { "<leader>nc", "<cmd>lua require('package-info').change_version()<cr>", desc = "Change version" },
  },
}
