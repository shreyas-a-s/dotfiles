return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add          = { text = "▎" },
      change       = { text = "▎" },
      delete       = { text = "▎" },
      topdelete    = { text = "▎" },
      changedelete = { text = "▎" },
    },
    current_line_blame_opts = { delay = 250 },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map({ 'n', 'v' }, ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Git: Jump to next hunk' })

      map({ 'n', 'v' }, '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Git: Jump to previous hunk' })

      -- Actions
      -- visual mode
      map('v', '<leader>hs', function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Git: Stage hunk' })
      map('v', '<leader>hr', function()
        gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Git: Reset hunk' })
      -- normal mode
      map('n', '<leader>hs', gs.stage_hunk, { desc = 'Git: Stage hunk' })
      map('n', '<leader>hr', gs.reset_hunk, { desc = 'Git: Reset hunk' })
      map('n', '<leader>hS', gs.stage_buffer, { desc = 'Git: Stage buffer' })
      map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Git: Undo stage hunk' })
      map('n', '<leader>hR', gs.reset_buffer, { desc = 'Git: Reset buffer' })
      map('n', '<leader>hp', gs.preview_hunk, { desc = 'Git: Preview hunk' })
      map('n', '<leader>hb', function()
        gs.blame_line { full = false }
      end, { desc = 'Git: Blame line' })
      map('n', '<leader>hd', gs.diffthis, { desc = 'Git: Diff against index' })
      map('n', '<leader>hD', function()
        gs.diffthis '~'
      end, { desc = 'Git: Diff against last commit' })

      -- Toggles
      map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Git: Toggle blame line' })
      map('n', '<leader>td', gs.toggle_deleted, { desc = 'Git: Toggle show deleted' })

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Git: select git hunk' })
    end
  },
}
