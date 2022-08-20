local config = require("todo.config")
local action = require("todo.action")

local M = {}

---@param opt? table
function M.setup(opt)
    opt = opt or {}
    config.setup(opt)
    action.setup()
end

return M
