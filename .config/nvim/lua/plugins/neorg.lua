return {
  "nvim-neorg/neorg",
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {},
        ["core.keybinds"] = {
          config = {
            default_keybinds = false, -- set to false if you want to make your own bindings
          },
        },
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              personal = "~/dev/notes",
              work = "~/dev/wwhs/wwhs-notes",
            },
          },
        },
        -- How to export: https://github.com/nvim-neorg/neorg/wiki/Exporting-Files
        ["core.export"] = {},
        ["core.export.markdown"] = {},
        ["core.journal"] = {
          config = {
            -- Journal entries will live in personal workspace /journal
            workspace = "personal",
          },
        },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        ["core.integrations.nvim-cmp"] = {},
      },
    }

    local wk = require "which-key"
    wk.add {
      {
        "<leader>nr",
        "<CMD>Neorg return<CR>",
        desc = "Neorg return",
        mode = "n",
      },
      {
        "<leader>np",
        "<CMD>Neorg workspace personal<CR>",
        desc = "Neorg personal notes",
        mode = "n",
      },
      {
        "<leader>nw",
        "<CMD>Neorg workspace work<CR>",
        desc = "Neorg work notes",
        mode = "n",
      },
      {
        "<leader>nj",
        "<CMD>Neorg journal today<CR>",
        desc = "Neorg journal today",
        mode = "n",
      },
      {
        "<leader>nc",
        "<CMD>Neorg toggle-concealer<CR>",
        desc = "Neorg toggle concealer",
        mode = "n",
      },
    }

    -- ### Neorg file mappings ###
    -- Need autocmd to not have bindings global, only for neorg files
    -- Whichkey auto detects keys set the vim way
    vim.api.nvim_create_autocmd("Filetype", {
      pattern = "norg",
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_keymap(
          buf,
          "n",
          "<localleader>l",
          "<Plug>(neorg.esupports.hop.hop-link)",
          { desc = "follow link", silent = true }
        )
        vim.api.nvim_buf_set_keymap(
          buf,
          "n",
          "<localleader>o",
          "<Plug>(neorg.pivot.list.toggle)",
          { desc = "toggle list unordered/ordered", silent = true }
        )
        vim.api.nvim_buf_set_keymap(
          buf,
          "n",
          "<localleader>t",
          "<Plug>(neorg.qol.todo-items.todo.task-cycle)",
          { desc = "toggle task completion", silent = true }
        )
        vim.api.nvim_buf_set_keymap(
          buf,
          "n",
          "<localleader>d",
          "<Plug>(neorg.tempus.insert-date)",
          { desc = "insert date at position", silent = true }
        )
      end,
    })
  end,
}
