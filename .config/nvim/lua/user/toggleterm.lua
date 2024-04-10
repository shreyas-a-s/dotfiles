local M = {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
}

function M.config()
  require("toggleterm").setup({
    direction = "float",
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
  vim.keymap.set({ "n", "t" }, "<leader>tt", "<CMD>ToggleTerm<CR>", { silent = true, desc = "Toggle Terminal" })
end

return M
