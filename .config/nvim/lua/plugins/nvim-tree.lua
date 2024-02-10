return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        side = "left",
        signcolumn = "auto",
        width = 26,
      },
      renderer = {
        root_folder_label = false,
      },
    })
  end,
}
