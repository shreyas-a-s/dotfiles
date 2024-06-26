local M = {
  "kevinhwang91/nvim-hlslens",
}

function M.config()
  require("hlslens").setup({
    calm_down = true,
    nearest_only = true,
  })

  local opts = { noremap = true, silent = true }

  vim.api.nvim_set_keymap("n", "n",
    [[<Cmd>execute("normal! " . v:count1 . "n")<CR><Cmd>lua require("hlslens").start()<CR>]],
    opts)
  vim.api.nvim_set_keymap("n", "N",
    [[<Cmd>execute("normal! " . v:count1 . "N")<CR><Cmd>lua require("hlslens").start()<CR>]],
    opts)
  vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require("hlslens").start()<CR>]], opts)
end

return M
