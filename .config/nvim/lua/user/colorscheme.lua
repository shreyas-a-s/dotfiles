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
  require("lualine").setup({
    options = {
      theme = function()
        local tokyodark = require("lualine.themes.tokyodark")
        tokyodark.normal.z = tokyodark.normal.a
        return tokyodark
      end,
    },
  })

  vim.cmd([[
    :hi DiagnosticUnderlineWarn gui=undercurl guisp=Orange
    :hi DiagnosticUnderlineError gui=undercurl guisp=Red
    :hi DiagnosticUnderlineHint gui=undercurl guisp=LightGrey
    :hi DiagnosticUnderlineInfo gui=undercurl guisp=LightBlue
  ]])

end

return M
