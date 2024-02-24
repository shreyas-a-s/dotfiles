return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  config = function()
    require("telescope").setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    })
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("fzf")
    require("which-key").register({
      ["<leader>bb"] = { "<CMD>Telescope buffers previewer=false<CR>", "Find buffers" },
      ["<leader>ff"] = { "<CMD>Telescope find_files previewer=false<CR>", "Find files" },
      ["<leader>ft"] = { "<CMD>Telescope live_grep<CR>", "Find Text" },
      ["<leader>fh"] = { "<CMD>Telescope help_tags previewer=false<CR>", "Help" },
      ["<leader>fr"] = { "<CMD>Telescope oldfiles previewer=false<CR>", "Find recent files" },
    })
  end,
}
