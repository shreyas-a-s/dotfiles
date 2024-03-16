local M = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}

function M.config()
  require("nvim-treesitter.configs").setup {
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = { query = "@function.outer", desc = "Select around function" },
          ["if"] = { query = "@function.inner", desc = "Select inside function" },
          ["ac"] = { query = "@class.outer", desc = "Select around class" },
          ["ic"] = { query = "@class.inner", desc = "Select inside class" },
          ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        },
      },
    },
  }
end

return M
