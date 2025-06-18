return {
  --[[ dir = "/Users/carlos/Documents/SSD_Documents/personals/ideaDrop", ]]
  "CarGDev/ideadrop.nvim",
  name = "ideaDrop",
  config = function()
    require("ideaDrop").setup({
      idea_dir = "/Users/carlos/Nextcloud/ObsidianVault",
    })
  end,
}
