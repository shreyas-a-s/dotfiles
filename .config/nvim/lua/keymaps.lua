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
map("n", "<leader>wc", ":q<CR>", "[c]lose")

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
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'cD', vim.lsp.buf.declaration, opts, { desc = "[D]eclaration", silent = true })
    vim.keymap.set('n', 'cd', vim.lsp.buf.definition, opts, { desc = "[D]efinition", silent = true })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts, { desc = "[a]ction", silent = true })
    vim.keymap.set('n', 'cr', vim.lsp.buf.references, opts, { desc = "[r]eferences", silent = true })
    vim.keymap.set('n', 'cf', function()
      vim.lsp.buf.format { async = true }
    end, opts, { desc = "[f]ormat", silent = true })
  end,
})

-- Nvim-tree
map("n", "<leader><leader>", ":NvimTreeToggle<CR>", "Toggle nvim-tree")

-- Navigate buffers
map("n", "<leader>bn", ":bn<CR>", "[n]ext buffer")
map("n", "<leader>bp", ":bp<CR>", "[p]revious buffer")

-- Telescope
map("n", "<leader>fr", ":Telescope oldfiles<CR>", "[r]ecent files")
map("n", "<leader>ff", ":Telescope find_files<CR>", "[f]ind files")
map("n", "<leader>fg", ":Telescope live_grep<CR>", "[g]rep files")
map("n", "<leader>bs", ":Telescope buffers<CR>", "[s]how buffers")
