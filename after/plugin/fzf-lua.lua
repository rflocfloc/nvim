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
vim.keymap.set('n', '<leader>ss', fzf.files, { desc = 'FzfLua: home menu' })
vim.keymap.set('n', '<leader>sf', fzf.files, { desc = 'FzfLua: Search files' })
vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = 'FzfLua: Live grep' })
vim.keymap.set('n', '<leader>sb', fzf.buffers, { desc = 'FzfLua: Search buffers' })
vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = 'FzfLua: Search help' })
vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = 'FzfLua: Search keymaps' })

