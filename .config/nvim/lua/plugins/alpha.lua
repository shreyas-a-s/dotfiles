return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("alpha").setup(require("alpha.themes.startify").opts)
    -- Disable header
    require("alpha.themes.startify").section.header.val = {}
  end,
}
