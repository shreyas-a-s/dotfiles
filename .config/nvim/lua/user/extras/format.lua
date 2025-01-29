local M = {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "Format",
		},
	},
}

-- Create table to store filetypes in which autoformat is disabled
local autoformat_disable_filetypes = {}
vim.g.autoformat_disable_filetypes = {}

-- Define keymap to add filetype to add filetype to table
vim.keymap.set("n", "<leader>tf", function()
	if autoformat_disable_filetypes[vim.bo.filetype] then
		autoformat_disable_filetypes[vim.bo.filetype] = false
	else
		autoformat_disable_filetypes[vim.bo.filetype] = true
	end

	-- Set vim global variable so that lualine can see it
	vim.g.autoformat_disable_filetypes = autoformat_disable_filetypes
end, { desc = "Toggle Auto Format" })

function M.config()
	require("conform").setup({
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Don't run on filetypes marked as disabled
			if autoformat_disable_filetypes[vim.bo[bufnr].filetype] then
				return
			end

			-- Disable "format_on_save lsp_fallback" for languages that don"t
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			local lsp_format_opt
			if disable_filetypes[vim.bo[bufnr].filetype] then
				lsp_format_opt = "never"
			else
				lsp_format_opt = "fallback"
			end
			return {
				timeout_ms = 500,
				lsp_format = lsp_format_opt,
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform can also run multiple formatters sequentially
			python = { "isort", "black" },

			-- You can use "stop_after_first" to run the first available formatter from the list
			javascript = { "prettierd", "prettier", stop_after_first = true },
		},
	})
end

return M
