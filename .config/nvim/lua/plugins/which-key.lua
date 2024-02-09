return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
  config = function ()
  local wk = require("which-key")
  wk.register({
    b = { name = "buffers" },
    c = { name = "code" },
    g = { name = "git" },
    f = { name = "file" },
    w = { name = "window" },
  }, { prefix = "<leader>" })
  end,
}
