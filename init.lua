
-- Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(require('./plugins'))

-- Colorscheme
require('onedark').setup {
    style = 'deep'
}
require('onedark').load()

-- load our custom colors
require('colors')

-- Basic nvim config (After everything, so it doesn't get overriden)
vim.g.mapleader = "<"
vim.opt.scrolloff = 10
vim.opt.wrap = false
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.swapfile = false

-- See tabstop documentation.
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab = true

-- keymaps (requires mapleader)
require('key')
