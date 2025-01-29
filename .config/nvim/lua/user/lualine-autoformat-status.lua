-- Add lualine component to indicate format on save
local require_ok, lualine = pcall(require, "lualine")
if require_ok then
	local opts = lualine.get_config()
	local status = {
		"autoformat-status",
		color = { fg = "#FF9E64", bg = "#252525" },
		fmt = function()
			if vim.g.autoformat_disable_filetypes[vim.bo.filetype] then
				return "󱫪"
			end
		end,
	}

	table.insert(opts.sections.lualine_x, 1, status)
	lualine.setup(opts)
end
