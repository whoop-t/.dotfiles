-- Basic Neovim configuration
-- use with NVIM_APPNAME=basic_nvim nvim .

-- Set leader key (optional, for future customization)
vim.g.mapleader = " "

-- Basic settings
vim.opt.number = true        -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.expandtab = true     -- Use spaces instead of tabs
vim.opt.shiftwidth = 4       -- Shift by 4 spaces
vim.opt.tabstop = 4          -- Tab width is 4 spaces
vim.opt.cursorline = true    -- Highlight the current line

-- Change the cursor line color
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#c07af7" }) -- Light blue background for the cursor line

-- Keybinding: Map Ctrl + , to print a message
-- vim.keymap.set('n', '<C-,>', function()
--     print("Ctrl + , was pressed!")
-- end, { noremap = true, silent = true })

vim.keymap.set('n', '<C-,>', '<C-u>zz', { noremap = true, silent = true })
