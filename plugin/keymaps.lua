local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>', {desc = "<Esc> to clear search highlights"})
map('t', '<Esc>', '<C-\\><C-N>', {desc = "<Esc> to exit terminal mode"})

map('x', '<S-j>', ':m \'>+1<CR>gv=gv', { noremap = true, silent = true, desc = 'Move block selection down' })
map('x', '<S-k>', ':m \'<-2<CR>gv=gv', { noremap = true, silent = true, desc = 'Move block selection up' })
map('x', '<S-h>', '<gv', { noremap = true, silent = true, desc = 'Move block selection left' })
map('x', '<S-l>', '>gv', { noremap = true, silent = true, desc = 'Move block selection right' })

map('n', '<C-d>', '<C-d>zz', {silent = true, desc = 'Scroll down, centered'})
map('n', '<C-u>', '<C-u>zz', {silent = true, desc = 'Scroll up, centered'})
map('n', 'n', 'nzzzv', {silent = true,  desc = 'Next search result, centered' })
map('n', 'N', 'Nzzzv', {silent = true,  desc = 'Prev search result, centered' })
map('n', '<C-o>', '<C-o>zz', {silent = true, desc = 'Jump back, centered'})
map('n', '<C-i>', '<C-i>zz', {silent = true, desc = 'Jump forward, centered'})

map('n', '<leader>e', '<cmd>:Explore<CR>', {desc = "Open file explorer (Netrw)"})
map("n", "<leader>h", "<cmd>vsplit term://htop<CR>" ,{ desc = "Open htop in right term"})

map({'x', 'n'}, '<leader>d', "\"_d", { noremap = true, silent = true, desc = 'Delete to blackhole' })
map({'x', 'n'}, '<leader>p', [["_dP]], { noremap = true, silent = true, desc = 'Delete to blackhole and Paste' })
map('x', '<leader>y', [["+y]], { noremap = true, silent = true, desc = 'Yank to system clipboard' })
map('x', "<leader>r", [["hy:%s/<C-r>h//g<left><left>]], { desc = "Replace selection globally" })
