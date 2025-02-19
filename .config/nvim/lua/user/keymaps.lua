local keymap = vim.keymap.set

-- Toggle line wrap
keymap("n", "<leader>tw", "<CMD>lua vim.wo.wrap = not vim.wo.wrap<CR>", { desc = "Toggle Wrap" })

-- Toggle conceal level
keymap(
	"n",
	"<leader>tc",
	":setlocal <C-R>=&conceallevel ? 'conceallevel=0' : 'conceallevel=3'<CR><CR>",
	{ desc = "Toggle Conceal", silent = true }
)

-- Move chunk of text up and down
keymap("n", "<M-j>", ":move +1<CR>", { desc = "Move text down", silent = true })
keymap("n", "<M-k>", ":move -2<CR>", { desc = "Move text up", silent = true })
keymap("x", "<M-j>", ":move '>+1<CR>gv-gv", { desc = "Move text down", silent = true })
keymap("x", "<M-k>", ":move '<-2<CR>gv-gv", { desc = "Move text up", silent = true })

-- Move between quickfix items
keymap("n", "]q", vim.cmd.cnext, { desc = "Next quickfix", silent = true })
keymap("n", "[q", vim.cmd.cprev, { desc = "Prev quickfix", silent = true })
keymap("n", "]Q", vim.cmd.clast, { desc = "Last quickfix", silent = true })
keymap("n", "[Q", vim.cmd.cfirst, { desc = "First quickfix", silent = true })

-- Open current file in default program set by xdg based on filetype
keymap("n", "<leader>o", "<CMD>!xdg-open '%'<CR>", { desc = "Open", silent = true })

-- Use ESC to exit insert mode in terminal windows
keymap("t", "<ESC>", "<C-\\><C-n>", { silent = true })

-- Use ESC to remove search higlight
keymap("n", "<ESC>", vim.cmd.nohlsearch, { silent = true })

-- Center view when moving between search results
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
