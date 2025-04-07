-- ~/.config/nvim/init.lua

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

-- Plugin setup
require("lazy").setup({
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      picker = {
        enabled = true,
        win = {
          -- input window
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["<C-n>"] = { "history_forward", mode = { "i", "n" } },
              ["<C-p>"] = { "history_back", mode = { "i", "n" } },
            }
          }
        }
      },
      notifier = { enabled = true },
      bigfile = { enabled = true },
      debug = { enabled = true },
      gitbrowse = { enabled = true },
      dim = {
        -- only enable when we toggle it on
        enabled = false,
        animate = {
          -- dont animate
          enabled = false,
        },
      },
      indent = {
        enabled = true,
        animate = {
          enabled = false
        },
        scope = {
          -- Current scope indent highlight with color toggle
          -- dont animate currently
          enabled = false
        }
      },
      lazygit = {
        configure = true,

      },

      --
      -- Snack plugin styles
      --
      styles = {
        lazygit = {
          width = 0.99,
          height = 0.99,
          border = "rounded",
        }
      }
    },
    keys = {
      -- SET UP PICKER FOR SNIPPETS
      -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#snippet-list

      -- lazygit
      { "<leader>gg", function() Snacks.lazygit() end,                                                                                     desc = "Lazygit" },
      -- notifier
      { "<leader>un", function() Snacks.notifier.hide() end,                                                                               desc = "Dismiss All Notifications" },
      -- gitbrowse
      -- CURRENTLY must use gitblame and hover commit hash, then enter command
      { "<leader>gc", function() Snacks.gitbrowse.open({ what = 'commit' }) end,                                                           desc = "Open commit in browser",   mode = { "n", "v" } },
      -- spell(override default with picker for spelling)
      { "z=",         function() Snacks.picker.spelling() end,                                                                             desc = "Open commit in browser",   mode = { "n", "v" } },
      --
      -- pickers
      --
      -- file: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#files
      { "<leader>fp", function() Snacks.picker() end,                                                                                      desc = "Find Pickers" },
      { "<leader>ff", function() Snacks.picker.files({ hidden = true, ignored = true, exclude = { "node_modules", "dist" } }) end,         desc = "Find Files" },
      { "<leader>fw", function() Snacks.picker.grep({ hidden = true, ignored = true, exclude = { "node_modules", "dist" } }) end,          desc = "Grep" },
      { "<leader>fr", function() Snacks.picker.recent() end,                                                                               desc = "Recent" },
      { "<leader>ft", function() Snacks.picker.todo_comments({ hidden = true, ignored = true, exclude = { "node_modules", "dist" } }) end, desc = "Todo" },
      { "<leader>fn", function() Snacks.picker.notifications() end,                                                                        desc = "Notification History" },
      -- git
      { "<leader>gb", function() Snacks.picker.git_branches() end,                                                                         desc = "Git Branches" },
      { "<leader>gL", function() Snacks.picker.git_log() end,                                                                              desc = "Git Log" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end,                                                                         desc = "Git Log File" },
      { "<leader>gs", function() Snacks.picker.git_status() end,                                                                           desc = "Git Status" },
      { "<leader>gS", function() Snacks.picker.git_stash() end,                                                                            desc = "Git Stash" },
      { "<leader>gd", function() Snacks.picker.git_diff() end,                                                                             desc = "Git Diff (Hunks)" },
      -- search
      { "<leader>sk", function() Snacks.picker.keymaps() end,                                                                              desc = "Keymaps" },
      { '<leader>s"', function() Snacks.picker.registers() end,                                                                            desc = "Registers" },
      { '<leader>s/', function() Snacks.picker.search_history() end,                                                                       desc = "Search History" },
      { "<leader>sc", function() Snacks.picker.command_history() end,                                                                      desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end,                                                                             desc = "Commands" },
      { "<leader>lD", function() Snacks.picker.diagnostics_buffer() end,                                                                   desc = "Buffer Diagnostics" },
      { "<leader>sD", function() Snacks.picker.diagnostics() end,                                                                          desc = "Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end,                                                                                 desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end,                                                                           desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end,                                                                                desc = "Icons" },
      { "<leader>sj", function() Snacks.picker.jumps() end,                                                                                desc = "Jumps" },
      { "<leader>sm", function() Snacks.picker.marks() end,                                                                                desc = "Marks" },
      { "<leader>sM", function() Snacks.picker.man() end,                                                                                  desc = "Man Pages" },
      { "<leader>sp", function() Snacks.picker.lazy() end,                                                                                 desc = "Search for Plugin Spec" },
      { "<leader>sq", function() Snacks.picker.qflist() end,                                                                               desc = "Quickfix List" },
      { "<leader>su", function() Snacks.picker.undo() end,                                                                                 desc = "Undo History" },
      { "<leader>uC", function() Snacks.picker.colorschemes() end,                                                                         desc = "Colorschemes" },
      {
        "<leader>ss",
        function()
          -- helpful: https://github.com/folke/snacks.nvim/discussions/498
          local snippets = require("luasnip").available()
          local flat_snips = {}
          -- flatten all the snippets into an unnested table
          for _, snips in pairs(snippets) do
            for _, snip in ipairs(snips) do
              table.insert(
                flat_snips,
                {
                  text = snip.name,
                  name = snip.name,
                  trigger = snip.trigger,
                  description = snip.description,
                }
              )
            end
          end
          -- sort alphabetically
          table.sort(flat_snips, function(a, b)
            return a.text:lower() < b.text:lower()
          end)

          -- pipe snippets found into picker
          return Snacks.picker({
            layout = {
              preview = false,
            },
            items = flat_snips,
            -- format the line item text
            format = function(item)
              local desc = type(item.description) == "table"
                  and table.concat(item.description, " ")
                  or (item.description or "")

              return {
                { item.name,                   "SnacksPickerLabel" },
                { " [" .. item.trigger .. "]", "SnacksPickerHint" },
                { " - " .. desc,               "SnacksPickerComment" },
              }
            end,
            -- copy trigger for snippet on select
            confirm = function(picker, item)
              picker:close()
              vim.fn.setreg("+", item.trigger) -- copies trigger to clipboard
              vim.notify("Copied trigger: " .. item.trigger)
            end,
          })
        end,
        desc = "Search snippets"
      },
      -- LSP
      { "gd",         function() Snacks.picker.lsp_definitions() end,      desc = "Goto Definition" },
      { "gD",         function() Snacks.picker.lsp_declarations() end,     desc = "Goto Declaration" },
      { "<leader>lr", function() Snacks.picker.lsp_references() end,       nowait = true,                  desc = "References" },
      { "gi",         function() Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation" },
      { "gy",         function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require "harpoon"
      harpoon:setup {
        settings = {
          save_on_toggle = true, -- Save items deleted/changed on the UI when you close
        },
      }

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set(
        "n",
        "<C-e>",
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list(), {
            border = "rounded",
            title_pos = "center",
            ui_width_ratio = 0.4,
          })
        end
      )
      -- Kitty hack, these are bound to alt, but kitty is binding ctrl + KEY to send this as well
      -- see kitty.conf
      vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<M-p>", function() harpoon:list():select(4) end)
    end,
  },
  {
    -- "folke/tokyonight.nvim",
    -- USING fork until blink color fixes are merged
    "whoop-t/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      transparent = true,
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- make sure nerd fonts are installed for this to work
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    opts = function()
      -- Set modified highlight color
      vim.api.nvim_set_hl(0, "NeoTreeModified", { fg = "#c0caf5" })
      -- get autocommand to open neotree on load working
      return {
        filesystem = {
          follow_current_file = { enabled = true },
          hijack_netrw_behavior = "open_current",
          use_libuv_file_watcher = vim.fn.has "win32" ~= 1,
          filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
          },
        },
        default_component_configs = {
          modified = {
            highlight = "NeoTreeModified",
          },
          indent = {
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            indent_size = 2,
            padding = 1,
          },
          -- Below hides the extra info columns
          file_size = {
            enabled = false,
          },
          type = {
            enabled = false,
          },
          last_modified = {
            enabled = false,
          },
        },
        parent_or_close = function(state)
          local node = state.tree:get_node()
          if (node.type == "directory" or node:has_children()) and node:is_expanded() then
            state.commands.toggle_node(state)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        end,
        window = {
          mappings = {
            ["q"] = "noop",
            ["<C-f>"] = function() vim.fn.system("tmux neww ~/.config/bin/tmux-sessionizer.sh") end,
          },
        },
      }
    end,
    keys = function()
      return {
        {
          "<leader>e",
          function()
            local bufs = vim.fn.getbufinfo { buflisted = 1 }
            if vim.bo.filetype == "neo-tree" and not bufs[1] then
              -- do nothing
            else
              vim.api.nvim_command "Neotree toggle current reveal_force_cwd"
            end
          end,
        },
      }
    end,
  },
})

-- colorscheme(is there a better place for this?)
vim.cmd.colorscheme "tokyonight"

vim.opt.breakindent = true                                         -- Wrap indent to match line start
vim.opt.clipboard = "unnamedplus"                                  -- Connection to the system clipboard
vim.opt.cmdheight = 0                                              -- Hide command line unless needed
vim.opt.completeopt = { "menu", "menuone", "noselect" }            -- Options for insert mode completion
vim.opt.copyindent = true                                          -- Copy the previous indentation on autoindenting
vim.opt.cursorline = true                                          -- Highlight the text line of the cursor
vim.opt.expandtab = true                                           -- Enable the use of space in tab
vim.opt.fileencoding = "utf-8"                                     -- File content encoding for the buffer
vim.opt.fillchars = { eob = " " }                                  -- Disable `~` on nonexistent lines
vim.opt.foldenable = true                                          -- Enable fold for nvim-ufo
vim.opt.foldlevel = 99                                             -- Set high foldlevel for nvim-ufo
vim.opt.foldlevelstart = 99                                        -- Start with all code unfolded
vim.opt.foldcolumn = "0"                                           -- Hide foldcolumn
vim.opt.history = 100                                              -- Number of commands to remember in a history table
vim.opt.ignorecase = true                                          -- Case insensitive searching
vim.opt.infercase = true                                           -- Infer cases in keyword completion
vim.opt.laststatus = 0                                             -- Global statusline
vim.opt.linebreak = true                                           -- Wrap lines at 'breakat'
vim.opt.mouse = ""                                                 -- Enable mouse support
vim.opt.number = true                                              -- Show numberline
vim.opt.preserveindent = true                                      -- Preserve indent structure as much as possible
vim.opt.pumheight = 10                                             -- Height of the pop-up menu
vim.opt.relativenumber = true                                      -- Show relative numberline
vim.opt.shiftwidth = 2                                             -- Number of spaces inserted for indentation
vim.opt.showmode = false                                           -- Disable showing modes in command line
vim.opt.showtabline = 0                                            -- Always display tabline
vim.opt.signcolumn = "yes"                                         -- Always show the sign column
vim.opt.statuscolumn = "%=%{v:relnum == 0 ? v:lnum : v:relnum} %s" -- custom line number and sign column arrangement
vim.opt.smartcase = true                                           -- Case sensitive searching
vim.opt.splitbelow = true                                          -- Splitting a new window below the current one
vim.opt.splitright = true                                          -- Splitting a new window at the right of the current one
vim.opt.tabstop = 2                                                -- Number of spaces in a tab
vim.opt.termguicolors = true                                       -- Enable 24-bit RGB color in the TUI
vim.opt.title = true                                               -- Set terminal title to the filename and path
vim.opt.undofile = true                                            -- Enable persistent undo
vim.opt.updatetime = 300                                           -- Length of time to wait before triggering the plugin
vim.opt.virtualedit = "block"                                      -- Allow going past end of line in visual block mode
vim.opt.wrap = false                                               -- Disable wrapping of lines longer than the width of window
vim.opt.writebackup = false                                        -- Disable making a backup before overwriting a file
vim.opt.scrolloff = 8                                              -- How many lines to keep on top/bottom of screen when scrolling
vim.o.winborder = 'rounded'                                        -- Set LSP information border

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
autocmd("BufEnter", {
  desc = "Open Neo-Tree on startup with directory",
  group = augroup("neotree_start", { clear = true }),
  callback = function()
    if package.loaded["neo-tree"] then
      vim.api.nvim_del_augroup_by_name "neotree_start"
    else
      local stats = vim.uv.fs_stat(vim.api.nvim_buf_get_name(0))
      if stats and stats.type == "directory" then
        vim.api.nvim_del_augroup_by_name "neotree_start"
        require "neo-tree"
      end
    end
  end,
})
