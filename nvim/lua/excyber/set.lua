-- (Tree Advise) disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--vim.opt.guicursor = "|"

vim.opt.nu = true
vim.opt.relativenumber = true

indent_size = 2
vim.opt.tabstop = indent_size
vim.opt.softtabstop = indent_size
vim.opt.shiftwidth = indent_size
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false
--
-- For Undo tree, undoing things from a mile away
--vim.opt.swapfile = false
--vim.opt.backup = false
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
--vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 12
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"


