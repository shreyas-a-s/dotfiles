local M = {
  "tiagovla/tokyodark.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}
function M.config()
  require("tokyodark").setup({
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
        identifiers = { italic = false },
        functions = {},
        variables = {},
    },
  })
  vim.cmd.colorscheme("tokyodark")

  -- Set right color to lualine section_z
  local custom_tokyodark = require("lualine.themes.tokyodark")
  custom_tokyodark.normal.z.bg = custom_tokyodark.normal.a.bg
  custom_tokyodark.normal.z.fg = custom_tokyodark.normal.a.fg
  custom_tokyodark.normal.z.gui = custom_tokyodark.normal.a.gui
  require("lualine").setup({
    options = {
      theme = custom_tokyodark,
    },
  })
end

return M
