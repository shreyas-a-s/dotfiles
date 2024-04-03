vim.opt.backup = false            -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 0             -- value of 0 disables cmdline
vim.opt.ignorecase = true         -- ignore case in search patterns
vim.opt.mouse = "a"               -- allow the mouse to be used in neovim
vim.opt.pumheight = 10            -- pop up menu height (eg: cmp menu)
vim.opt.showmode = false          -- we don't need to see things like -- INSERT -- anymore
vim.opt.smartcase = true          -- smart case
vim.opt.smartindent = true        -- make indenting smarter again
vim.opt.breakindent = true        -- wrapped lines will be indended same as beginning of line
vim.opt.splitbelow = true         -- force all horizontal splits to go below current window
vim.opt.splitright = true         -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false          -- creates a swapfile
vim.opt.termguicolors = true      -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 300          -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true           -- enable persistent undo
vim.opt.updatetime = 100          -- faster completion (4000ms default)
vim.opt.writebackup = false       -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true          -- convert tabs to spaces
vim.opt.shiftwidth = 2            -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2               -- insert 2 spaces for a tab
vim.opt.softtabstop = 2           -- insert 2 spaces for a tab
vim.opt.number = true             -- set numbered lines
vim.opt.laststatus = 0            -- only the last window has status-line
vim.opt.showcmd = false           -- show command in last line of screen
vim.opt.ruler = false             -- show line and column number
vim.opt.relativenumber = true     -- set relative numbered lines
vim.opt.signcolumn = "yes"        -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false              -- display lines as one long line
vim.opt.scrolloff = 4             -- minimum number of lines to keep above and below cursor if 'nowrap' is set
vim.opt.sidescrolloff = 8         -- minimum number of columns to keep to left and to right of cursor if 'nowrap' is set 
vim.opt.shortmess:append("l")     -- use "999L, 888B" instead of "999 lines, 888 bytes"
vim.opt.shortmess:append("m")     -- use [+] instead of "[Modified]"
vim.opt.shortmess:append("r")     -- use [RO] instead of "[readonly]"
vim.opt.shortmess:append("c")     -- don't give ins-completion-menu messages

vim.cmd("set whichwrap+=<,>,[,],h,l") -- allow specified keys that move the cursor left/right to move to the previous/next line when the cursor is on the first/last character in the line
vim.cmd("set iskeyword+=-")           -- make '-' part of iskeyword

vim.g.netrw_banner = 0 -- hide netrw banner
