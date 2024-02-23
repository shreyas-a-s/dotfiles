return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    "folke/neodev.nvim",
  },
  config = function()
    local on_attach = function(_, bufnr)
      -- Function that lets us more easily define mappings specific for LSP related items
      local map = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      map("<leader>rn", vim.lsp.buf.rename, "Rename")
      map("<leader>ca", function()
        vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
      end, "Code actions")

      map("gd", require("telescope.builtin").lsp_definitions, "Goto definition")
      map("gr", require("telescope.builtin").lsp_references, "Goto references")
      map("gI", require("telescope.builtin").lsp_implementations, "Goto implementation")
      map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type definition")
      map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document symbols")
      map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")

      map("K", vim.lsp.buf.hover, "Hover documentation")
      map("<C-k>", vim.lsp.buf.signature_help, "Signature documentation")

      -- Lesser used LSP functionality
      map("gD", vim.lsp.buf.declaration, "Goto declaration")
      map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace add folder")
      map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace remove folder")
      map("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "Workspace list folders")

      -- Create a keymap to format buffer with LSP
      map("<leader>cf", function()
        vim.lsp.buf.format()
      end, "Format current buffer")
    end

    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    require("mason").setup()
    require("mason-lspconfig").setup()

    -- Enable the following language servers
    local servers = {
      pyright = {},
      html = { filetypes = { "html", "twig", "hbs" } },
      eslint = {},
      bashls = {},
      lua_ls = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    }

    -- Setup neovim lua configuration
    require("neodev").setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        })
      end,
    })
  end,
}
