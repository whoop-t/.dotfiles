-- NOTE this should only be for general mappings, try to define plugin specific mapping in the lazy setup under "keys"
-- Leader key mapping
vim.g.mapleader = " "
-- Key to clear highlight search
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
-- save and quit mappings
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>confirm q<cr>")
-- blackhole delete
vim.keymap.set({ "n", "v" }, "<leader>p", '"_dP')
-- Center text when moving with C-d and C-u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
