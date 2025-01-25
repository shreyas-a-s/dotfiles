-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable relative line numbers
vim.opt.relativenumber = true

-- Disable mouse mode
vim.opt.mouse = ""

-- Don"t show the mode, since it"s already in the status line.
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time.
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on.
vim.opt.cursorline = true

-- Minimum number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Minimum number of columns to keep to left and to right of cursor if "nowrap" is set.
vim.opt.sidescrolloff = 1

-- Disable line wrap
vim.opt.wrap = false

-- Hide netrw banner
vim.g.netrw_banner = 0

-- Indentation Changes
vim.opt.expandtab = false  -- Don"t convert tabs to spaces
vim.opt.shiftwidth = 4     -- The number of spaces inserted for each indentation
vim.opt.tabstop = 4        -- Insert 4 spaces for a tab
vim.opt.softtabstop = 4    -- Same thing
vim.opt.smartindent = true -- Make indenting smarter again

-- Swap, undo and backup file changes
vim.opt.swapfile = false    -- Creates a swapfile
vim.opt.undofile = true     -- Enable persistent undo
vim.opt.backup = false      -- Creates a backup file
vim.opt.writebackup = false -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- Some minor changes to messages
vim.opt.shortmess:append("l") -- Use "999L, 888B" instead of "999 lines, 888 bytes"
vim.opt.shortmess:append("m") -- Use [+] instead of "[Modified]"
vim.opt.shortmess:append("r") -- Use [RO] instead of "[readonly]"
vim.opt.shortmess:append("c") -- Don"t give ins-completion-menu messages
