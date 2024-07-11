return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-n>"] = "cycle_history_next",
          ["<C-p>"] = "cycle_history_prev",
        },
      },
    },
    pickers = {
      find_files = {
        follow = true,
        hidden = true,
        file_ignore_patterns = { ".git/*", "node_modules/*", ".vscode/*" },
      },
    },
  },
}