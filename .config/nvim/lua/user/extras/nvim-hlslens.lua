local M = {
  "kevinhwang91/nvim-hlslens",
  event = "BufRead",
}

function M.config()
  require("hlslens").setup({
    calm_down = true,
    nearest_only = true,
  })
end

return M
