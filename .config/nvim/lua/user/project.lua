local M = {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
}

function M.config()
  require("project_nvim").setup({
    detection_methods = { "pattern" },
  })
end

return M
