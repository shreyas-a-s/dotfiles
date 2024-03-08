local M = {
  "Susensio/magic-bang.nvim",
  event = "BufEnter",
  cmd = "Bang",
}

function M.config()
  require("which-key").register({
    ["<leader>sb"] = { "<CMD>Bang bash<CR>o", "Shebang: Bash" },
    ["<leader>sp"] = { "<CMD>Bang python3<CR>o", "Shebang: Python" },
  })

  require("magic-bang").setup({})
end

return M
