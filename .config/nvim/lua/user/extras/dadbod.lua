local M = {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
}

function M.config()
	vim.g.db_ui_use_nerd_fonts = 1
	vim.keymap.set("n", "<leader>td", "<CMD>DBUIToggle<CR>", { desc = "Toggle Dadbod UI" })
end

return M
