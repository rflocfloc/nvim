local actions = require'fzf-lua.actions'
require 'fzf-lua'.setup({
    'telescope',
    defaults = {
        file_icons   = "mini"
    },
    actions = {
        files = {
            ["default"]       = actions.file_edit,
            ["ctrl-s"]        = actions.file_split,
            ["ctrl-v"]        = actions.file_vsplit,
            ["ctrl-t"]        = actions.file_tabedit,
            ["alt-q"]         = actions.file_sel_to_qf,
        },
    },
})

-- -- keymaps
local fzf = require('fzf-lua')
vim.keymap.set('n', '<leader>sf', fzf.files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>sb', fzf.buffers, { desc = 'Search buffers' })
vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = 'Search help' })
vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = 'Search keymaps' })

