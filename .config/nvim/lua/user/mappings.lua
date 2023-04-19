-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    [ "<C-j>" ] = false,
    [ "<C-k>" ] = false,
    [ "<C-l>" ] = false,
    [ "<C-;>" ] = false,
    ["<leader>b"] = false,
    ["<leader>bb"] = false,
    ["<leader>bd"] = false,
    ["<leader>b\\"] = false,
    ["<leader>b|"] = false,
    ["<leader>bC"] = false,
    ["<leader>bc"] = false,
    ["<leader>bD"] = false,
    ["<leader>bl"] = false,
    ["<leader>bn"] = false,
    ["<leader>br"] = false,
    ["<leader>bs"] = false,
    -- second key is the lefthand side of the map
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>p"] = { "\"_dP", desc = "blackhole delete and paste" },
    ["<leader>h"] = { "<cmd>nohlsearch<cr>", desc = "remove search highlight" },
    -- Keep cursor in middle when cntrl-d or cntrl-u, less disorienting
    ["<C-d>"] =  { "<C-d>zz" },
    ["<C-u>"] =  { "<C-u>zz" },
    -- remap to allow H and L to move buffers(tabs)
    ["L"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer"
    },
    ["H"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    -- Since we only have one buffer viewable, close_all each time and show dashboard
    ["<leader>c"] = {
        function()
          require("astronvim.utils.buffer").close_all()
          require("alpha").start(true)
        end,
        desc = "Close buffer",
      },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  v = {
    ["<leader>p"] = { "\"_dP", desc = "blackhole delete and paste" },
  }
}