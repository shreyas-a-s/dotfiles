local M = {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
}

function M.config()
  require("notify").setup({
    timeout = 1500,
  })
end

return M
