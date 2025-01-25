local M = {
	"Susensio/magic-bang.nvim",
	event = { "BufEnter", "BufNewFile" },
	cmd = "Bang",
}

function M.config()
	local map = vim.keymap.set;
	map("n", "<leader>sb", "<CMD>Bang bash<CR>", { desc = "Shebang: Bash" })
	map("n", "<leader>sp", "<CMD>Bang python3<CR>", { desc = "Shebang: Python" })

	require("magic-bang").setup({})
end

return M
