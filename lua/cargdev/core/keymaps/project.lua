--- Project run and debug keymaps.
--- Provides `<leader>p` prefixed shortcuts that invoke the `:RunProject`
--- and `:DebugProject` user commands defined in `project_commands.lua`.
--- @module keymaps.project

local keymap = vim.keymap

--- Execute the project run command from `.nvim/project.lua`.
keymap.set("n", "<leader>pr", ":RunProject<CR>", { desc = "Run Project" })

--- Execute the project debug command from `.nvim/project.lua`.
keymap.set("n", "<leader>pd", ":DebugProject<CR>", { desc = "Debug Project" })
