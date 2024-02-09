return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      view ={
        side = "left",
        signcolumn = "no",
        width = 25,
      },
    })
  end,
}
