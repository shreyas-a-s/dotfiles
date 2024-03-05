local M = {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
}

function M.config()
  require("project_nvim").setup({
    manual_mode = true,
    detection_methods = { "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml" },
  })
end

return M
