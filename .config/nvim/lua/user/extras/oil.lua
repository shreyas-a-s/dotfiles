local M = {
  "stevearc/oil.nvim",
  event = "VeryLazy",
}

function M.config()
  require("oil").setup({
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
    },
  })
  vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Oil" })
end

return M
