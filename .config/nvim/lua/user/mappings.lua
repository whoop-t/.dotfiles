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
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
          require("astronvim.utils.buffer").close(
            bufnr)
        end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
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
    -- ["<S-l>"] = { "]b", desc = "next buffer" },
    -- ["<S-h>"] = { "[b", desc = "previous buffer" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  v = {
    ["<leader>p"] = { "\"_dP", desc = "blackhole delete and paste" },
  }
}