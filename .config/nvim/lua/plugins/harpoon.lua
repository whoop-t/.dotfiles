-- LEGACY HARPOON, broken on nvim 0.9.4+ due to api change
-- return {
--   "whoop-t/harpoon-light",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-telescope/telescope.nvim",
--   },
--   cmd = { "Harpoon" },
--   keys = {
--     { "<leader>a", function() require("harpoon.mark").add_file() end,        desc = "Harpoon Add file" },
--     { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle quick menu" },
--     { "<C-j>", function() require("harpoon.ui").nav_file(1) end, desc = "Nav file 1" },
--     { "<C-k>", function() require("harpoon.ui").nav_file(2) end, desc = "Nav file 2" },
--     { "<C-l>", function() require("harpoon.ui").nav_file(3) end, desc = "Nav file 3" },
--     { "<C-;>", function() require("harpoon.ui").nav_file(4) end, desc = "Nav file 4" },
--   },
-- }

return {
  "ThePrimeagen/harpoon",
  lazy = false,
  branch = "harpoon2",
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup {
      settings = {
        save_on_toggle = true, -- Save items deleted/changed on the UI when you close
      },
    }

    vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
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
    vim.keymap.set("n", "<C-m>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-,>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-.>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-/>", function() harpoon:list():select(4) end)
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
}