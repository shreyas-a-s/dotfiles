local M = {
  "kevinhwang91/nvim-hlslens",
}

function M.config()
  require("hlslens").setup({
    calm_down = true,
    nearest_only = true,
  })
end

return M
