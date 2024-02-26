local M = {
  "goolord/alpha-nvim",
  event = "VimEnter",
}

function M.config()
  require("alpha").setup(require("alpha.themes.startify").opts)
  require("alpha.themes.startify").section.header.val = {} -- Disable header
end

return M
