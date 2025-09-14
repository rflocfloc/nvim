local opt = vim.opt
local g = vim.g
local o = vim.o

-- Set leader
g.mapleader = " "
g.maplocalleader = " "

-- Basic settings
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.inccommand = 'split'
opt.confirm = true

-- Open windows right/low
opt.splitright = true
opt.splitbelow = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Search settings
opt.smartcase = true

-- Visual settings
opt.termguicolors = true
opt.guicursor = ""
opt.signcolumn = "yes"
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.winborder = "rounded"


-- File handling/history
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.updatetime = 300
opt.timeoutlen = 500

-- Netrw options
g.netrw_banner = 0
-- g.netrw_liststyle = 3
g.netrw_showhidden = 1 -- show dotfiles
g.netrw_winsize = 20

-- Remove checkhealth provider warnings
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
