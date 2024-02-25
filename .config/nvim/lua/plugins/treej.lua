return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = {
    { '<leader>m', '<CMD>TSJToggle<CR>', desc = 'Toggle TreeJ' },
  },
  cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false,
    })
  end,
}
