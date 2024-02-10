-- Local variable to simplify code
local opt = vim.opt

-- Disable netrw so that nvim-tree can take over
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Use 2 spaces instead of tabs for indentation
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- Enable 24-bit colors
opt.termguicolors = true

-- Enable line numbers
opt.number = true

-- Enable relative line numbers
opt.relativenumber = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Enable break indent
opt.breakindent = true

-- Enable mouse mode
opt.mouse = 'a'

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Sync clipboard between OS and Neovim.
opt.clipboard = "unnamedplus"

-- Save undo history
opt.undofile = true

-- Limit command history size
opt.history = 50

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})
