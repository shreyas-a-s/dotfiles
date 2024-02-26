local M = {
  "j-hui/fidget.nvim",
}

function M.config()
  require("fidget").setup({
    notification = {
      window = {
        normal_hl = "CursorLineNr", -- Base highlight group in the notification window
        winblend = 0,
        border = "rounded",         -- Border around the notification window
        x_padding = 0,              -- Padding from right edge of window boundary
      },
    },
  })
end

return M
