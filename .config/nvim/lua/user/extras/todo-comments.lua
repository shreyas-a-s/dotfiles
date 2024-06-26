local M = {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
  require("todo-comments").setup({
    signs = false,
  })

  -- Keymaps
  vim.keymap.set("n", "]c", function()
    require("todo-comments").jump_next()
  end, { desc = "Next todo comment" })

  vim.keymap.set("n", "[c", function()
    require("todo-comments").jump_prev()
  end, { desc = "Previous todo comment" })

  vim.keymap.set("n", "<leader>fc", "<CMD>TodoTelescope<CR>", { noremap = true, silent = true, desc = "Comments" })
end

return M
