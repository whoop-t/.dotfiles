return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "tokyonight",
        component_separators = "|",
      },
      sections = {
        lualine_a = {
          { "mode", right_padding = 2 },
        },
        lualine_b = { "filename", "branch" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = {
          { "location", left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
    },
  },
}
