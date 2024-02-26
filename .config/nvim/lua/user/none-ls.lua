local M = {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
  local null_ls = require("null-ls")

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup({
    sources = {
      formatting.stylua.with({
        extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      }),
      formatting.prettier.with({
        extra_filetypes = { "toml" },
        extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      }),
      formatting.shfmt.with({
        extra_args = { "-i", "2" },
      }),
      formatting.black.with({
        extra_args = { "--fast" },
      }),
      formatting.isort,
      null_ls.builtins.completion.spell,
    },
  })
end

return M
