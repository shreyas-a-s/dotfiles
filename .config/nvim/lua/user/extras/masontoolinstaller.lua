local M = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "williamboman/mason.nvim" },
}

function M.config()
  require("mason-tool-installer").setup({
    ensure_installed = {
      "stylua",
      "prettier",
      "black",
      "isort",
      "shfmt",
      "clang-format",
    },
  })
end

return M
