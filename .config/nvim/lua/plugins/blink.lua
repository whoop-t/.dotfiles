return {
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          -- Add framework snippets
          -- https://github.com/rafamadriz/friendly-snippets?tab=readme-ov-file#add-snippets-from-a-framework-to-a-filetype
          require("luasnip").filetype_extend("html", { "angular" })

          require("luasnip.loaders.from_vscode").lazy_load() -- Load friendly-snippets
        end,
      },
    },
    -- use a release tag to download pre-built binaries
    version = "v0.*",

    opts = {
      keymap = { preset = "default" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      snippets = {
        preset = "luasnip",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          -- Below customizes the order/priority of recommendations
          -- https://cmp.saghen.dev/configuration/reference.html#providers
          lsp = {
            min_keyword_length = 0, -- Number of characters to trigger provider
            -- score_offset = 90, -- Boost/penalize the score of the items
          },
          path = {
            min_keyword_length = 0,
          },
          snippets = {
            min_keyword_length = 2,
            -- score_offset = 100, -- Boost/penalize the score of the items
            max_items = 3,
          },
          buffer = {
            min_keyword_length = 4,
            max_items = 3,
          },
        },
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
