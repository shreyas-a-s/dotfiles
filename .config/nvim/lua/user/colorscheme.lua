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
end

return M
