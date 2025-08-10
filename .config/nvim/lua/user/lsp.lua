local M = {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = {
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"b0o/schemastore.nvim",
		{
			"saghen/blink.cmp",
			dependencies = "rafamadriz/friendly-snippets",
			version = "*",
			opts = {
				appearance = {
					use_nvim_cmp_as_default = true,
					nerd_font_variant = "mono",
				},
				sources = {
					per_filetype = {
						sql = { "snippets", "dadbod", "buffer" },
						mysql = { "snippets", "dadbod", "buffer" },
					},
					providers = {
						cmdline = {},
						dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
					},
				},
				completion = {
					menu = {
						border = "rounded",
					},
				},
			},
		},
		"nvim-telescope/telescope.nvim",
		{
			"j-hui/fidget.nvim",
			opts = {
				progress = {
					display = {
						done_icon = "",
					},
				},
				notification = {
					window = {
						normal_hl = "CursorLineNr", -- Base highlight group in the notification window
						winblend = 0,
						border = "rounded", -- Border around the notification window
						x_padding = 0, -- Padding from right edge of window boundary
					},
				},
			},
		},
	},
}

local function lsp_keymaps(bufnr)
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", { desc = "Goto declaration" })
	keymap(bufnr, "n", "gd", "<CMD>Telescope lsp_definitions<CR>", { desc = "Goto definition" })
	keymap(bufnr, "n", "gi", "<CMD>Telescope lsp_implementations<CR>", { desc = "Goto implementation" })
	keymap(bufnr, "n", "gr", "<CMD>Telescope lsp_references<CR>", { desc = "Goto references" })
end

M.on_attach = function(_, bufnr)
	lsp_keymaps(bufnr)
end

function M.config()
	local keymap = vim.keymap.set
	keymap("n", "<leader>dp", "<CMD>lua vim.diagnostic.open_float()<CR>", { desc = "Diagnostics Open Float" })
	keymap("n", "<leader>la", "<CMD>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Actions" })
	keymap("n", "<leader>li", vim.cmd.LspInfo, { desc = "Info" })
	keymap("n", "<leader>lr", "<CMD>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
	keymap("n", "[d", "<CMD>lua vim.diagnostic.goto_prev({float = false})<CR>", { desc = "Prev Diagnostic" })
	keymap("n", "]d", "<CMD>lua vim.diagnostic.goto_next({float = false})<CR>", { desc = "Next Diagnostic" })

	local lspconfig = require("lspconfig")

	local servers = {
		"lua_ls",
		"cssls",
		"html",
		"ts_ls",
		"bashls",
		"jsonls",
		"yamlls",
	}

	require("mason-lspconfig").setup({
		ensure_installed = servers,
	})

	local default_diagnostic_config = {
		signs = {
			values = {
				{ name = "DiagnosticSignError", text = "" },
				{ name = "DiagnosticSignWarn", text = "" },
				{ name = "DiagnosticSignHint", text = "󰌶" },
				{ name = "DiagnosticSignInfo", text = "" },
			},
		},
		virtual_text = {
			enabled = true,
			spacing = 2,
			prefix = "",
			suffix = "",
		},
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = function(_, i)
				return " " .. i .. ". "
			end,
		},
	}

	vim.diagnostic.config(default_diagnostic_config)

	for _, sign in ipairs(default_diagnostic_config.signs.values) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
	require("lspconfig.ui.windows").default_options.border = "rounded"

	local lsp_settings = {
		lua_ls = {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "spec" },
						disable = { "missing-fields" },
					},
				},
			},
		},
		jsonls = {
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		},
	}

	for _, server in pairs(servers) do
		local opts = {
			on_attach = M.on_attach,
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		}

		if lsp_settings[server] ~= nil then
			opts = vim.tbl_deep_extend("force", lsp_settings[server], opts)
		end

		lspconfig[server].setup(opts)
	end
end

return M
