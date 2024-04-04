local M = {
  "Susensio/magic-bang.nvim",
  event = { "BufEnter", "BufNewFile" },
  cmd = "Bang",
}

function M.config()
  require("which-key").register({
    ["<leader>sb"] = { "<CMD>Bang bash<CR>", "Shebang: Bash" },
    ["<leader>sp"] = { "<CMD>Bang python3<CR>", "Shebang: Python" },
  })

  require("magic-bang").setup({})

  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
      "sh",
    },
    callback = function()
      vim.cmd("Bang bash")
    end,
  })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
      "python",
    },
    callback = function()
      vim.cmd("Bang python3")
    end,
  })
end

return M
