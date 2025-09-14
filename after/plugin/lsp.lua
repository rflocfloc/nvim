-- ----------------
-- [[ Enable LSP ]]
-- ----------------
vim.lsp.enable('bashls')
vim.lsp.enable('pyright')
vim.lsp.enable('lua_ls')
vim.lsp.enable('r_language_server')



-- ----------------------------
-- [[ LSP/Diagnostics Configs]]
-- ----------------------------
vim.diagnostic.config({ float = { border = "rounded" } })



-- ----------------
-- [[ LSP/Diagnostics Keymaps]]
-- ----------------
-- Using default keymaps  check `:h lsp-defaults`
-- Using default keymaps  check `:h diagnostic-defaults`

vim.keymap.set('n', 'grf', vim.lsp.buf.format, { desc = "LSP: Lint document" })

vim.keymap.set('n', 'gk', vim.diagnostic.open_float,
    { noremap = true, desc = "Toggle floating window diagnostics (same as <ctrl-w>d)" })

vim.keymap.set('n', 'gK', function()
    local new_config = not vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = new_config })
end, { desc = 'Toggle diagnostic virtual_text' })
