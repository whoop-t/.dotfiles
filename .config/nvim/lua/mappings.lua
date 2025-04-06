-- NOTE: this should only be for general mappings, try to define plugin specific mapping in the lazy setup under "keys"
-- NOTE: A LOT of mappings are in snacks.nvim
-- Leader key mapping
vim.g.mapleader = " "
-- better j
vim.keymap.set(
  { "n", "x" },
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true, desc = "Move cursor down" }
)
-- better k
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move cursor up" })
-- Key to clear highlight search
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
-- save and quit mappings
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save All" })
vim.keymap.set("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit" })
-- blackhole delete
vim.keymap.set({ "n", "v" }, "<leader>p", '"_dP')
-- Center text when moving with C-d and C-u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- tmux sessionizer in nvim
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.config/bin/tmux-sessionizer.sh<CR>")
-- copy current file name
vim.keymap.set(
  "n",
  "<leader>cf",
  '<cmd>let @+ = fnamemodify(expand("%:p"), ":.")<cr>',
  { desc = "Copy current file path" }
)
-- jq a whole buffer
vim.keymap.set("n", "<leader>jq", "<cmd>%!jq .<CR>")
-- Show diagnostics with lsp that outputted it
-- This opens a float with diag info
vim.keymap.set("n", "<leader>ld", function()
  vim.diagnostic.open_float(nil, {
    border = "rounded",
    -- Customize how each diagnostic is formatted
    format = function(diagnostic)
      if diagnostic.source then
        return string.format("[%s] %s", diagnostic.source, diagnostic.message)
      else
        return diagnostic.message
      end
    end,
    prefix = "", -- Remove prefix aka numbered list
    header = "", -- Remove the title
  })
end, { desc = "Show diagnostics with source" })

-- Press to trigger know snippets after typing them in in insert mode
vim.keymap.set({ "i", "s" }, "<C-s>", function()
  local ls = require("luasnip")
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- quickfix open and close
vim.keymap.set("n", "<leader>fo", "<cmd>copen<CR>")
vim.keymap.set("n", "<leader>fc", "<cmd>cclose<CR>")
