local M = {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
}

function M.config()
  require("noice").setup({
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
    messages = {
      view_search = "virtualtext",
    },
    lsp = {
      progress = {
        enabled = false,
      },
    },
    presets = {
      long_message_to_split = true,
      lsp_doc_border = true,
    },
    views = {
      notify = {
        replace = true,
      },
    },
    routes = {
      {
        filter = { event = "msg_show", find = "search hit" },
        opts = { skip = true },
      },
    },
  })
end

return M
