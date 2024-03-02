local M = {
  "folke/flash.nvim",
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

  vim.keymap.set("n", "<leader>/", function()
    flash.jump()
  end, { desc = "Flash" })
end

return M
