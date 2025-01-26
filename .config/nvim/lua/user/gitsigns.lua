local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  cmd = "Gitsigns",
}

M.config = function()
  local keymap = vim.keymap.set
  keymap("n", "<leader>gR", function() require("gitsigns").reset_buffer() end, { desc = "Reset Buffer" })
  keymap("n", "<leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "Preview Hunk" })
  keymap("n", "<leader>gr", function() require("gitsigns").reset_hunk() end, { desc = "Reset Hunk" })
  keymap("n", "<leader>gs", function() require("gitsigns").stage_hunk() end, { desc = "Stage Hunk" })
  keymap("n", "<leader>gu", function() require("gitsigns").undo_stage_hunk() end, { desc = "Undo Staged Hunk" })
  keymap("n", "<leader>tb", function() require("gitsigns").toggle_current_line_blame() end,
    { desc = "Toggle Line blame" })
  keymap("n", "[c", function() require("gitsigns").prev_hunk({ navigation_message = false }) end,
    { desc = "Prev Change" })
  keymap("n", "]c", function() require("gitsigns").next_hunk({ navigation_message = false }) end,
    { desc = "Next Change" })
  keymap("v", "<leader>gs", function()
    require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "Stage Hunk" })
  keymap("v", "<leader>gr", function()
    require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "Reset Hunk" })

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
