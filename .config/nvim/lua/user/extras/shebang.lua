local M = {
  "Susensio/magic-bang.nvim",
  event = "BufNewFile",
  cmd = "Bang",
}

function M.config()
  require("magic-bang").setup({})
end

return M
