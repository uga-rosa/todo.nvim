local fn = vim.fn
local api = vim.api

local config = require("todo.config")
local utils = require("todo.utils")

local CURSOR_PATTERN = "\\%%#"

local M = {}

function M.setup()
    M.setup_command()
end

function M.setup_command()
    api.nvim_create_user_command("TodoOpen", function()
        M.open()
    end, {})
end

function M.open()
    ---@type string
    local filepath = config.get_config("filepath") or ""
    vim.cmd("e " .. filepath)
    if not utils.exists(filepath) then
        local templete = config.get_config("templete") or ""
        if #templete > 0 then
            utils.insert_text(templete, 0, 1)
        end
        vim.cmd("w")
    end

    M.setup_mapping()
    config.set_option()
end

function M.setup_mapping()
    local mappings = config.get_config("mappings") or {}
    for k, v in pairs(mappings) do
        if type(v) == "string" then
            v = M[v]
        end
        vim.keymap.set("n", k, v, { buffer = true })
    end
end

function M.new_task()
    local current_row = fn.line(".")
    ---@type string
    local insert_text = config.get_config("new_task") or ""
    local cursor = { insert_text:find(CURSOR_PATTERN) }
    if #cursor == 2 then
        -- Includes cursor regex.
        -- cursor: integer[] = { start, last }
        insert_text = insert_text:gsub(CURSOR_PATTERN, "")
        utils.insert_text(insert_text, current_row)
        utils.set_cursor(current_row + 1, cursor[1] - 1)
        utils.feedkey("a")
    else
        utils.insert_text(insert_text, current_row)
    end
end

---@return string
local function get_task_pattern()
    ---@type string
    local new_task = config.get_config("new_task") or ""
    -- Removes cursor pattern (Since it is not actually inserted, it interferes with the search.)
    new_task = new_task:gsub(CURSOR_PATTERN, "")
    return new_task
end

function M.next()
    local new_task = get_task_pattern()
    -- Treat 'new_task' as plain text as much as possible by setting it very no magic.
    fn.search("\\V" .. new_task)
end

function M.prev()
    local new_task = get_task_pattern()
    -- Treat 'new_task' as plain text as much as possible by setting it very no magic.
    fn.search("\\V" .. new_task, "b")
end

function M.complete()
    local current_line = api.nvim_get_current_line()
    current_line = current_line:gsub("%[ %]", "%[x%]")
    local current_row = fn.line(".")
    utils.insert_text(current_line, current_row - 1, current_row)
end

function M.uncomplete()
    local current_line = api.nvim_get_current_line()
    current_line = current_line:gsub("%[x%]", "%[ %]")
    local current_row = fn.line(".")
    utils.insert_text(current_line, current_row - 1, current_row)
end

function M.toggle()
    local current_line = api.nvim_get_current_line()
    if current_line:find("%[x%]") then
        current_line = current_line:gsub("%[x%]", "%[ %]")
    elseif current_line:find("%[ %]") then
        current_line = current_line:gsub("%[ %]", "%[x%]")
    end
    local current_row = fn.line(".")
    utils.insert_text(current_line, current_row - 1, current_row)
end

return M
