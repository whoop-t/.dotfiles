return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    pickers = {
      find_files = {
        follow = true,
        hidden = true,
        file_ignore_patterns = { ".git/*", "node_modules/*", ".vscode/*" },
      },
    },
  },
}