-- Setting the leader key to a space character
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Make syntax simpler
local function map(mode, key, cmd, desc)
  vim.keymap.set(mode, key, cmd, { desc = desc, silent = true })
end

-- Window manipulation
map("n", "<leader>wv", ":vsplit<CR>", "[v]ertical split")
map("n", "<leader>wh", ":split<CR>", "[h]orizontal split")
map("n", "<leader>wc", ":q<CR>", "[c]lose window")

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
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", "[p]review hunk")
map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", "[t]oggle line blame")

-- lsp-config
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>cd", vim.lsp.buf.definition, "[d]efinition")
map("n", "<leader>cr", vim.lsp.buf.references, "[r]eferences")
map("n", "<leader>ca", vim.lsp.buf.code_action, "[a]ctions")

-- Neo-tree
map("n", "<leader><leader>", ":Neotree filesystem toggle left<CR>", "toggle neo-tree")

-- None-ls
map("n", "<leader>bf", vim.lsp.buf.format, "[f]ormat buffer")

-- Navigate buffers
map("n", "<leader>bn", ":bn<CR>", "[n]ext buffer")
map("n", "<leader>bp", ":bp<CR>", "[p]revious buffer")

-- Telescope
map("n", "<leader>fr", ":Telescope oldfiles<CR>", "[r]ecent files")
map("n", "<leader>ff", ":Telescope find_files<CR>", "[f]ind files")
map("n", "<leader>fg", ":Telescope live_grep<CR>", "[g]rep files")
map("n", "<leader>fb", ":Telescope buffers<CR>", "[b]uffers")
