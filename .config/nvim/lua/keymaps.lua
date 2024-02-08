-- Setting the leader key to a space character
vim.g.mapleader = " "

-- Window manipulation
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>")
vim.keymap.set("n", "<leader>wh", ":split<CR>")
vim.keymap.set("n", "<leader>wc", ":q<CR>")

-- Mimic shell movements
vim.keymap.set("i", "<C-a>", "<ESC>I")
vim.keymap.set("i", "<C-e>", "<ESC>A")

-- Navigate panes using vim motion keys
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")

-- Navigate panes using arrow keys
vim.keymap.set("n", "<C-Up>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-Down>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-Left>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-Right>", ":wincmd l<CR>")

-- Gitsigns
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})

-- lsp-config
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

-- Neo-tree
vim.keymap.set("n", "<leader>.", ":Neotree filesystem toggle left<CR>", {})

-- None-ls
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

-- Telescope
vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", {})
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", {})
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", {})
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", {})
