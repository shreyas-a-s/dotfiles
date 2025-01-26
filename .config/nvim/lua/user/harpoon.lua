local M = {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  commit = "ccae1b9bec717ae284906b0bf83d720e59d12b91", -- Commit is specified to lock Harpoon to v1 i.e. to prevent v2 from getting installed.
  dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
  local keymap = vim.keymap.set
  local function opts(desc)
    return { noremap = true, silent = true, desc = desc }
  end

  keymap("n", "<S-m>", function() require('user.harpoon').mark_file() end, opts())
  keymap("n", "<leader>fm", function() require('harpoon.ui').toggle_quick_menu() end, opts("Marks"))
end

function M.mark_file()
  local mark = require("harpoon.mark")
  local buf_name = vim.fn.expand("%")
  local mark_exists = mark.get_index_of(buf_name)

  -- Add file to harpoon if it is new, otherwise remove it.
  if (mark_exists == nil) then
    mark.add_file()
  else
    mark.rm_file(buf_name)
  end

  -- Refresh lualine if it is loaded.
  local require_ok, lualine = pcall(require, "lualine")
  if require_ok then
    lualine.refresh({
      place = { "statusline" },
    })
  end
end

return M
