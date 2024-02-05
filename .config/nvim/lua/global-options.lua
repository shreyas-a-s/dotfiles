-- Use 2 spaces instead of tabs for indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Enable line numbers
vim.wo.number = true

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = "unnamedplus"

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"
