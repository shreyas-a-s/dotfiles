local M = {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  commit = "ccae1b9bec717ae284906b0bf83d720e59d12b91",
  dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
  local keymap = vim.keymap.set
  local function opts(desc)
    return { noremap = true, silent = true, desc = desc }
  end

  keymap("n", "<S-m>", "<CMD>lua require('user.harpoon').mark_file()<CR>", opts())
  keymap("n", "<leader>fm", "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts("Marks"))
end

function M.mark_file()
  require("harpoon.mark").add_file()
  vim.notify(" 󱡅  marked file", vim.log.levels.INFO, { title = "Harpoon" })
end

return M
