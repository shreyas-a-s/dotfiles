local M = {
  "antosha417/nvim-lsp-file-operations",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-tree.lua",
  },
}

function M.config()
  require("lsp-file-operations").setup({})
end

return M
