local M = {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
}

function M.config()
  vim.keymap.set("n", "<leader>te", "<CMD>NvimTreeToggle<CR>", {desc = "Toggle Explorer" })

  require("nvim-tree").setup({
    hijack_netrw = false,
    view = {
      signcolumn = "no",
    },
    renderer = {
      root_folder_label = false,
      icons = {
        diagnostics_placement = "before",
        symlink_arrow = "  ",
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
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
  })
end

return M
