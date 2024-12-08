-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 100, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start, I have the plugin disabled in core.lua
      cmp = true, -- enable completion at start
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        foldcolumn = "0",
        showtabline = 0,
        scrolloff = 8,
        conceallevel = 0
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      -- second key is the lefthand side of the map
      -- tables with the `name` key will be registered with which-key if it's installed
      -- this is useful for naming menus
      n = {
         -- Enable tmux-sessionizer inside neovim
        ["<C-f>"] = { "<cmd>silent !tmux neww tmux-sessionizer.sh<CR>" },
         -- HACKY zelli-sessionizer inside neovim
         -- doesnt work great
        -- ["<C-f>"] = { "<cmd>silent !zellij run -i -- zellij-sessionizer.sh<CR>" },
        ["<Leader>o"] = false,
        ["<Leader>c"] = false,
        ["<Leader>n"] = false,
        ["<Leader>h"] = { "<cmd>nohlsearch<cr>", desc = "remove search highlight" },
        ["<Leader>cf"] = {
          '<cmd>let @+ = fnamemodify(expand("%:p"), ":.")<cr>',
          desc = "Copy current buffer file name",
        },
        -- Below toggles between buffer and neotree buffer
        -- BUT it will not toggle from neotree if no other buffers open
        ["<Leader>e"] = {
          function()
            local bufs = vim.fn.getbufinfo { buflisted = true }
            if vim.bo.filetype == "neo-tree" and not bufs[1] then
            -- do nothing
            else
              vim.api.nvim_command "Neotree toggle current reveal_force_cwd"
            end
          end,
          desc = "Toggle Fullscreen Neotree",
        },
        -- Keep cursor in middle when cntrl-d or cntrl-u, less disorienting
        ["<C-d>"] = { "<C-d>zz" },
        ["<C-u>"] = { "<C-u>zz" },
        -- GitBlame mappings
        ["<Leader>gu"] = { "<CMD>GitBlameOpenCommitURL<CR>", desc = "Open Blame Url" },

        -- Map lazydocker to td(requires lazydocker to be installed/in bin)
        ["<Leader>td"] = {
          function()
            if vim.fn.executable "lazydocker" == 1 and require("astrocore").is_available "toggleterm.nvim" then
              require("astrocore").toggle_term_cmd "lazydocker"
            end
          end,
          desc = "ToggleTerm lazydocker",
        },
        -- Overwrite telescope find all files to ignore dirs
        ["<Leader>fF"] = {
          function()
            require("telescope.builtin").find_files {
              hidden = true,
              no_ignore = true,
              file_ignore_patterns = { ".git/*" , "node_modules/*", ".vscode/*"},
            }
          end,
          desc = "Find all files(ignore node_modules/.git)",
        },
        -- Overwrite telescope find all words to ignore to ignore dirs
        ["<Leader>fW"] = {
          function()
            require("telescope.builtin").live_grep {
              additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
              file_ignore_patterns = { ".git/*" , "node_modules/*", ".vscode/*"},
            }
          end,
          desc = "Find words in all files(ignore node_modules/.git)",
        },
      },
      t = {},
      v = {
        ["<Leader>p"] = { '"_dP', desc = "blackhole delete and paste" },
        -- Visual mode line move
        -- ["J"] = { ":m '>+1<CR>gv=gv", desc = "Move line down" },
        -- ["K"] = { ":m '<-2<CR>gv=gv", desc = "Move line up"},
      },
    },
    on_keys = {
      -- first key is the namespace
      auto_hlsearch = false, -- clear this on_key, i like clearing the highlight myself
    },
  },
}
