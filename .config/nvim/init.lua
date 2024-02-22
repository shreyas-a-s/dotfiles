-- Make plugin loading faster (only for nvim v0.9.0 or above)
if vim.fn.has("nvim-0.9.0") == 1 then
  vim.loader.enable()
end

-- Initialise lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local opts = {
  change_detection = {
    enabled = false,
  },
}

-- Source modules
require("options")
require("keymaps")
require("lazy").setup("plugins", opts)
