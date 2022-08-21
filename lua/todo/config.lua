local utils = require("todo.utils")

local M = {}

-- Default config
M.config = {
    mappings = {
        ["<leader>n"] = "new_task",
        ["<leader>j"] = "next",
        ["<leader>k"] = "prev",
        ["<leader>c"] = "complete",
        ["<leader>u"] = "uncomplete",
        ["<leader>t"] = "toggle",
    },
    disable_default_mappings = false,
    options = {},
    filename = "TODO.md",
    filepath = function(is_default)
        local git_root = utils.git_root()
        if not is_default and git_root then
            return git_root .. "/{{filename}}"
        else
            ---@diagnostic disable-next-line
            return "~/{{filename}}"
        end
    end,
    templete = [[# TODO

## Have Deadline

## Deadline undecided

## No Deadline
]],
    new_task = "- [ ] \\%#",
}

---@param opt table
function M.setup(opt)
    if opt.disable_default_mappings then
        M.config.mappings = {}
    end
    vim.tbl_deep_extend("force", M.config, opt)

    if not (M.config.new_task:find("%[ %]") or M.config.new_task:find("%[x%]")) then
        -- 'new_task' must include '[ ]' or '[x]'
        error("Invalid format of new_task: " .. M.config.new_task)
    end
end

function M.set_option()
    for k, v in pairs(M.config.options) do
        vim.opt_local[k] = v
    end
end

---@param name string
---@return any
function M.get_config(name)
    return M.config[name]
end

return M
