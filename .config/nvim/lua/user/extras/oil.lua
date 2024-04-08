local M = {
  "stevearc/oil.nvim",
  event = "VeryLazy",
}

function M.config()
  require("oil").setup({
    default_file_explorer = false,
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
    },
  })
  vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

return M
