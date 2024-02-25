return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return {
        options = {
          -- Its not using this theme current, idk why yet. Loading issue?
          theme = "tokyonight",
          component_separators = "|",
          disabled_filetypes = {
            statusline = {
              "dashboard",
              "aerial",
              "dapui_.",
              "neo%-tree",
              "NvimTree",
            },
          },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {},
          lualine_b = {
            "branch",
            -- { "filetype", icon_only = true, separator = "", padding = { right = 0 } }, --disabling cause idk how to make bg transparent of icon
            "filename",
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },
}
