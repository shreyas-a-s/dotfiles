local M = {
	"Susensio/magic-bang.nvim",
	ft = { "sh", "python" },
	cmd = "Bang",
}

function M.config()
	local keymap = vim.keymap.set;
	keymap("n", "<leader>sb", "<CMD>Bang bash<CR>", { desc = "Bash" })
	keymap("n", "<leader>sp", "<CMD>Bang python3<CR>", { desc = "Python" })

	require("magic-bang").setup({})
end

return M
