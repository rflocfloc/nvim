if vim.fn.executable('rg') == 1 then
  vim.opt.grepprg = 'rg --vimgrep --hidden --no-heading '
  vim.opt.grepformat = '%f:%l:%c:%m'
end

