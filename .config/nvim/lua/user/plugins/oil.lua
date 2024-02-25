return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  opts = {
    default_file_explorer = true,
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
      -- This function defines what will never be shown, even when `show_hidden` is set
      -- Currently hides the ../ dir that is shown
      is_always_hidden = function(name, bufnr) return vim.startswith(name, "..") end,
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
