local M = {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
}

function M.config()
  local wk = require("which-key")
  wk.register({
    ["<leader><space>"] = { "<CMD>NvimTreeToggle<CR>", "Explorer" },
  })

  require("nvim-tree").setup({
    hijack_netrw = false,
    renderer = {
      icons = {
        glyphs = {
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = " ",
            untracked = "U",
            deleted = " ",
            ignored = "◌",
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
      icons = {
        hint = "󰌶",
        info = "",
        warning = "",
        error = "",
      },
    },
  })
end

return M
