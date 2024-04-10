local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { { "folke/neodev.nvim" } },
}

local function lsp_keymaps(bufnr)
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
  keymap(bufnr, "n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true , desc = "Goto declaration" })
  keymap(bufnr, "n", "gd", "<CMD>Telescope lsp_definitions<CR>", { noremap = true, silent = true , desc = "Goto definition" })
  keymap(bufnr, "n", "gi", "<CMD>Telescope lsp_implementations<CR>", { noremap = true, silent = true , desc = "Goto implementation" })
  keymap(bufnr, "n", "gr", "<CMD>Telescope lsp_references<CR>", { noremap = true, silent = true , desc = "Goto references" })
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
  local wk = require("which-key")
  wk.register({
    ["<leader>la"] = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code Actions" },
    ["<leader>lf"] = {
      "<CMD>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
      "Format",
    },
    ["<leader>li"] = { "<CMD>LspInfo<CR>", "Info" },
    ["<leader>lr"] = { "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename" },
    ["<leader>dp"] = { "<CMD>lua vim.diagnostic.open_float()<CR>", "Diagnostics Open Float" },
    ["]d"] = { "<CMD>lua vim.diagnostic.goto_next({float = false})<CR>", "Next Diagnostic" },
    ["[d"] = { "<CMD>lua vim.diagnostic.goto_prev({float = false})<CR>", "Prev Diagnostic" },
  })

  local lspconfig = require("lspconfig")

  local servers = {
    "lua_ls",
    "cssls",
    "html",
    "eslint",
    "tsserver",
    "pyright",
    "bashls",
    "jsonls",
    "yamlls",
    "intelephense",
    "clangd",
  }

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

  for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
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

    if server == "lua_ls" then
      require("neodev").setup({})
    end

    -- Fix for "Multiple different client offset_encodings detected"
    if server == "clangd" then
      opts = vim.tbl_deep_extend("force", { cmd = { "clangd", "--offset-encoding=utf-16" } }, opts)
    end

    lspconfig[server].setup(opts)
  end
end

return M
