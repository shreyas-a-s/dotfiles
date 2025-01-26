local M = {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
}

function M.config()
	require("ibl").setup({
		indent = { char = "┊" },
		scope = { enabled = false },
	})
end

return M
