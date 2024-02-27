local M = {
  "lewis6991/spaceless.nvim",
  event = "VeryLazy",
}

function M.config()
  require("spaceless").setup()
end

return M
