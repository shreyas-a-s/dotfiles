local keymap = vim.keymap.set

-- Move to window using <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Toggle line wrap
keymap("n", "<leader>tw", "<CMD>lua vim.wo.wrap = not vim.wo.wrap<CR>", { desc = "Toggle Wrap" })

-- Toggle conceal level
keymap("n", "<leader>tc", ":setlocal <C-R>=&conceallevel ? 'conceallevel=0' : 'conceallevel=3'<CR><CR>",
	{ desc = "Toggle Conceal", silent = true })

-- Move chunk of text up and down
keymap("n", "<M-j>", ":move +1<CR>", { desc = "Move text down", silent = true })
keymap("n", "<M-k>", ":move -2<CR>", { desc = "Move text up", silent = true })
keymap("x", "<M-j>", ":move '>+1<CR>gv-gv", { desc = "Move text down", silent = true })
keymap("x", "<M-k>", ":move '<-2<CR>gv-gv", { desc = "Move text up", silent = true })

-- Move between quickfix items
keymap("n", "]q", "<CMD>cnext<CR>", { desc = "Next quickfix", silent = true })
keymap("n", "[q", "<CMD>cprev<CR>", { desc = "Prev quickfix", silent = true })

-- Open current file in default program set by xdg based on filetype
keymap("n", "<leader>o", "<CMD>!xdg-open '%'<CR>", { desc = "Open", silent = true })

-- Use ESC to exit insert mode in terminal windows
keymap("t", "<ESC>", "<C-\\><C-n>", { silent = true })

-- Use ESC to remove search higlight
keymap("n", "<ESC>", "<CMD>nohlsearch<CR>", { silent = true })
