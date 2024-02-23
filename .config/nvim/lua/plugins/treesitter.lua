return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
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
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-Space>",
            node_incremental = "<C-Space>",
            scope_incremental = "<C-s>",
          },
        },
      })
    end,
  },
}
