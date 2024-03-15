local M = {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
}

function M.config()
  local wk = require("which-key")
  wk.register({
    ["<leader><space>"] = { "<CMD>NvimTreeToggle<CR>", "Explorer" },
  })

  local icons = require("user.icons")

  require("nvim-tree").setup({
    hijack_netrw = false,
    renderer = {
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
      indent_markers = {
        enable = true
      },
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },

    diagnostics = {
      enable = true,
    },
  })
end

return M
