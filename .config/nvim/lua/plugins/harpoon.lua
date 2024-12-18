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
  dependencies = { "nvim-lua/plenary.nvim" },
}
