-- Add lualine component to show inidcator if a file is in harpoon
local require_ok, lualine = pcall(require, "lualine")
if require_ok then
  local opts = lualine.get_config()
  local indicator = {
    "harpoon",
    color = { fg = "#FF9E64", bg = "#282E34" },
    fmt = function()
      if require("harpoon.mark").get_current_index() or vim.bo.filetype == "harpoon" then
        return "󰀱"
      end
    end,
  }
  table.insert(opts.sections.lualine_c, 2, indicator)
  lualine.setup(opts)
end
