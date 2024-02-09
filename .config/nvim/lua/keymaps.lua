-- Setting the leader key to a space character
vim.g.mapleader = " "

-- Make syntax simpler
local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

-- Window manipulation
map("n", "<leader>wv", ":vsplit<CR>")
map("n", "<leader>wh", ":split<CR>")
map("n", "<leader>wc", ":q<CR>")

-- Remap Redo
map("n", "U", ":redo<CR>")

-- Mimic shell movements
map("i", "<C-a>", "<ESC>I")
map("i", "<C-e>", "<ESC>A")

-- Navigate panes using vim motion keys
map("n", "<C-k>", ":wincmd k<CR>")
map("n", "<C-j>", ":wincmd j<CR>")
map("n", "<C-h>", ":wincmd h<CR>")
map("n", "<C-l>", ":wincmd l<CR>")

-- Navigate panes using arrow keys
map("n", "<C-Up>", ":wincmd k<CR>")
map("n", "<C-Down>", ":wincmd j<CR>")
map("n", "<C-Left>", ":wincmd h<CR>")
map("n", "<C-Right>", ":wincmd l<CR>")

-- Gitsigns
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>")

-- lsp-config
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>gd", vim.lsp.buf.definition)
map("n", "<leader>gr", vim.lsp.buf.references)
map("n", "<leader>ca", vim.lsp.buf.code_action)

-- Neo-tree
map("n", "<leader>.", ":Neotree filesystem toggle left<CR>")

-- None-ls
map("n", "<leader>gf", vim.lsp.buf.format)

-- Telescope
map("n", "<leader>fr", ":Telescope oldfiles<CR>")
map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>fg", ":Telescope live_grep<CR>")
map("n", "<leader>fb", ":Telescope buffers<CR>")
