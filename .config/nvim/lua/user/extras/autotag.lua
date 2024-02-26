local M = {
  "windwp/nvim-ts-autotag",
  event = "VeryLazy",
}

function M.config()
  require("nvim-ts-autotag").setup({})
end

return M
