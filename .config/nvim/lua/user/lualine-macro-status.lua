-- source: https://www.reddit.com/r/neovim/comments/xy0tu1/comment/irfegvd/
-- Add lualine component to show macro recording status
-- Do that only if cmdheight = 0
if vim.api.nvim_get_option_value("cmdheight", {}) == 0 then
  local require_ok, lualine = pcall(require, "lualine")
  if require_ok then
    local opts = lualine.get_config()
    local status = {
      "macro-recording",
      color = { fg = "#FF9E64", bg = "#252525" },
      fmt = function()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return ""
        else
          return "@" .. string.upper(recording_register)
        end
      end,
    }
    table.insert(opts.sections.lualine_x, 1, status)
    lualine.setup(opts)
    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        lualine.refresh({
          place = { "statusline" },
        })
      end,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        -- This is going to seem really weird!
        -- Instead of just calling refresh we need to wait a moment because of the nature of
        -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
        -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
        -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
        -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
        local timer = vim.loop.new_timer()
        timer:start(
          50,
          0,
          vim.schedule_wrap(function()
            lualine.refresh({
              place = { "statusline" },
            })
          end)
        )
      end,
    })
  end
end
