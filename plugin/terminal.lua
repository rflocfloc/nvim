-- Thanks https://github.com/tjdevries/config.nvim/blob/master/plugin/terminal.lua

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("User_TermOptions", {}),
    callback = function()
        if vim.opt.buftype:get() == "terminal" then
            vim.cmd(":startinsert")
        end
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
        vim.opt_local.scrolloff = 0

        vim.bo.filetype = "terminal"
    end,
})

-- Keymaps
vim.keymap.set("n", "<leader>t", function()
    vim.cmd.new()
    vim.cmd.wincmd "J"
    vim.api.nvim_win_set_height(0, 12)
    vim.wo.winfixheight = true
    vim.cmd.term()
end, { desc = "Open terminal below"})
