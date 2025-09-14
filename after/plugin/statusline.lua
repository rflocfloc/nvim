-------------------------
-- [[ Highlights setup ]]
-------------------------
--
local function setup_highlights()
    -- Get highlight groups from the current theme
    local mode_normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    local mode_visual = vim.api.nvim_get_hl(0, { name = 'Visual' })
    local mode_term = vim.api.nvim_get_hl(0, { name = 'Terminal' })
    local mode_insert = vim.api.nvim_get_hl(0, { name = 'Insert' })
    local mode_replace = vim.api.nvim_get_hl(0, { name = 'Replace' })
    local diagnostic_error = vim.api.nvim_get_hl(0, { name = 'DiagnosticError' })
    local diagnostic_warn = vim.api.nvim_get_hl(0, { name = 'DiagnosticWarn' })
    local diagnostic_info = vim.api.nvim_get_hl(0, { name = 'DiagnosticInfo' })
    local diagnostic_hint = vim.api.nvim_get_hl(0, { name = 'DiagnosticHint' })

    -- Set colors for hightlight (Focus Window)
    vim.api.nvim_set_hl(0, 'StModeNormal', { fg = mode_normal.fg or '#cdcdcd', bg = 'NONE', bold = true })
    vim.api.nvim_set_hl(0, 'StModeVisual', { fg = mode_visual.fg or '#bb9dbd', bg = 'NONE', bold = true })
    vim.api.nvim_set_hl(0, 'StModeInsert', { fg = mode_insert.fg or '#7fa563', bg = 'NONE', bold = true })
    vim.api.nvim_set_hl(0, 'StModeTerm', { fg = mode_term.fg or '#f3be7c', bg = 'NONE', bold = true })
    vim.api.nvim_set_hl(0, 'StModeReplace', { fg = mode_replace.fg or '#d8647e', bg = 'NONE', bold = true })
    vim.api.nvim_set_hl(0, 'StError', { fg = diagnostic_error.fg or '#d8647e', bg = 'NONE', bold = true })
    vim.api.nvim_set_hl(0, 'StWarn', { fg = diagnostic_warn.fg or '#ffb86c', bg = 'NONE', bold = true })
    vim.api.nvim_set_hl(0, 'StInfo', { fg = diagnostic_info.fg or '#8be9fd', bg = 'NONE', bold = true })
    vim.api.nvim_set_hl(0, 'StHint', { fg = diagnostic_hint.fg or '#bd93f9', bg = 'NONE', bold = true })
end


-------------------------
-- [[ Status functions ]]
-------------------------
--
function StatuslineGetMode()
    local mode = vim.fn.mode()

    local mode_map = {
        n = { name = 'N', hl = 'StModeNormal' },
        i = { name = 'I', hl = 'StModeInsert' },
        v = { name = 'V', hl = 'StModeVisual' },
        V = { name = 'V', hl = 'StModeVisual' },
        ['\22'] = { name = 'V', hl = 'StModeVisual' },
        R = { name = 'R', hl = 'StModeReplace' },
        t = { name = 'T', hl = 'StModeTerminal' },
    }

    local mode_info = mode_map[mode] or { name = 'N', hl = 'StModeNormal' }

    return string.format('%%#%s#[%s]%%*', mode_info.hl, mode_info.name)
end

function StatuslineGetArglist()
    local function safe_call(func, ...)
        local ok, result = pcall(func, ...)
        return ok and result or nil
    end

    local arglist_size = safe_call(vim.fn.argc)

    if not arglist_size or type(arglist_size) ~= 'number' or arglist_size <= 0 then
        return ''
    end

    local current_idx = safe_call(vim.fn.argidx)
    if not current_idx or type(current_idx) ~= 'number' then
        return ''
    end

    -- Validate range
    if current_idx < 0 or current_idx >= arglist_size then
        return ''
    end

    local current_arg = current_idx + 1

    -- Final sanity check
    if current_arg < 1 or current_arg > arglist_size or current_arg > 9999 then
        return ''
    end

    local ok, result = pcall(string.format, '%%#StFilename# [ %d/%d]%%*', current_arg, arglist_size)
    return ok and result or ''
end

function StatuslineGetFilename()
    local filename = vim.fn.expand('%:t')
    local filepath = vim.fn.expand('%:~:.:h')

    if filename == '' then
        return '%#StFilename# 󰈔 [No Name] %*'
    end

    local result = '%#StFilename# 󰈔 '

    -- Add directory path only if NOT the pwd or ''
    if filepath ~= '.' and filepath ~= '' then
        result = result .. filepath .. '/'
    end

    result = result .. filename .. ' %*'

    -- Add flags
    if vim.bo.readonly then
        result = result .. '%#StReadonly#   %*'
    elseif vim.bo.modified then
        result = result .. '%#StModified#[+] %*'
    else
        result = result .. '%#StModified#    %*'
    end

    return result
end

function StatuslineGetLspStatus()
    -- Check if LSP is available at all
    if not vim.lsp then
        return ''
    end

    -- Check if get_clients function exists (newer API)
    local clients = {}
    local get_clients_ok = false

    if vim.lsp.get_clients then
        get_clients_ok, clients = pcall(vim.lsp.get_clients, { bufnr = 0 })
    elseif vim.lsp.buf_get_clients then
        -- Fallback for older Neovim versions
        get_clients_ok, clients = pcall(vim.lsp.buf_get_clients, 0)
    end

    if not get_clients_ok or not clients or #clients == 0 then
        return ''
    end

    local names = {}
    for _, client in pairs(clients) do
        if client.name then
            table.insert(names, client.name)
        end
    end

    if #names == 0 then
        return ''
    end

    return '%#StLsp# LSP:' .. table.concat(names, ',') .. ' %*'
end

function StatuslineGetDiagnostics()
    if not vim.diagnostic or not vim.diagnostic.get then
        return ''
    end

    local ok, diagnostics = pcall(vim.diagnostic.get, 0)
    if not ok or not diagnostics then
        return ''
    end

    local counts = { errors = 0, warnings = 0, info = 0, hints = 0 }
    local severity = vim.diagnostic.severity

    if not severity then
        return ''
    end

    for _, diagnostic in pairs(diagnostics) do
        if diagnostic.severity == severity.ERROR then
            counts.errors = counts.errors + 1
        elseif diagnostic.severity == severity.WARN then
            counts.warnings = counts.warnings + 1
        elseif diagnostic.severity == severity.INFO then
            counts.info = counts.info + 1
        elseif diagnostic.severity == severity.HINT then
            counts.hints = counts.hints + 1
        end
    end

    local result = ''
    local icons = {
        error = '✗',
        warn = '⚠',
        info = 'ⓘ',
        hint = ''
    }

    if counts.errors > 0 then
        result = result .. '%#StError#' .. icons.error .. counts.errors .. ' %*'
    end

    if counts.warnings > 0 then
        result = result .. '%#StWarn#' .. icons.warn .. counts.warnings .. ' %*'
    end

    if counts.info > 0 then
        result = result .. '%#StInfo#' .. icons.info .. counts.info .. ' %*'
    end

    if counts.hints > 0 then
        result = result .. '%#StHint#' .. icons.hint .. counts.hints .. ' %*'
    end

    return result ~= '' and ' ' .. result .. '' or ''
end

function StatuslineGetFiletype()
    local ft = vim.bo.filetype
    if ft == '' then return '' end

    -- Simple icon mapping
    local icons = {
        lua = '󰢱',
        vim = '',
        python = '󰌠',
        r = '',
        javascript = '',
        typescript = '',
        html = '',
        css = '',
        json = '',
        yaml = '',
        markdown = '󰍔',
        sh = '',
        zsh = '',
        fish = '',
        rust = '',
        go = '',
        c = '',
        cpp = '',
    }

    local icon = icons[ft] or ''
    return '%#StFiletype#  ' .. icon .. ' ' .. ft .. ' %*'
end

function StatuslineGetSearchCount()
    if vim.v.hlsearch == 0 then return '' end

    local ok, search = pcall(vim.fn.searchcount, { maxcount = 999 })
    if not ok or search.total == 0 then return '' end

    if search.incomplete == 1 then
        return ' [ ?/?] '
    end

    return string.format(' [ %d/%d] ', search.current, search.total)
end

------------------------
-- [[ Build Statusline ]]
------------------------
--
function StatuslineBuild()
    local parts = {
        '%{%v:lua.StatuslineGetMode()%}',
        '%{%v:lua.StatuslineGetArglist()%}',
        '%{%v:lua.StatuslineGetFilename()%}',
        '%<', -- Truncate here if needed
        '%=', -- Switch to right side
        '%{%v:lua.StatuslineGetSearchCount()%}',
        '%{%v:lua.StatuslineGetDiagnostics()%}',
        '%{%v:lua.StatuslineGetLspStatus()%}',
        '%{%v:lua.StatuslineGetFiletype()%}',
        '%#StPosition# %3l:%-2c %*',
        '%#StPercent# %3p%% %*',
    }

    return table.concat(parts, '')
end

-- Call highlights setup
setup_highlights()

local function augroup(name)
    return vim.api.nvim_create_augroup('User_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    group = augroup("StColorsRefresh"),
    desc = 'Refresh statusline highlights',
    callback = setup_highlights,
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'DirChanged' }, {
    pattern = '*',
    desc = 'Refresh statusbar on various events',
    group = augroup('RefreshStatusline'),
    callback = function()
        vim.cmd('redrawstatus')
    end,
})

-- Set up the statusline
vim.opt.statusline = '%!v:lua.StatuslineBuild()'
vim.opt.cmdheight = 0
vim.opt.laststatus = 2 -- statusline always on
