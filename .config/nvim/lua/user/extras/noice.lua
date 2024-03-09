local M = {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
}

function M.config()
  require("noice").setup({
    cmdline = {
      format = {
        cmdline = { icon = "󰄾" },
      },
    },
    messages = {
      view_search = false,
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
      { -- Disable 'search hit BOTTOM' & 'search hit TOP' messages
        filter = { event = "msg_show", find = "search hit" },
        opts = { skip = true },
      },
      { -- Disable '--No lines in buffer--' messages
        filter = { event = "msg_show", find = "No lines in buffer" },
        opts = { skip = true },
      },
      { -- Disable message when indenting blocks of code
        filter = { event = "msg_show", find = ">ed" },
        opts = { skip = true },
      },
      { -- Disable message when unindenting blocks of code
        filter = { event = "msg_show", find = "<ed" },
        opts = { skip = true },
      },
      { -- Disable message when pasting lines
        filter = { event = "msg_show", find = "more lines" },
        opts = { skip = true },
      },
      { -- Disable message when yanking multiple lines
        filter = { event = "msg_show", find = "yanked" },
        opts = { skip = true },
      },
      { -- Disable 'x change, before' messages
        filter = { event = "msg_show", find = "before" },
        opts = { skip = true },
      },
      { -- Disable 'x change, after' messages
        filter = { event = "msg_show", find = "after" },
        opts = { skip = true },
      },
    },
  })
end

return M
