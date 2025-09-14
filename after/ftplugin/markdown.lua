vim.opt_local.wrap = true      -- Enable line wrapping.
vim.opt_local.linebreak = true -- Wrap long lines at a word boundary.
vim.opt_local.textwidth = 160  -- Set text width, common for prose to improve readability.
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

-- Enable spell check for Markdown as it's primarily text.
vim.opt_local.spell = true                -- Turn on spell checking.
vim.opt_local.spelllang = { 'en_us', 'it' } -- Set default spell language to US English.
