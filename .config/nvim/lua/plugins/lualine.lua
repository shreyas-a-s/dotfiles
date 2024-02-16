return {
  "nvim-lualine/lualine.nvim",
  config = function()
    -- Function to show macro recording in lualine
    local function show_macro_recording()
      local recording_register = vim.fn.reg_recording()
      if recording_register == "" then
          return ""
      else
          return "Recording @" .. recording_register
      end
    end
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
            "macro-recording",
            fmt = show_macro_recording,
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
    -- Refresh lualine when recording macro
    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        require("lualine").refresh({
          place = { "statusline" },
        })
      end,
    })
    -- Wait for 50ms before refreshing lualine
    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        local timer = vim.loop.new_timer()
        timer:start(
          50,
          0,
          vim.schedule_wrap(function()
            require("lualine").refresh({
              place = { "statusline" },
            })
          end)
        )
      end,
    })
  end,
}
