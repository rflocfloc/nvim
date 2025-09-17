local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>', {desc = "<Esc> to clear search highlights"})
map('t', '<Esc>', '<C-\\><C-N>', {desc = "<Esc> to exit terminal mode"})

map({'v', 'x'}, '<S-j>', ':m \'>+1<CR>gv=gv', { noremap = true, silent = true, desc = 'Move block selection down' })
map({'v', 'x'}, '<S-k>', ':m \'<-2<CR>gv=gv', { noremap = true, silent = true, desc = 'Move block selection up' })

map('n', '<C-d>', '<C-d>zz', {noremap = true, silent = true, desc = 'Scroll down, centered'})
map('n', '<C-u>', '<C-u>zz', {noremap = true, silent = true, desc = 'Scroll up, centered'})
map('n', 'n', 'nzzzv', {noremap = true, silent = true,  desc = 'Next search result, centered' })
map('n', 'N', 'Nzzzv', {noremap = true, silent = true,  desc = 'Prev search result, centered' })
map('n', '<C-o>', '<C-o>zz', {noremap = true, silent = true, desc = 'Jump back, centered'})
map('n', '<C-i>', '<C-i>zz', {noremap = true, silent = true, desc = 'Jump forward, centered'})

map('n', '<leader>e', '<cmd>:Explore<CR>', {desc = "Open file explorer (Netrw)"})
map("n", "<leader>h", "<cmd>vsplit term://htop<CR>" ,{ desc = "Open htop in right term"})

map({'v', 'n'}, '<leader>d', "\"_d", { noremap = true, silent = true, desc = 'Delete to blackhole' })
map({'v', 'n'}, '<leader>p', [["_dP]], { noremap = true, silent = true, desc = 'Delete to blackhole and Paste' })
map('x', '<leader>y', [["+y]], { noremap = true, silent = true, desc = 'Yank to system clipboard' })

-- ??
-- '\r' desc = 'Replace selection globally' })
