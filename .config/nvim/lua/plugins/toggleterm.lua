return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    open_mapping = [[<C-\>]],
    direction = "float",
    float_opts = {
      border = "curved",
      width = function()
        return math.floor(vim.o.columns * 90 / 100)
      end,
      height = function()
        return math.floor(vim.o.lines * 90 / 100)
      end,
    },
  },
}
