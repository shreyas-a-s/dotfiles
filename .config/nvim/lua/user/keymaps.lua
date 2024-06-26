local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Disable overwriting register content when pasting in visual mode
keymap("x", "p", "P")

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Toggle line wrap
keymap("n", "<leader>tw", "<CMD>lua vim.wo.wrap = not vim.wo.wrap<CR>", { desc = "Toggle Wrap" })

-- Toggle conceal level
keymap("n", "<leader>tc", ":setlocal <C-R>=&conceallevel ? 'conceallevel=0' : 'conceallevel=3'<CR><CR>", { desc = "Toggle Conceal", silent = true })

-- Move chunk of text up and down
keymap("x", "<M-,>", ":move '>+1<CR>gv-gv", { desc = "Move text down", silent = true })
keymap("x", "<M-.>", ":move '<-2<CR>gv-gv", { desc = "Move text up", silent = true })

-- Delete word in insert mode using Ctrl + Backspace (<C-H> is interpreted by terminals as <C-BS>)
keymap("i", "<C-H>", "<C-w>")

-- Move between quickfix items
keymap("n", "]q", "<CMD>cnext<CR>", { desc = "Next quickfix", silent = true })
keymap("n", "[q", "<CMD>cprev<CR>", { desc = "Prev quickfix", silent = true })

-- Open current file in default program set by xdg based on filetype
keymap("n", "<leader>o", "<CMD>!xdg-open '%'<CR>", { desc = "Open", silent = true })

-- Use ESC to exit insert mode in terminal windows
keymap("t", "<ESC>", "<C-\\><C-n>", { silent = true })

-- Use ESC to remove search higlight
keymap("n", "<ESC>", "<CMD>nohlsearch<CR>", { silent = true })
