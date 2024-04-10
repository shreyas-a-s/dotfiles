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

  -- Remap '-' only if current buffer is not netrw or nvim-tree
  vim.keymap.set("n", "-", function()
    if vim.bo.filetype ~= "netrw" and vim.bo.filetype ~= "NvimTree" then
      vim.cmd("Oil")
    else
      vim.cmd("-")
    end
  end, { desc = "Open parent directory" })
end

return M
