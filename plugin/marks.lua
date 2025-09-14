-- Thanks https://github.com/habamax/.vim/blob/master/plugin/marks.vim

-- Define signs for lowercase marks (a-z)
for i = 97, 122 do  -- ASCII codes for a-z
  local char = string.char(i)
  vim.fn.sign_define('mark_' .. char, {
    text = "'" .. char,
    culhl = "CursorLineNr",
    texthl = "Identifier"
  })

  -- Create keymap that sets mark and updates display
  vim.keymap.set('n', 'm' .. char, 'm' .. char .. '<cmd>lua UpdateMarks()<CR>',
    { silent = true})
end

-- Define signs for uppercase marks (A-Z)
for i = 65, 90 do  -- ASCII codes for A-Z
  local char = string.char(i)
  vim.fn.sign_define('mark_' .. char, {
    text = "'" .. char,
    culhl = "CursorLineNr",
    texthl = "Identifier"
  })

  -- Create keymap that sets mark and updates all visible buffers
  vim.keymap.set('n', 'm' .. char, 'm' .. char .. '<cmd>lua UpdateVisibleBuffersMarks()<CR>',
    { silent = true })
end

-- Update marks for a specific buffer
function UpdateMarks(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  -- Clear existing mark signs
  vim.fn.sign_unplace('marks', { buffer = bufnr })

  -- Get local marks for this buffer
  local local_marks = vim.fn.getmarklist(bufnr)
  local marks_to_show = {}

  -- Filter for alphabetic marks
  for _, mark in ipairs(local_marks) do
    if mark.mark:match('[a-zA-Z]') then
      table.insert(marks_to_show, mark)
    end
  end

  -- Get global marks that point to this buffer
  local global_marks = vim.fn.getmarklist()
  for _, mark in ipairs(global_marks) do
    if mark.mark:match('[a-zA-Z]') and mark.pos[1] == bufnr then
      table.insert(marks_to_show, mark)
    end
  end

  -- Place signs for all marks
  for _, mark in ipairs(marks_to_show) do
    vim.fn.sign_place(0, 'marks', 'mark_' .. mark.mark:sub(2), mark.pos[1], {
      lnum = mark.pos[2]
    })
  end
end

-- Update marks for all visible buffers
function UpdateVisibleBuffersMarks()
  local visible_buffers = vim.fn.getbufinfo({ buflisted = 1, bufloaded = 1 })

  for _, buf_info in ipairs(visible_buffers) do
    -- Only update if buffer has visible windows
    if #buf_info.windows > 0 then
      UpdateMarks(buf_info.bufnr)
    end
  end
end

-- Set up autocommands
local function augroup(name)
  return vim.api.nvim_create_augroup("User_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChanged' }, {
  desc = 'Update specific buffer marks visuals',
  group = augroup('UpdateMarksEntering'),
  callback = function()
    UpdateMarks()
  end
})

vim.api.nvim_create_autocmd('CmdlineLeave', {
  desc = 'Wait when leaving buffer before update marks visuals',
  group = augroup('UpdateMarksLeaving'),
  pattern = ':',
  callback = function()
    -- Use timer to defer execution, used because marks load might run to early
    vim.defer_fn(function()
      UpdateVisibleBuffersMarks()
    end, 0)
  end
})
