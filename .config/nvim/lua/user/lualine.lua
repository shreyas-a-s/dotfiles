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
        { "branch" },
      },
      lualine_c = {
        {
          "diagnostics",
          icons_enabled = true,
          color = { bg = "#252525" },
          cond = function()
            if vim.bo.filetype == "TelescopePrompt" or
              vim.bo.filetype == "NvimTree" or
              vim.bo.filetype == "toggleterm" or
              vim.bo.filetype == "harpoon" or
              vim.bo.filetype == "alpha" or
              vim.bo.filetype == "lazy" or
              vim.bo.filetype == "mason" then
              return false
            else
              return true
            end
          end,
        },
        { -- file path
          "filename",
          file_status = false,
          newfile_status = false,
          path = 1,
          color = { fg = "#4a5057" },
          padding = { left = 0, right = 0 },
          separator = { left = "", right = "" },
          fmt = function(str)
            local path = str:match("(.*/)")
            if path then
              return " " .. path
            else
              return " "
            end
          end,
          cond = function()
            if vim.bo.filetype == "TelescopePrompt" or
              vim.bo.filetype == "NvimTree" or
              vim.bo.filetype == "toggleterm" or
              vim.bo.filetype == "harpoon" or
              vim.bo.filetype == "alpha" or
              vim.bo.filetype == "lazy" or
              vim.bo.filetype == "mason" then
              return false
            else
              return true
            end
          end,
        },
        { -- file name
          "filename",
          symbols = {
            modified = "●",
            readonly = "",
            unnamed = "",
            newfile = "",
          },
          padding = { left = 0, right = 1 },
          separator = { left = "", right = "┊" },
          cond = function()
            if vim.bo.filetype == "TelescopePrompt" or
              vim.bo.filetype == "NvimTree" or
              vim.bo.filetype == "toggleterm" or
              vim.bo.filetype == "harpoon" or
              vim.bo.filetype == "alpha" or
              vim.bo.filetype == "lazy" or
              vim.bo.filetype == "mason" then
              return false
            else
              return true
            end
          end,
        },
        { -- special names for some file types
          "special-name",
          padding = { left = 0, right = 0 },
          fmt = function()
            if vim.bo.filetype == "TelescopePrompt" then
              return " telescope"
            elseif vim.bo.filetype == "NvimTree" then
              return " nvim-tree"
            elseif vim.bo.filetype == "toggleterm" then
              return " terminal"
            elseif vim.bo.filetype == "harpoon" then
              return " harpoon"
            elseif vim.bo.filetype == "alpha" then
              return " alpha"
            elseif vim.bo.filetype == "lazy" then
              return " lazy"
            elseif vim.bo.filetype == "mason" then
              return " mason"
            end
          end
        },
      },
      lualine_x = {},
      lualine_y = {
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

  -- Add lualine component to show macro recording status
  pcall(require("user.lualine-macro-status"))
end

return M
