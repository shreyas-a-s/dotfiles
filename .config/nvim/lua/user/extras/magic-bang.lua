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

  -- Auto add shebang to files even when current directory is not in $PATH
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
      "sh",
      "python",
    },
    callback = function()
      vim.cmd("Bang")
    end,
  })
end

return M
