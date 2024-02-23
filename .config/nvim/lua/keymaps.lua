-- Setting the leader key to a space character
vim.g.mapleader = " "

-- Make syntax simpler
local map = vim.keymap.set

-- Disable space in normal mode and visual mode
map({"n", "v"}, "<space>", "", { silent = true })

-- Redo
map("n", "U", "<CMD>redo<CR>", { desc = "Redo" })

-- Mimic shell movements
map("i", "<C-a>", "<ESC>I", { desc = "Go to beginning of line" })
map("i", "<C-e>", "<ESC>A", { desc = "Go to end of line" })

-- Move to window using <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Move to window using the <ctrl> arrow keys
map("n", "<C-Left>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-Down>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-Up>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-Right>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Gitsigns
map("n", "<leader>hp", "<CMD>Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
map("n", "<leader>tb", "<CMD>Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle current line blame" })

-- lsp
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "<leader>gd", "<CMD>Telescope lsp_definitions<CR>", { desc = "Go to definitions" })
map("n", "<leader>gi", "<CMD>Telescope lsp_implementations<CR>", { desc = "Go to implementations" })
map("n", "<leader>gtd", "<CMD>Telescope lsp_type_definitions<CR>", { desc = "Go to type definitions" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>gr", "<CMD>Telescope lsp_references<CR>", { desc = "Go to references" })
map("n", "<leader>cf", function() vim.lsp.buf.format { async = true } end, { desc = "Format code" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

-- File tree
map("n", "<leader><space>", "<CMD>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Navigate buffers using <ctrl> hl keys
map("n", "<S-h>", "<CMD>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<CMD>bnext<CR>", { desc = "Next buffer" })

-- Navigate buffers using <ctrl> arrow keys
map("n", "<S-Left>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-Right>", "<CMD>bnext<CR>", { desc = "Next buffer" })

-- Telescope
map("n", "<leader>fr", "<CMD>Telescope oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<CMD>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<CMD>Telescope buffers<CR>", { desc = "Find buffers" })

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Disable buffer content change when pasting in Visual mode
map("v", "p", "P", { desc = "Paste in visual mode" })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
