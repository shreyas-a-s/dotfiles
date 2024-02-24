return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      presets = {
        z = false,
        g = false,
      },
    },
    window = {
      border = "rounded",
      padding = { 1, 1, 1, 1 },
    },
    show_help = false,
    show_keys = false,
  },
}
