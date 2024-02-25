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
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
      local builtin = require "telescope.builtin"
      return {
        { "<leader>ff", builtin.find_files },
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
        { "<leader>fc", builtin.grep_string },
        { "<leader>fC", builtin.commands },
        { "<leader>fh", builtin.help_tags },
        { "<leader>fk", builtin.keymaps },
        { "<leader>fk", builtin.keymaps },
        { "<leader>fb", function() builtin.git_branches { use_file_path = true } end },
      }
    end,
  },
}
