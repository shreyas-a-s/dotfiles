local M = {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = ":call mkdp#util#install()",
}

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	callback = function()
		vim.keymap.set("n", "<leader>tm", "<CMD>MarkdownPreviewToggle<CR>",
			{ silent = true, desc = "Toggle markdown preview" })
	end,
})

return M
