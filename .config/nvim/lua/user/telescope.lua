local M = {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable "make" == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons" }
	},
}

function M.config()
	local map = vim.keymap.set
	local builtin = require("telescope.builtin")
	map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
	map("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
	map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
	map("n", "<leader>fh", builtin.help_tags, { desc = "Help" })
	map("n", "<leader>fp", "<CMD>Telescope projects<CR>", { desc = "Projects" })
	map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
	map("n", "<leader>ft", builtin.live_grep, { desc = "Find Text" })

	require("telescope").setup({
		defaults = vim.tbl_extend("force", require("telescope.themes").get_dropdown(), {
			preview = false,
			prompt_prefix = " ",
			selection_caret = " ",
			entry_prefix = "  ",
			path_display = { "smart" },
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
				"--glob=!**/.git/*",
			},
			mappings = {
				i = {
					["<ESC>"] = require("telescope.actions").close,
				},
			},
		}),
		pickers = {
			find_files = {
				find_command = {
					"fd",
					"--color=never",
					"--hidden",
					"--type=f",
					"--strip-cwd-prefix",
					"--exclude=.cache",
					"--exclude=.git",
				},
			},
		},
	})

	-- Highlight filename differently than path in Telescope file pickers
	pcall(require("user.telescope-filename-highlight"))
	pcall(require("telescope").load_extension, "ui-select")
	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "projects")
end

return M
