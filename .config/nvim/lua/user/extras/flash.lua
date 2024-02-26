local M = {
  "folke/flash.nvim",
}

function M.config()
  require("flash").setup({
    modes = {
      search = {
        enabled = false,
      },
    },
  })
end

return M
