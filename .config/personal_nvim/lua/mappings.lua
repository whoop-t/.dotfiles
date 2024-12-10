-- NOTE this should only be for general mappings, try to define plugin specific mapping in the lazy setup under "keys"
-- Leader key mapping
vim.g.mapleader = " "
-- better j and k
vim.keymap.set({"n", "x"}, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Move cursor down" })
vim.keymap.set({"n", "x"}, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move cursor up" })
-- Key to clear highlight search
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
-- save and quit mappings
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save"})
vim.keymap.set("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit"})
-- blackhole delete
vim.keymap.set({ "n", "v" }, "<leader>p", '"_dP')
-- Center text when moving with C-d and C-u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- tmux sessionizer in nvim
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer.sh<CR>")
-- hover open issues in file
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float)
-- snippet jumping
vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if require("luasnip").expand_or_jumpable() then
    require("luasnip").expand_or_jump()
  end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-h>", function()
  if require("luasnip").jumpable(-1) then
    require("luasnip").jump(-1)
  end
end, { silent = true })
