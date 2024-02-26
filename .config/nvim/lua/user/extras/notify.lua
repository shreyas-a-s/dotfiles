local M = {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
}

function M.config()
  require("notify").setup({
    timeout = 1000,
  })
end

return M
