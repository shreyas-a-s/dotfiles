local M = {
	"mbbill/undotree",
}

function M.config()
	-- Configs
	vim.g.undotree_SetFocusWhenToggle = true
	vim.g.undotree_DiffAutoOpen = false
	vim.g.undotree_ShortIndicators = true

	-- Keymaps
	vim.keymap.set("n", "<leader>tu", vim.cmd.UndotreeToggle, { desc = "Undotree" })
end

return M
