local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    { "nvim-telescope/telescope-ui-select.nvim", lazy = true },
  },
}

function M.config()
  require("which-key").add({
    { "<leader>fb", "<CMD>Telescope git_branches<CR>", desc = "Checkout branch" },
    { "<leader>fd", "<CMD>Telescope diagnostics<CR>", desc = "Diagnostics" },
    { "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fh", "<CMD>Telescope help_tags<CR>", desc = "Help" },
    { "<leader>fp", "<CMD>Telescope projects<CR>", desc = "Projects" },
    { "<leader>fr", "<CMD>Telescope oldfiles<CR>", desc = "Recent Files" },
    { "<leader>ft", "<CMD>Telescope live_grep<CR>", desc = "Find Text" },
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
