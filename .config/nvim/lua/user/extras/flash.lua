local M = {
  "folke/flash.nvim",
  event = "VeryLazy",
}

function M.config()
  local flash = require("flash")

  flash.setup({
    modes = {
      search = {
        enabled = false,
      },
    },
  })

  vim.keymap.set("n", "<leader>/", "<CMD>lua require('flash').jump()<CR>", { desc = "Flash" })
end

return M
