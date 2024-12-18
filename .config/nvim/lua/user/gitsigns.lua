local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  cmd = "Gitsigns",
}
M.config = function()
  local wk = require("which-key")
  wk.add({
    { "<leader>gR", "<CMD>lua require 'gitsigns'.reset_buffer()<CR>", desc = "Reset Buffer" },
    { "<leader>gp", "<CMD>lua require 'gitsigns'.preview_hunk()<CR>", desc = "Preview Hunk" },
    { "<leader>gr", "<CMD>lua require 'gitsigns'.reset_hunk()<CR>", desc = "Reset Hunk" },
    { "<leader>gs", "<CMD>lua require 'gitsigns'.stage_hunk()<CR>", desc = "Stage Hunk" },
    { "<leader>gu", "<CMD>lua require 'gitsigns'.undo_stage_hunk()<CR>", desc = "Undo Stage Hunk" },
    { "<leader>tb", "<CMD>lua require 'gitsigns'.toggle_current_line_blame()<CR>", desc = "Toggle Line blame" },
    { "[h", "<CMD>lua require 'gitsigns'.prev_hunk({navigation_message = false})<CR>", desc = "Prev Hunk" },
    { "]h", "<CMD>lua require 'gitsigns'.next_hunk({navigation_message = false})<CR>", desc = "Next Hunk" },
  })
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
