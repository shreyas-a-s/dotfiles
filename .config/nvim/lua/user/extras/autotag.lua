local M = {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" }
}

function M.config()
  require("nvim-ts-autotag").setup()
end

return M
