# todo.nvim

A Plugin for todo management with markdown.

# Setup

```lua
local todo = require("todo")
local action = require("todo.action")

todo.setup({
    mappings = {
        -- Keys are lhs, values are rhs.
        -- If rhs is string, replaced into `action[rhs]`
        ["<leader>n"] = "new_task",
        ["<leader>j"] = "next",
        ["<leader>k"] = "prev",
        ["<leader>t"] = action.toggle,
    },
    -- Disables default mappings.
    disable_default_mappings = true,
    options = {
        -- You can define options to be set in todo.md.
    },
    -- Path of todo.md.
    filepath = vim.fn.expand("~/.todo.md"),
    -- Template used when todo.md is opened for the first time.
    templete = [[# TODO

## Have Deadline

## Deadline undecided

## No Deadline
]],
    -- The format of the line inserted by `action.new_task`.
    -- If it contains '\\%#' (regex of cursor position), the cursor is inserted at that position (automatically enters insert mode).
    new_task = "- [ ] \\%#",
})
```

# Command

- TodoOpen
    - Open todo.md.

# Action

- new_task
    - Add a new task.
    - Inserts `new_task` into the following line.
- next
    - Move to the next task.
- prev
    - Move to the previous task.
- complete
    - Completes the task.
    - Replaces `[ ]` to `[x]`.
- uncomplete
    - Set the task as uncompleted.
    - Replaces `[x]` to `[ ]`.
- toggle
    - Toggle between complete and uncomplete.
    - Toggles between `[x]` and `[ ]`.
