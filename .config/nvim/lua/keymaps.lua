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

-- Gitsigns navigation
map({ 'n', 'v' }, ']c', "<CMD>Gitsigns next_hunk()<CR>", { expr = true, desc = 'Git: Jump to next hunk' })
map({ 'n', 'v' }, '[c', "<CMD>Gitsigns prev_hunk()<CR>", { expr = true, desc = 'Git: Jump to previous hunk' })

-- Gitsigns actions (visual mode)
map('v', '<leader>hs', "<CMD>Gitsigns stage_hunk { vim.fn.line '.', vim.fn.line 'v' }<CR>", { desc = 'Git: Stage hunk' })
map('v', '<leader>hr', "<CMD>Gitsigns reset_hunk { vim.fn.line '.', vim.fn.line 'v' }<CR>", { desc = 'Git: Reset hunk' })

-- Gitsigns actions (normal mode)
map('n', '<leader>hs', "<CMD>Gitsigns stage_hunk<CR>", { desc = 'Git: Stage hunk' })
map('n', '<leader>hr', "<CMD>Gitsigns reset_hunk<CR>", { desc = 'Git: Reset hunk' })
map('n', '<leader>hS', "<CMD>Gitsigns stage_buffer<CR>", { desc = 'Git: Stage buffer' })
map('n', '<leader>hu', "<CMD>Gitsigns undo_stage_hunk<CR>", { desc = 'Git: Undo stage hunk' })
map('n', '<leader>hR', "<CMD>Gitsigns reset_buffer<CR>", { desc = 'Git: Reset buffer' })
map('n', '<leader>hp', "<CMD>Gitsigns preview_hunk<CR>", { desc = 'Git: Preview hunk' })
map('n', '<leader>hb', "<CMD>Gitsigns blame_line { full = false }<CR>", { desc = 'Git: Blame line' })
map('n', '<leader>hd', "<CMD>Gitsigns diffthis<CR>", { desc = 'Git: Diff against index' })
map('n', '<leader>hD', "<CMD>Gitsigns diffthis '~'<CR>", { desc = 'Git: Diff against last commit' })

-- Gitsigns toggles
map('n', '<leader>tb', "<CMD>Gitsigns toggle_current_line_blame<CR>", { desc = 'Git: Toggle blame line' })
map('n', '<leader>td', "<CMD>Gitsigns toggle_deleted<CR>", { desc = 'Git: Toggle show deleted' })

-- Lsp
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
end, { desc = "Code actions" })

-- Lsp Goto
map("n", "gd", "<CMD>Telescope lsp_definitions<CR>", { desc = "Goto definition" })
map("n", "gr", "<CMD>Telescope lsp_references<CR>", { desc = "Goto references" })
map("n", "gI", "<CMD>Telescope lsp_implementations<CR>", { desc = "Goto implementation" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
map("n", "<leader>D", "<CMD>Telescope lsp_type_definitions<CR>", { desc = "Type definition" })

-- Lsp symbols
map("n", "<leader>ds", "<CMD>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
map("n", "<leader>ws", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "Workspace symbols" })

-- Hover documentation
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature documentation" })

-- Lesser used LSP functionality
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Workspace add folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Workspace remove folder" })
map("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "Workspace list folders" })

-- Format current buffer with LSP
map({"n", "v"}, "<leader>cf", function()
  vim.lsp.buf.format()
end, { desc = "Format current buffer" })

-- Open diagnostic menu in float
map("n", "gl", "<CMD>lua vim.diagnostic.open_float()<CR>", { desc = "Diagnostics open float" })

-- File tree
map("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", { desc = "Explorer" })

-- Navigate buffers using <ctrl> hl keys
map("n", "<S-h>", "<CMD>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<CMD>bnext<CR>", { desc = "Next buffer" })

-- Navigate buffers using <ctrl> arrow keys
map("n", "<S-Left>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-Right>", "<CMD>bnext<CR>", { desc = "Next buffer" })

-- Telescope
map("n", "<leader>fr", "<CMD>Telescope oldfiles<CR>", { desc = "Find recent files" })
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>ft", "<CMD>Telescope live_grep<CR>", { desc = "Find text" })
map("n", "<leader>bb", "<CMD>Telescope buffers<CR>", { desc = "Find buffers" })

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Disable buffer content change when pasting in Visual mode
map("v", "p", "P", { desc = "Paste in visual mode" })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
