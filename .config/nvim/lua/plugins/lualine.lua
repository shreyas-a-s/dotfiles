return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = "┊",
        section_separators = "",
        disabled_filetypes = { "alpha" },
      },
      sections = {
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
        lualine_x = {
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          },
          {
            "encoding", fmt = function(str) return str:gsub("%l", string.upper) end,
          },
        },
        lualine_y = {
          {
            "progress", fmt = function(str) return str:gsub("%l", string.upper) end
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
      },
    })
  end,
}
