return {
  -- UI for actions like code actions
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      -- This is your opts table
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            },
          },
        },
      }
      require("telescope").load_extension "ui-select"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable "make" == 1, build = "make" },
    },
    cmd = "Telescope",
    opts = function()
      local actions = require "telescope.actions"

      require("telescope").load_extension "fzf"

      return {
        defaults = {
          file_ignore_patterns = { "^%.git[/\\]", "[/\\]%.git[/\\]", "^node_modules/*", "^.vscode/*" },
          git_worktrees = vim.g.git_worktrees,
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          extensions = {
            fzf = {},
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = { q = actions.close },
          },
          pickers = {
            find_files = {
              follow = true,
              hidden = true,
            },
          },
        },
      }
    end,
    keys = function()
      local builtin = require "telescope.builtin"
      return {
        {
          "<leader>ff",
          function()
            builtin.find_files {
              follow = true,
              hidden = true,
            }
          end,
          desc = "Find Files (including hidden)",
        },
        { "<leader>fF", function() builtin.find_files { hidden = true, no_ignore = true } end },
        { "<leader>fw", builtin.live_grep },
        {
          "<leader>fW",
          function()
            builtin.live_grep {
              additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
            }
          end,
        },
        { "<leader>f/", builtin.current_buffer_fuzzy_find },
        { "<leader>fo", builtin.oldfiles },
        { "<leader>fc", builtin.grep_string },
        { "<leader>fC", builtin.commands },
        { "<leader>ft", "<Cmd>TodoTelescope<CR>" },
        { "<leader>fh", builtin.help_tags },
        { "<leader>fk", builtin.keymaps },
        { "<leader>gb", function() builtin.git_branches { use_file_path = true } end },
        { "<leader>lD", builtin.diagnostics },
        { "<leader>lr", builtin.lsp_references },
        { "<leader>li", builtin.lsp_implementations },
        { "<leader>lt", builtin.lsp_type_definitions },
        { "gd", builtin.lsp_definitions },
      }
    end,
  },
}
