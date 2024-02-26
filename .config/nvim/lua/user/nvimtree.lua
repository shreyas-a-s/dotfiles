local M = {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
}

function M.config()
  local wk = require("which-key")
  wk.register({
    ["<leader>e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
  })

  local icons = require("user.icons")

  require("nvim-tree").setup({
    hijack_netrw = false,
    filters = {
      custom = { "^.git$" },
    },
    renderer = {
      root_folder_label = false,
      icons = {
        glyphs = {
          git = {
            unstaged = icons.git.FileUnstaged,
            staged = icons.git.FileStaged,
            unmerged = icons.git.FileUnmerged,
            renamed = icons.git.FileRenamed,
            untracked = icons.git.FileUntracked,
            deleted = icons.git.FileDeleted,
            ignored = icons.git.FileIgnored,
          },
        },
      },
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },

    diagnostics = {
      enable = true,
      show_on_dirs = false,
      show_on_open_dirs = true,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = icons.diagnostics.Hint,
        info = icons.diagnostics.Information,
        warning = icons.diagnostics.Warning,
        error = icons.diagnostics.Error,
      },
    },
  })
end

return M
