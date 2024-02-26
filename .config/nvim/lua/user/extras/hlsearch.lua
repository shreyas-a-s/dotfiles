local M = {
  "nvimdev/hlsearch.nvim",
  event = "BufRead",
}

function M.config()
  require("hlsearch").setup()
end

return M
