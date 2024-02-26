local M = {
  "windwp/nvim-autopairs",
}

M.config = function()
  require("nvim-autopairs").setup({
    check_ts = true,
  })
end

return M
