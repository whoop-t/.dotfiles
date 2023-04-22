return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    source_selector = {
      -- having these both false just show normal file path in neo-tree
      winbar = false, -- toggle to show selector on winbar
      statusline = false,
      sources = {
        -- Comment back in if you want sources later
        -- { source = "filesystem" },
        -- { source = "buffers" },
        -- { source = "git_status" },
      },
    },
    filesystem = {
      filtered_items = {
        visible = true, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = true,
      }
    },
    default_component_configs = {
      indent = {
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        indent_size = 2,
      },
    },
  }
}
