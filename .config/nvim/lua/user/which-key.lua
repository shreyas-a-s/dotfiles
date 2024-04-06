local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  local mappings = {
    d = { name = "Diagnostics" },
    f = { name = "Find" },
    g = { name = "Git" },
    l = { name = "Lsp" },
    s = { name = "Shebang" },
  }

  local which_key = require("which-key")
  which_key.setup({
    plugins = {
      presets = {
        z = false,
        g = false,
      },
    },
    key_labels = {
      ["<space>"] = "space",
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

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
  }

  which_key.register(mappings, opts)
end

return M
