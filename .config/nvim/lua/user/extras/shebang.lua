local M = {
  "Susensio/magic-bang.nvim",
  event = "BufNewFile",
  cmd = "Bang",
}

function M.config()
  require("which-key").register({
    ["<leader>sb"] = { "<CMD>Bang bash<CR>", "Shebang: Bash" },
    ["<leader>sp"] = { "<CMD>Bang python3<CR>", "Shebang: Python" },
  })

  require("magic-bang").setup({})
end

return M
