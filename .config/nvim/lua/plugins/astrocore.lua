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
      autopairs = true, -- enable autopairs at start
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
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["<C-l>"] = false,
        ["<C-;>"] = false,
        ["<leader>o"] = false,
        ["<leader>p"] = { '"_dP', desc = "blackhole delete and paste" },
        ["<leader>h"] = { "<cmd>nohlsearch<cr>", desc = "remove search highlight" },
        -- ["<leader>e"] = { "<cmd>:Neotree toggle current reveal_force_cwd<cr>", desc = "remove search highlight" },
        -- Below toggles between buffer and neotree buffer
        -- BUT it will not toggle from neotree if no other buffers open
        ["<leader>e"] = {
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
        -- remap to allow H and L to move buffers(tabs)
        -- ["L"] = {
        --   function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
        --   desc = "Next buffer",
        -- },
        -- ["H"] = {
        --   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
        --   desc = "Previous buffer",
        -- },
        -- Dont allowing closing of last buffer
        ["<leader>c"] = {
          function()
            local bufs = vim.fn.getbufinfo { buflisted = true }
            if not bufs[2] then
            -- do nothing, we dont wanna close last buffer
            elseif
              vim.bo.filetype == "neo-tree"
              -- if buffer is neotree, do nothing, we dont wanna close neotree with leader c
            then
            else
              require("astrocore.buffer").close(0)
            end
          end,
          desc = "Close buffer",
        },
        -- GitBlame mappings
        ["<leader>gu"] = { "<CMD>GitBlameOpenCommitURL<CR>", desc = "Open Blame Url" },

        -- Map lazydocker to td(requires lazydocker to be installed/in bin)
        ["<leader>td"] = {
          function()
            if vim.fn.executable "lazydocker" == 1 and require("astronvim.utils").is_available "toggleterm.nvim" then
              require("astronvim.utils").toggle_term_cmd "lazydocker"
            end
          end,
          desc = "ToggleTerm lazydocker",
        },
      },
      t = {},
      v = {
        ["<leader>p"] = { '"_dP', desc = "blackhole delete and paste" },
        -- Visual mode line move
        -- ["J"] = { ":m '>+1<CR>gv=gv", desc = "Move line down" },
        -- ["K"] = { ":m '<-2<CR>gv=gv", desc = "Move line up"},
      },
    },
    on_keys = {
      -- first key is the namespace
      auto_hlsearch = {}, -- clear this on_key, i like clearing the highlight myself
    },
  },
}