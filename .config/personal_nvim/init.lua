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

-- Load plugins, lazy will do this automagically if string is in lua/{your dir here}. I use 'plugins'
require("lazy").setup "plugins"

-- colorscheme(is there a better place for this?)
vim.cmd.colorscheme "tokyonight"

-- Highlights(is there a better place to put this)
vim.cmd [[
  highlight lualine_b_visual guibg=NONE
  highlight lualine_b_normal guibg=NONE
  highlight lualine_b_insert guibg=NONE
  highlight lualine_a_inactive guibg=NONE
  highlight lualine_b_inactive guibg=NONE
  highlight lualine_b_replace guibg=NONE
  highlight lualine_b_command guibg=NONE
  highlight lualine_c_inactive guibg=NONE
  highlight lualine_c_normal guibg=NONE
  highlight lualine_a_terminal guibg=NONE
  highlight lualine_b_terminal guibg=NONE
]]
