return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting
    null_ls.setup({
      sources = {
        -- Lua
        formatting.stylua.with({
          extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        }),

        -- Shell scripts
        diagnostics.shellcheck,
        formatting.beautysh.with({
          extra_args = { "-i", "2" },
        }),

        -- Python
        formatting.black,
        formatting.isort,

        -- Web dev (html, js, css. etc.)
        diagnostics.eslint,
        formatting.prettier,
      },
    })
  end,
}
