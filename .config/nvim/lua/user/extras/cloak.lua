local M = {
  "laytan/cloak.nvim",
  event = "VeryLazy",
}

function M.config()
  require("cloak").setup({
    patterns = {
      {
        file_pattern = ".env*",
        cloak_pattern = "=.+",
      },
    },
  })
end

return M
