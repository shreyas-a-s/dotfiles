local M = {
  "smjonas/inc-rename.nvim",
  event = "VeryLazy",
}

function M.config()
  vim.keymap.set("n", "<leader>lr",function()
    return ":IncRename " .. vim.fn.expand("<cword>")
  end, { desc = "Rename", expr = true })

  require("inc_rename").setup({})
end

return M
