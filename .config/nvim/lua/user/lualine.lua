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
					end
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
					cond = function()
						if vim.bo.filetype == "TelescopePrompt" or
							vim.bo.filetype == "NvimTree" or
							vim.bo.filetype == "toggleterm" or
							vim.bo.filetype == "harpoon" or
							vim.bo.filetype == "alpha" or
							vim.bo.filetype == "lazy" or
							vim.bo.filetype == "mason" or
							vim.bo.filetype == "fugitive" then
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
						readonly = "",
						unnamed = "",
						newfile = "󰎔",
					},
					padding = { left = 0, right = 1 },
					separator = { left = "", right = "┊" },
				},
			},
			lualine_x = {
			},
			lualine_y = {
				{
					"filetype",
					icons_enabled = true
				}
			},
			lualine_z = {
				{
					"searchcount",
					padding = { left = 1, right = 0 },
					fmt = function(str)
						if str == "[0/0]" then return "" end
						return str:gsub("[%[%]]", "")
					end,
				},
				{
					"location"
				},
			},
		},
		extensions = { "quickfix", "man" },
	})

	-- Add lualine component to show macro recording status
	pcall(require("user.lualine-macro-status"))

	-- Add lualine component for showing whether a file is in harpoon
	pcall(require("user.lualine-harpoon-indicator"))
end

return M
