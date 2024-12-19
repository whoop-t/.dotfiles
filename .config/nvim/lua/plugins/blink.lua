return {
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    -- use a release tag to download pre-built binaries
    version = "v0.*",

    opts = {
      keymap = { preset = "default" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 150,
          window = {
            winblend = 0,
            border = "rounded",
            max_width = 50,
            max_height = 15,
          },
        },
        menu = {
          border = "rounded",
          winblend = 0,
          draw = {
            columns = {
              { "kind_icon", "label", "label_description", gap = 1 },
            },
            components = {
              label = { width = { max = 30 } },
              label_description = { width = { max = 20 } },
            },
          },
        },
      },
      signature = {
        enabled = true,
        window = {
          border = "rounded",
          winblend = 0,
          scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
        },
      },
    },
  },
}
