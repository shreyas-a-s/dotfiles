-- Setting the leader key to a space character
vim.g.mapleader = " "

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Set keymap to hide search highlight
vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>")

-- Gitsigns
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})

-- lsp-config
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

-- Neo-tree
vim.keymap.set("n", "<leader>tt", ":Neotree filesystem toggle left<CR>", {})
vim.keymap.set("n", "<leader>fb", ":Neotree buffers reveal float<CR>", {})

-- None-ls
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

-- Telescope
vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", {})
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", {})
vim.keymap.set("n", "<leader>fw", ":Telescope live_grep<CR>", {})
