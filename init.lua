-- [[ User Settings ]]
vim.g.mapleader = " "		-- Important to set mapleader before requiring lazy.nvim for compatibility
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true	-- Set to true if you have a Nerd Font installed and selected in the terminal

-- [[ Loading config ]]
require "config.options"
require "config.keymaps"
require "config.autocmds"
require "config.floating_terminal"
require "config.lazy"

-- [[ Colorscheme ]]
-- add colorschemes under lua/plugin/colorscheme.lua
vim.o.background = 'dark'
vim.cmd.colorscheme 'candle-grey-transparent'
