-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
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
      desc = "remove search highlight",
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
          require("astronvim.utils.buffer").close(0)
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
}
