# todo.nvim

A Plugin for todo management with markdown.

# Requires

- plenary.nvim (plenary.job)

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
    filename = "TODO.md",
    -- A function with the boolean value 'is_default' as an argument, or a string.
    -- By default, filepath is returned for each git repository.
    -- Outside the git repository or when is_default is true (:TodoOpen!), `~/TODO.md` is returned.
    -- In addition, the press holder `{{filename}}` is replaced by above `filename`.
    filepath = "~/{{filename}}",
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
    - Open TODO.md.
    - If in the git repository, open `{git root}/TODO.md`.
    - Otherwise, open the default todo file: `~/TODO.md`.
    - If you add bang (`:TodoOpen!`), you can open the default one even if in the git repository.

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
