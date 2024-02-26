return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    config = function()
      -- should this go here?
      local lsp_zero = require "lsp-zero"

      lsp_zero.on_attach(function(_, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end, opts)
        lsp_zero.default_keymaps { buffer = bufnr } -- this will add lsp-zero defaults, but not override ones above
      end)
    end,
  },
  { "williamboman/mason.nvim", opts = {} },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local lsp_zero = require "lsp-zero"
      require("mason-lspconfig").setup {
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    "hrsh7th/nvim-cmp",
    -- REQUIRED for snippets/completions to show in cmp
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require "cmp"
      local cmp_action = require("lsp-zero").cmp_action()
      cmp.setup {
        sources = {
          -- priority will make certain completions show first, we want lsp and luasnips to show first
          { name = "luasnip", priority = 1000 },
          { name = "nvim_lsp", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        },
        mapping = cmp.mapping.preset.insert {
          -- `Enter` key to confirm completion
          ["<CR>"] = cmp.mapping.confirm { select = false },

          -- Ctrl+Space to trigger completion menu
          ["<C-Space>"] = cmp.mapping.complete(),
          -- Navigate between snippet placeholder
          ["<Tab>"] = cmp_action.luasnip_jump_forward(),
          ["<S-Tab>"] = cmp_action.luasnip_jump_backward(),

          -- Scroll up and down in the completion documentation
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    -- friendly-snippets needs to be dep of luasnip, else could cause issues
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
  },
}
