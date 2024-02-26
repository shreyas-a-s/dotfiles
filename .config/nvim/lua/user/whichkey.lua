local M = {
  "folke/which-key.nvim",
}

function M.config()
  local mappings = {
    q = { "<CMD>confirm q<CR>", "Quit" },
    v = { "<CMD>vsplit<CR>", "Split" },
    b = { name = "Buffers" },
    c = { name = "Code" },
    d = { name = "Diagnostics" },
    f = { name = "Find" },
    g = { name = "Git" },
    h = { name = "Git hunk" },
    l = { name = "Lsp" },
    t = { name = "Toggle" },
    w = { name = "Workspace" },
    a = {
      name = "Tab",
      n = { "<CMD>$tabnew<CR>", "New Empty Tab" },
      N = { "<CMD>tabnew %<CR>", "New Tab" },
      o = { "<CMD>tabonly<CR>", "Only" },
      h = { "<CMD>-tabmove<CR>", "Move Left" },
      l = { "<CMD>+tabmove<CR>", "Move Right" },
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
