local M = {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
}

function M.config()
  require("toggleterm").setup({
    open_mapping = [[<C-\>]],
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.5
      end
    end,
    direction = "vertical",
    float_opts = {
      border = "rounded",
      width = function()
        return math.floor(vim.o.columns * 0.95)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.9)
      end,
    },
  })
end

return M
