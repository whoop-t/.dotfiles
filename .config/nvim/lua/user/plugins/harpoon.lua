return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  config = function()
    local harpoon = require("harpoon")
    -- REQUIRED
    harpoon:setup()
    -- REQUIRED
  end,
  keys = {
    { "<leader>a", function() require("harpoon"):list():append() end,                                  desc = "Harpoon Add file" },
    { "<C-e>",     function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,  desc = "Toggle quick menu" },
    { "<C-j>",     function() require("harpoon"):list():select(1) end,                                 desc = "Nav file 1" },
    { "<C-k>",     function() require("harpoon"):list():select(2) end,                                 desc = "Nav file 2" },
    { "<C-l>",     function() require("harpoon"):list():select(3) end,                                 desc = "Nav file 3" },
    { "<C-;>",     function() require("harpoon"):list():select(4) end,                                 desc = "Nav file 4" },
  },
}
