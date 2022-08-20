if vim.g.loaded_todo then
    return
end
vim.g.loaded_todo = true

require("todo").setup()
