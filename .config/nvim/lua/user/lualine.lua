local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
}

function M.config()
  require("lualine").setup({
    options = {
      icons_enabled = false,
      theme = "auto",
      component_separators = "┊",
      section_separators = "",
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(str)
            return str:sub(1, 1)
          end,
        },
      },
      lualine_b = {
        { "branch", color = { bg = "#373737" } },
      },
      lualine_c = {
        { "diagnostics", icons_enabled = true },
        {
          "filename",
          path = 1,
          color = { fg = "#A4A4A4" },
          symbols = {
            modified = "●",
            readonly = "",
            unnamed = "",
            newfile = "",
          },
        },
      },
      lualine_x = {
        {
          require("noice").api.status.mode.get,
          cond = require("noice").api.status.mode.has,
          color = { fg = "#FF9E64" },
        },
      },
      lualine_y = {
        {
          "encoding",
          fmt = function(str)
            return str:gsub("%l", string.upper)
          end,
          color = { bg = "#373737" },
        },
      },
      lualine_z = {
        {
          "progress",
          fmt = function(str)
            return str:gsub("%l", string.upper)
          end,
        },
      },
    },
    inactive_sections = {
      lualine_c = {
        {
          "filename",
          path = 1,
          symbols = {
            modified = "●",
            readonly = "",
            unnamed = "",
            newfile = "",
          },
        },
      },
      lualine_x = {},
    },
    extensions = { "quickfix", "man", "fugitive" },
  })
end

return M
