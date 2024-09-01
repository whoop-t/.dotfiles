return { -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  dependencies = {
    "nvim-neorg/neorg", -- add cmp source as dependency of cmp
  },
  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    local cmp = require "cmp"
    -- Extend sources: https://docs.astronvim.com/recipes/cmp/
    opts.sources = cmp.config.sources {
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip", priority = 750 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
      { name = "neorg" }, -- Add neoorg as cmp source
    }
  end,
}
