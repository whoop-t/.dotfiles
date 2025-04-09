-- This is a minimal config just for kitty scrollback pager
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.scrollback = 100000
vim.opt.background = "dark"
vim.opt.swapfile = false
vim.opt.breakindent = true                              -- Wrap indent to match line start
vim.opt.clipboard = "unnamedplus"                       -- Connection to the system clipboard
vim.opt.cmdheight = 0                                   -- Hide command line unless needed
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion
vim.opt.copyindent = true                               -- Copy the previous indentation on autoindenting
vim.opt.cursorline = true                               -- Highlight the text line of the cursor
vim.opt.expandtab = true                                -- Enable the use of space in tab
vim.opt.fileencoding = "utf-8"                          -- File content encoding for the buffer
vim.opt.fillchars = { eob = " " }                       -- Disable `~` on nonexistent lines
vim.opt.foldenable = true                               -- Enable fold for nvim-ufo
vim.opt.foldlevel = 99                                  -- Set high foldlevel for nvim-ufo
vim.opt.foldlevelstart = 99                             -- Start with all code unfolded
vim.opt.foldcolumn = "0"                                -- Hide foldcolumn
vim.opt.history = 100                                   -- Number of commands to remember in a history table
vim.opt.ignorecase = true                               -- Case insensitive searching
vim.opt.infercase = true                                -- Infer cases in keyword completion
vim.opt.laststatus = 0                                  -- Global statusline
vim.opt.linebreak = true                                -- Wrap lines at 'breakat'
vim.opt.preserveindent = true                           -- Preserve indent structure as much as possible
vim.opt.pumheight = 10                                  -- Height of the pop-up menu
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.statuscolumn = "%=%{v:relnum?v:relnum:' '} %s"
vim.opt.shiftwidth = 2        -- Number of spaces inserted for indentation
vim.opt.showmode = false      -- Disable showing modes in command line
vim.opt.showtabline = 0       -- Always display tabline
vim.opt.signcolumn = "yes"    -- Always show the sign column
vim.opt.smartcase = true      -- Case sensitive searching
vim.opt.splitbelow = true     -- Splitting a new window below the current one
vim.opt.splitright = true     -- Splitting a new window at the right of the current one
vim.opt.tabstop = 2           -- Number of spaces in a tab
vim.opt.termguicolors = true  -- Enable 24-bit RGB color in the TUI
vim.opt.title = true          -- Set terminal title to the filename and path
vim.opt.undofile = true       -- Enable persistent undo
vim.opt.updatetime = 300      -- Length of time to wait before triggering the plugin
vim.opt.virtualedit = "block" -- Allow going past end of line in visual block mode
vim.opt.wrap = false          -- Disable wrapping of lines longer than the width of window
vim.opt.writebackup = false   -- Disable making a backup before overwriting a file
vim.opt.scrolloff = 8         -- How many lines to keep on top/bottom of screen when scrolling
vim.o.winborder = 'rounded'   -- Set LSP information border

vim.cmd("hi Visual guibg=#283457")
vim.cmd("hi Cursor guifg=#1a1b26 guibg=#c0caf5")
vim.cmd("hi LineNr guifg=#3b4261")
vim.cmd("hi Search guifg=#c0caf5 guibg=#3d59a1")
vim.cmd("hi CurSearch guifg=#15161e guibg=#ff9e64")
vim.cmd("hi IncSearch guifg=#15161e guibg=#ff9e64")
vim.cmd("hi Normal guifg=NONE guibg=NONE")
vim.cmd("hi NormalFloat guifg=#ffffff guibg=NONE")
vim.cmd("hi CursorLine guibg=#292e42")

vim.api.nvim_set_keymap("n", "q", ":qa!<CR>", { silent = true })

-- Short highlight on yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})


vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("start_at_bottom", { clear = true }),
  callback = function()
    vim.cmd("normal! G")
  end,
})

vim.api.nvim_create_autocmd("TermEnter", {
  group = vim.api.nvim_create_augroup("prevent_insert", { clear = true }),
  callback = function()
    vim.cmd("stopinsert")
  end,
})

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.opt_local.relativenumber = false
      vim.opt_local.number = true
      vim.opt_local.statuscolumn = ""
    end
  end,
})
