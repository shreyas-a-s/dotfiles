local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "folke/neodev.nvim" },
  },
}

local function lsp_keymaps(bufnr)
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
  keymap(bufnr, "n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true , desc = "Goto declaration" })
  keymap(bufnr, "n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true , desc = "Goto definition" })
  keymap(bufnr, "n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true , desc = "Goto implementation" })
  keymap(bufnr, "n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true , desc = "Goto references" })
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  -- Show diagnostics popup
  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    callback = function()
      vim.diagnostic.open_float(nil,{focusable=false})
    end,
  })
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>la"] = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code Actions" },
    ["<leader>lf"] = {
      "<CMD>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
      "Format",
    },
    ["<leader>li"] = { "<CMD>LspInfo<CR>", "Info" },
    ["<leader>ll"] = { "<CMD>lua vim.lsp.codelens.run()<CR>", "CodeLens Actions" },
    ["<leader>lr"] = { "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename" },
    ["<leader>df"] = { "<CMD>lua vim.diagnostic.open_float()<CR>", "Diagnostics Open Float" },
    ["<leader>dj"] = { "<CMD>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
    ["<leader>dk"] = { "<CMD>lua vim.diagnostic.goto_prev()<CR>", "Prev Diagnostic" },
    ["<leader>dq"] = { "<CMD>lua vim.diagnostic.setloclist()<CR>", "Diagnostics to Quickfix" },
  }

  local lspconfig = require "lspconfig"
  local icons = require "user.icons"

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
  }

  local default_diagnostic_config = {
    signs = {
      values = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
      },
    },
    virtual_text = false,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
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
      require("neodev").setup {}
    end

    lspconfig[server].setup(opts)
  end
end

return M
