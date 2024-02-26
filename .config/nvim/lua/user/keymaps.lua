local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Redo
keymap("n", "U", "<CMD>redo<CR>", { desc = "Redo" })

-- Mimic shell movements
keymap("i", "<C-a>", "<ESC>I", { desc = "Go to beginning of line" })
keymap("i", "<C-e>", "<ESC>A", { desc = "Go to end of line" })

-- Move to window using <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Move to window using the <ctrl> arrow keys
keymap("n", "<C-Left>", "<C-w>h", { desc = "Go to left window", remap = true })
keymap("n", "<C-Down>", "<C-w>j", { desc = "Go to lower window", remap = true })
keymap("n", "<C-Up>", "<C-w>k", { desc = "Go to upper window", remap = true })
keymap("n", "<C-Right>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Navigate buffers using <ctrl> hl keys
keymap("n", "<S-h>", "<CMD>bprevious<CR>", { desc = "Prev buffer" })
keymap("n", "<S-l>", "<CMD>bnext<CR>", { desc = "Next buffer" })

-- Navigate buffers using <ctrl> arrow keys
keymap("n", "<S-Left>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<S-Right>", "<CMD>bnext<CR>", { desc = "Next buffer" })

-- Keep cursor centred while moving through search results
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Disable overwriting register content when pasting in visual mode
keymap("x", "p", [["_dP]])

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })