local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Increment/decrement number under cursor
keymap("n", "+", "<C-a>")
keymap("n", "-", "<C-x>")

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

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Disable overwriting register content when pasting in visual mode
keymap("x", "p", "P")

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Toggle line wrap
keymap("n", "<leader>w", "<CMD>lua vim.wo.wrap = not vim.wo.wrap<CR>", { desc = "Toggle wrap" })

-- Move chunk of text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", { desc = "Move text up", silent = true })
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", { desc = "Move text down", silent = true })
