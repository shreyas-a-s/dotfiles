local M = {
	"folke/lazydev.nvim",
	ft = "lua",
}

function M.config()
	require("lazydev").setup({
		library = {
			-- Load luvit types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	});
end

return M
