return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      plugins = {
        presets = {
          z = false,
          g = false,
        },
      },
      icons = {
        group = "",
      },
      window = {
        border = "rounded",
        padding = { 1, 1, 1, 1 },
      },
      show_help = false,
      show_keys = false,
    })
    wk.register({
      b = { name = "Buffers" },
      c = { name = "Code" },
      g = { name = "Goto" },
      h = { name = "Git hunk" },
      f = { name = "Find" },
      r = { name = "Rename" },
      t = { name = "Toggle" },
      w = { name = "Workspace" },
    }, { prefix = "<leader>" })
  end,
}
