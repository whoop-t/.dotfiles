local git_icons = {
  Git = "󰊢",
  GitAdd = "",
  GitBranch = "",
  GitChange = "",
  GitConflict = "",
  GitDelete = "",
  GitIgnored = "◌",
  GitRenamed = "➜",
  GitSign = "▎",
  GitStaged = "✓",
  GitUnstaged = "✗",
  GitUntracked = "★",
}

return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        on_attach = function(bufnr)
          local gitsigns = require "gitsigns"
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map("n", "<leader>gl", function() gitsigns.blame_line() end, { desc = "View Git blame" })

          -- NOTE: not used anymore, using leader g for snacks mappings
          -- 
          -- map("n", "<leader>gL", function() gitsigns.blame_line { full = true } end, { desc = "View full Git blame" })
          -- map("n", "<leader>gp", function() gitsigns.preview_hunk_inline() end, { desc = "Preview Git hunk" })
          -- map("n", "<leader>gr", function() gitsigns.reset_hunk() end, { desc = "Reset Git hunk" })
          -- map(
          --   "v",
          --   "<leader>gr",
          --   function() gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end,
          --   { desc = "Reset Git hunk" }
          -- )
          -- map("n", "<leader>gR", function() gitsigns.reset_buffer() end, { desc = "Reset Git buffer" })
          -- map("n", "<leader>gs", function() gitsigns.stage_hunk() end, { desc = "Stage Git hunk" })
          -- map(
          --   "v",
          --   "<leader>gs",
          --   function() gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end,
          --   { desc = "Stage Git hunk" }
          -- )
          -- map("n", "<leader>gS", function() gitsigns.stage_buffer() end, { desc = "Stage Git buffer" })
          -- map("n", "<leader>gu", function() gitsigns.undo_stage_hunk() end, { desc = "Unstage Git hunk" })
          -- map("n", "<leader>gd", function() gitsigns.diffthis() end, { desc = "View Git diff" })
        end,
        signs = {
          add = { text = git_icons.GitSign },
          change = { text = git_icons.GitSign },
          delete = { text = git_icons.GitSign },
          topdelete = { text = git_icons.GitSign },
          changedelete = { text = git_icons.GitSign },
          untracked = { text = git_icons.GitSign },
        },
      }
    end,
  },
}
