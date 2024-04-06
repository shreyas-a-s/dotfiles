local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  cmd = "Gitsigns",
}
M.config = function()
  local wk = require("which-key")
  wk.register({
    ["<leader>gp"] = { "<CMD>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
    ["<leader>gr"] = { "<CMD>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
    ["<leader>gR"] = { "<CMD>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
    ["<leader>gs"] = { "<CMD>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
    ["<leader>gu"] = { "<CMD>lua require 'gitsigns'.undo_stage_hunk()<CR>", "Undo Stage Hunk" },
    ["<leader>gb"] = { "<CMD>lua require 'gitsigns'.toggle_current_line_blame()<CR>", "Toggle line blame" },
  })

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
