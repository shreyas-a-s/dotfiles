local M = {
	"iamcco/markdown-preview.nvim",
	event = "VeryLazy",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = "cd app && npm install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
}

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	callback = function()
		vim.keymap.set("n", "<leader>tm", "<CMD>MarkdownPreviewToggle<CR>", { silent = true, desc = "Toggle markdown preview" })
	end,
})

return M
