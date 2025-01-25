local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  cmd = "Gitsigns",
}
M.config = function()
  local map = vim.keymap.set
  map("n", "<leader>gR", "<CMD>lua require 'gitsigns'.reset_buffer()<CR>", { desc = "Reset Buffer" })
  map("n", "<leader>gp", "<CMD>lua require 'gitsigns'.preview_hunk()<CR>", { desc = "Preview Hunk" })
  map("n", "<leader>gr", "<CMD>lua require 'gitsigns'.reset_hunk()<CR>", { desc = "Reset Hunk" })
  map("n", "<leader>gs", "<CMD>lua require 'gitsigns'.stage_hunk()<CR>", { desc = "Stage Hunk" })
  map("n", "<leader>gu", "<CMD>lua require 'gitsigns'.undo_stage_hunk()<CR>", { desc = "Undo Stage Hunk" })
  map("n", "<leader>tb", "<CMD>lua require 'gitsigns'.toggle_current_line_blame()<CR>", { desc = "Toggle Line blame" })
  map("n", "[c", "<CMD>lua require 'gitsigns'.prev_hunk({navigation_message = false})<CR>", { desc = "Prev Change" })
  map("n", "]c", "<CMD>lua require 'gitsigns'.next_hunk({navigation_message = false})<CR>", { desc = "Next Change" })
  local function opts(desc)
    return { noremap = true, silent = true, desc = desc }
  end
  vim.keymap.set("v", "<leader>gs", function()
    require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, opts("Stage Hunk"))
  vim.keymap.set("v", "<leader>gr", function()
    require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, opts("Reset Hunk"))

  require("gitsigns").setup({
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "▎" },
      topdelete = { text = "▎" },
      changedelete = { text = "▎" },
    },
    attach_to_untracked = true,
    update_debounce = 200,
    preview_config = {
      border = "rounded",
    },
    current_line_blame_opts = {
      delay = 250,
    },
  })
end

return M
