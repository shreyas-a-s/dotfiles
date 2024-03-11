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
    t = {
      name = "Tab",
      n = { "<CMD>$tabnew<CR>", "New Empty Tab" },
      N = { "<CMD>tabnew %<CR>", "New Tab" },
      o = { "<CMD>tabonly<CR>", "Only" },
      j = { "<CMD>-tabmove<CR>", "Move Left" },
      k = { "<CMD>+tabmove<CR>", "Move Right" },
    },
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
