local fn = vim.fn
local api = vim.api

local M = {}

---Returns a boolean, filereadable().
---@param filepath string
---@return boolean
function M.exists(filepath)
    return fn.filereadable(filepath) == 1
end

---Insert 'text' from 'start' to 'last' line.
---@param text string
---@param start integer
---@param last? integer #Default: Same as 'start'
function M.insert_text(text, start, last)
    last = last or start
    local lines = vim.split(text, "\n")
    api.nvim_buf_set_lines(0, start, last, false, lines)
end

---Accepts (1,1) indexed cursor position.
---@param row integer
---@param col integer
function M.set_cursor(row, col)
    api.nvim_win_set_cursor(0, { row, col - 1 })
end

---@param key string
function M.feedkey(key)
    api.nvim_feedkeys(api.nvim_replace_termcodes(key, true, false, true), "n", false)
end

return M
