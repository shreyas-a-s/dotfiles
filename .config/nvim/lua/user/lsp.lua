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
                        package_uninstalled = "✗"
                    },
                },
            }
        },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "b0o/schemastore.nvim",
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
                        border = "rounded",         -- Border around the notification window
                        x_padding = 0,              -- Padding from right edge of window boundary
                    },
                },
            }
        }
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

function M.common_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return capabilities
end

function M.config()
    local map = vim.keymap.set;
    map("n", "<leader>la", "<CMD>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Actions" })
    map("n", "<leader>li", "<CMD>LspInfo<CR>", { desc = "Info" })
    map("n", "<leader>lr", "<CMD>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
    map("n", "[d", "<CMD>lua vim.diagnostic.goto_prev({float = false})<CR>", { desc = "Prev Diagnostic" })
    map("n", "]d", "<CMD>lua vim.diagnostic.goto_next({float = false})<CR>", { desc = "Next Diagnostic" })

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
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    require("lspconfig.ui.windows").default_options.border = "rounded"

    for _, server in pairs(servers) do
        local opts = {
            on_attach = M.on_attach,
            capabilities = M.common_capabilities(),
        }

        local require_ok, settings = pcall(require, "user.lspsettings." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", settings, opts)
        end

        lspconfig[server].setup(opts)
    end
end

return M
