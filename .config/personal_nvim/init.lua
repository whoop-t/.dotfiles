-- REMOVE ALL for NVIM_APPNAME=personal_nvim
-- rm -rf ~/.config/personal_nvim ~/.local/state/personal_nvim ~/.local/share/personal_nvim ~/.cache/personal_nvim
-- Set up lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Load other lua files
require "options"
require "mappings"
require "autocmds"
require "diagnostics"

-- Load plugins, lazy will do this automagically if string is in lua/{your dir here}. I use 'plugins'
require("lazy").setup "plugins"

-- colorscheme(is there a better place for this?)
vim.cmd.colorscheme "tokyonight"

-- line number color custom
vim.cmd [[
  highlight CursorLineNr guifg=#c0c4d8 gui=bold
]]
