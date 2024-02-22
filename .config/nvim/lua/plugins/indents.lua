return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "┊" },
      scope = { enabled = false },
    },
  },
  {
    "echasnovski/mini.indentscope",
    version = "*",
    opts = {
      symbol = "┊"
    },
  },
}
