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
          local ls = require("luasnip")

          -- allows C-s autoexpand snippets if you just type them in insert then press C-s
          ls.config.set_config({
            enable_autosnippets = true,
            store_selection_keys = "<C-s>",
          })

          -- Add framework snippets
          -- https://github.com/rafamadriz/friendly-snippets?tab=readme-ov-file#add-snippets-from-a-framework-to-a-filetype
          ls.filetype_extend("html", { "angular" })

          -- load custom snippets
          require("luasnip.loaders.from_lua").lazy_load({
            paths = { vim.fn.stdpath("config") .. "/lua/snippets" }
          })

          require("luasnip.loaders.from_vscode").lazy_load() -- Load friendly-snippets

          -- Set javascript snippets to also work with typescript
          ls.filetype_extend("typescript", { "javascript" })
        end,

        keys = {
          -- keymaps for jumping snippet option fill ins
          { "<C-k>", function() require("luasnip").expand() end, mode = "i",          desc = "Expand snippet" },
          { "<C-l>", function() require("luasnip").jump(1) end,  mode = { "i", "s" }, desc = "Jump forward in snippet" },
          { "<C-h>", function() require("luasnip").jump(-1) end, mode = { "i", "s" }, desc = "Jump backward in snippet" },
          {
            "<C-e>",
            function()
              if require("luasnip").choice_active() then
                require("luasnip").change_choice(1)
              end
            end,
            mode = { "i", "s" },
            desc = "Cycle snippet choice",
          },
        }
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
