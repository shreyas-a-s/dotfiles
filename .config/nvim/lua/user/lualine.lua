local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
}

function M.config()
  require("lualine").setup({
    options = {
      icons_enabled = false,
      theme = "codedark",
      component_separators = "┊",
      section_separators = "",
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
        { "branch" },
        { "diagnostics", icons_enabled = true },
        {
          "filename",
          path = 1,
          color = { fg = "#CACFD2" },
          symbols = {
            modified = "●",
            readonly = "",
            unnamed = "",
            newfile = "",
          },
        },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {
        {
          require("noice").api.status.mode.get,
          cond = require("noice").api.status.mode.has,
          color = { fg = "#FF9E64" },
        },
        {
          "encoding",
          fmt = function(str)
            return str:gsub("%l", string.upper)
          end,
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
