local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  main = 'nvim-treesitter.configs',   -- Sets main module to use for opts
  dependencies = { "nvim-treesitter/nvim-treesitter-context" }
}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "c",
      "comment",
      "css",
      "fish",
      "git_config",
      "gitcommit",
      "gitignore",
      "html",
      "java",
      "javascript",
      "json",
      "lua",
      "luadoc",
      "make",
      "markdown",
      "markdown_inline",
      "nix",
      "perl",
      "php",
      "python",
      "query",
      "ssh_config",
      "toml",
      "vim",
      "vimdoc",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  })
end

return M
