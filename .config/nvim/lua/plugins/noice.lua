return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      config = function ()
        require("notify").setup({
          timeout = 750,
        })
      end,
    },
  },
  opts = {
    cmdline = {
      view = "cmdline",
      format = {
        cmdline = false,
        search_down = false,
        search_up = false,
        lua = false,
        help = false,
      },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      long_message_to_split = true,
      lsp_doc_border = true,
    },
  },
}
