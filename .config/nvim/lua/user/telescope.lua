local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    { "nvim-telescope/telescope-ui-select.nvim", lazy = true },
  },
}

function M.config()
  require("which-key").register({
    ["<leader>fb"] = { "<CMD>Telescope buffers<CR>", "Buffers" },
    ["<leader>fg"] = { "<CMD>Telescope git_branches<CR>", "Checkout branch" },
    ["<leader>ff"] = { "<CMD>Telescope find_files<CR>", "Find files" },
    ["<leader>fp"] = { "<CMD>Telescope projects<CR>", "Projects" },
    ["<leader>ft"] = { "<CMD>Telescope live_grep<CR>", "Find Text" },
    ["<leader>fh"] = { "<CMD>Telescope help_tags<CR>", "Help" },
    ["<leader>fc"] = { "<CMD>Telescope colorscheme<CR>", "Colorscheme" },
    ["<leader>fr"] = { "<CMD>Telescope oldfiles<CR>", "Recent Files" },
    ["<leader>fd"] = { "<CMD>Telescope diagnostics<CR>", "Diagnostics" },
  })

  require("telescope").setup({
    defaults = vim.tbl_extend(
      "force",
      require('telescope.themes').get_dropdown(),
      {
        preview = false,
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        path_display = { "smart" },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!**/.git/*",
        },
        mappings = {
          i = {
            ["<ESC>"] = require("telescope.actions").close,
          },
        },
      }
    ),
    pickers = {
      find_files = {
        find_command = {
          "fd",
          "--color=never",
          "--hidden",
          "--type=f",
          "--strip-cwd-prefix",
          "--exclude=.cache",
          "--exclude=.git",
        },
      },
    },
  })

  -- Highlight filename differently than path in Telescope file pickers
  pcall(require("user.telescope-filename-highlight"))

  pcall(require("telescope").load_extension, "ui-select")
  pcall(require("telescope").load_extension, "fzf")
  pcall(require("telescope").load_extension, "projects")
end

return M
