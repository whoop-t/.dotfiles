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

    local wk = require "which-key"
    wk.add {
      {
        "<leader>a",
        function() harpoon:list():add() end,
        desc = "Harpoon add",
        mode = "n",
      },
    }
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
    vim.keymap.set("n", "<M-j>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<M-k>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<M-l>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<M-;>", function() harpoon:list():select(4) end)
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
}
