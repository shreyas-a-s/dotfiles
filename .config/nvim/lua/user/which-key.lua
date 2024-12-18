local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  local mappings = {
    { "<leader>d", group = "Diagnostics" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>l", group = "Lsp" },
    { "<leader>s", group = "Shebang" },
    { "<leader>t", group = "Toggle" },
  }

  local which_key = require("which-key")
  which_key.setup({
    plugins = {
      presets = {
        z = false,
        g = false,
      },
    },
    replace = {
      key ={
        { "<space>", "SPC" }
      }
    },
    icons = {
      group = "",
      mappings = false
    },
    win = {
      border = "rounded",
      padding = { 1, 1, 1, 1 },
    },
    show_help = false,
    show_keys = false,
  })

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
  }

  which_key.add(mappings, opts)
end

return M
