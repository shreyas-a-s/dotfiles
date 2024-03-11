local M = {
  "shreyas-a-s/neodarker.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}
function M.config()
  vim.cmd.colorscheme("neodarker")

  -- Change some colors
  vim.cmd([[
    " Underline -> undercurl
    :hi DiagnosticUnderlineWarn gui=undercurl guisp=Orange
    :hi DiagnosticUnderlineError gui=undercurl guisp=Red
    :hi DiagnosticUnderlineHint gui=undercurl guisp=LightGrey
    :hi DiagnosticUnderlineInfo gui=undercurl guisp=LightBlue
    " NvimTree colors
    :hi NvimTreeExecFile guifg=#E28743
    :hi NvimTreeSpecialFile guifg=#DADA2D
  ]])

end

return M
