local M = {
	"nvim-lualine/lualine.nvim",
}

function M.config()
	require("lualine").setup({
		options = {
			icons_enabled = false,
			theme = "auto",
			component_separators = "",
			section_separators = "",
			globalstatus = false,
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
				{
					"branch",
					fmt = function(str)
						if str ~= "" then
							return " " .. str
						end
					end,
					cond = function()
						return vim.api.nvim_win_get_width(0) >= 40
					end,
				},
				{
					"diff",
				},
				{
					"diagnostics",
					icons_enabled = true,
				},
			},
			lualine_c = {
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
				},
				{ -- file name
					"filename",
					symbols = {
						modified = "●",
						readonly = "",
						unnamed = "",
						newfile = "󰎔",
					},
					padding = { left = 0, right = 1 },
				},
			},
			lualine_x = {},
			lualine_y = {
				{
					"filetype",
					icons_enabled = true,
					cond = function()
						return vim.api.nvim_win_get_width(0) >= 40
					end,
				},
			},
			lualine_z = {
				{
					"searchcount",
					padding = { left = 1, right = 0 },
					fmt = function(str)
						if str == "[0/0]" then
							return ""
						end
						return str:gsub("[%[%]]", "")
					end,
				},
				{
					"location",
					fmt = function(str)
						return str:gsub("%s+", "")
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
						readonly = "",
						unnamed = "",
						newfile = "󰎔",
					},
				},
			},
			lualine_x = {
				{
					"location",
					fmt = function(str)
						return str:gsub("%s+", "")
					end,
				},
			},
			lualine_y = {},
			lualine_z = {},
		},
		extensions = { "quickfix", "man" },
	})

	-- Add lualine component to show macro recording status
	pcall(require("user.lualine-macro-status"))

	-- Add lualine component for showing whether a file is in harpoon
	pcall(require("user.lualine-harpoon-indicator"))

	-- Add lualine component for showing whether autoformat is enabled or not
	pcall(require("user.lualine-autoformat-status"))
end

return M
