local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp",     event = "InsertEnter" },
    { "hrsh7th/cmp-buffer",       event = "InsertEnter" },
    { "hrsh7th/cmp-path",         event = "InsertEnter" },
    { "hrsh7th/cmp-cmdline",      event = "InsertEnter" },
    { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
    { "L3MON4D3/LuaSnip",         event = "InsertEnter", dependencies = { "rafamadriz/friendly-snippets" } },
    { "hrsh7th/cmp-nvim-lua" },
  },
}

function M.config()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  require("luasnip.loaders.from_vscode").lazy_load()

  local icons = require("user.icons")

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert {
      -- Select the [n]ext item
      ["<C-n>"] = cmp.mapping.select_next_item(),
      -- Select the [p]revious item
      ["<C-p>"] = cmp.mapping.select_prev_item(),

      -- Scroll the documentation window [b]ack / [f]orward
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),

      -- Accept ([y]es) the completion.
      --  This will auto-import if your LSP supports it.
      --  This will expand snippets if the LSP sent a snippet.
      ["<C-y>"] = cmp.mapping.confirm { select = true },

      -- Manually trigger a completion from nvim-cmp.
      --  Generally you don"t need this, because nvim-cmp will display
      --  completions whenever it has completion options available.
      ["<C-Space>"] = cmp.mapping.complete {},

      -- Think of <c-l> as moving to the right of your snippet expansion.
      --  So if you have a snippet that"s like:
      --  function $name($args)
      --    $body
      --  end
      --
      -- <c-l> will move you to the right of each of the expansion locations.
      -- <c-h> is similar, except moving you backwards.
      ["<C-l>"] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { "i", "s" }),
      ["<C-h>"] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { "i", "s" }),
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = icons.kind[vim_item.kind]
        vim_item.menu = ({
          nvim_lsp = "",
          nvim_lua = "",
          luasnip = "",
          buffer = "",
          path = "",
        })[entry.source.name]

        return vim_item
      end,
    },
    sources = {
      { name = "nvim_lsp", max_item_count = 5 },
      { name = "luasnip",  max_item_count = 5 },
      { name = "nvim_lua", max_item_count = 5 },
      { name = "buffer",   max_item_count = 5 },
      { name = "path",     max_item_count = 5 },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      completion = {
        completeopt = "menu,menuone,noinsert",
        border = "rounded",
        scrollbar = false,
      },
      documentation = {
        border = "rounded",
      },
    },
  })
end

return M
