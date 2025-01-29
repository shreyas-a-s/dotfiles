-- source: https://www.reddit.com/r/neovim/comments/xy0tu1/comment/irfegvd/
-- Add lualine component to show macro recording status
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
end
