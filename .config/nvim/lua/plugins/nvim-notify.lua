return {
  "rcarriga/nvim-notify",
  config = function ()
    require("notify").setup({
      render = "minimal",
      timeout = 500,
    })
    vim.notify = require("notify")
  end,
}
