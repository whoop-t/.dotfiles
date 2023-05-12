-- This is a minimal config just for kitty scrollback pager
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.virtualedit = "all"
vim.opt.scrollback = 100000
vim.opt.termguicolors = true
vim.opt.laststatus = 0
vim.opt.background = "dark"
vim.opt.ignorecase = true
vim.opt.scrolloff = 8

vim.cmd("hi Visual guibg=#283457")
vim.cmd("hi Cursor guifg=#1a1b26 guibg=#c0caf5")
vim.cmd("hi LineNr guifg=#3b4261")
vim.cmd("hi Search guifg=#c0caf5 guibg=#3d59a1")
vim.cmd("hi CurSearch guifg=#15161e guibg=#ff9e64")
vim.cmd("hi IncSearch guifg=#15161e guibg=#ff9e64")

vim.api.nvim_set_keymap("n", "q", ":qa!<CR>", { silent = true })

-- Short highlight on yanked text
vim.cmd([[
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
  augroup END
]])

vim.cmd([[
  augroup start_at_bottom
    autocmd!
    autocmd VimEnter * normal G
  augroup END
]])

vim.cmd([[
  augroup prevent_insert
    autocmd!
    autocmd TermEnter * stopinsert
  augroup END
]])
