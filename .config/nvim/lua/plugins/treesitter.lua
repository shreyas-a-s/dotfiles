return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,
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
          "make",
          "markdown_inline",
          "nix",
          "perl",
          "php",
          "python",
          "ssh_config",
          "toml",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
        indent = { enable = true },
        autopairs = { enable = true },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
    end,
  },
}
