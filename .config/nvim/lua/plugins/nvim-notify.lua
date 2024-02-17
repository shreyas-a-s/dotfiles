return {
  "rcarriga/nvim-notify",
  config = function ()
    require("notify").setup({
      render = "minimal",
      timeout = 100,
    })
    vim.notify = require("notify")
  end,
}
