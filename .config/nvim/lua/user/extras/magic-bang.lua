local M = {
  "Susensio/magic-bang.nvim",
  event = { "BufEnter", "BufNewFile" },
  cmd = "Bang",
}

function M.config()
  require("which-key").add({
    { "<leader>sb", "<CMD>Bang bash<CR>", desc = "Shebang: Bash" },
    { "<leader>sp", "<CMD>Bang python3<CR>", desc = "Shebang: Python" },
  })

  require("magic-bang").setup({})
end

return M
