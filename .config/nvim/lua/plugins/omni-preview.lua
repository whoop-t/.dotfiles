return {
  -- manage previews/opens
  -- will open pdfs/images/etc
  -- dir = '~/dev/omni-preview.nvim', -- for local dev
  "sylvanfranklin/omni-preview.nvim",
  dependencies = {
    -- CSV
    {
      "hat0uma/csvview.nvim",
      ---@module "csvview"
      ---@type CsvView.Options
      opts = {
        parser = { comments = { "#", "//" } },
        keymaps = {
          -- Text objects for selecting fields
          textobject_field_inner = { "if", mode = { "o", "x" } },
          textobject_field_outer = { "af", mode = { "o", "x" } },
          -- Excel-like navigation:
          -- Use <Tab> and <S-Tab> to move horizontally between fields.
          -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
          -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
          jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
          jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
          jump_next_row = { "<Enter>", mode = { "n", "v" } },
          jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
        },
      },
      cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    },
    -- MD preview in browser
    -- INFO: requires deno: https://deno.com/
    {
      "toppair/peek.nvim",
      event = { "VeryLazy" },
      build = "deno task --quiet build:fast",
      config = function()
        require("peek").setup({
          app = 'browser',
        })
        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

        vim.keymap.set("n", "<leader>mo", function() require("peek").open() end, { desc = "OmniPreview" })
        vim.keymap.set("n", "<leader>mc", function() require("peek").close() end, { desc = "OmniPreview" })
      end,
    },
    {
      "laytan/cloak.nvim",
      lazy = false,
      config = function()
        require("cloak").setup {
          enabled = true,
          cloak_character = "*",
          -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
          highlight_group = "Comment",
          -- Applies the length of the replacement characters for all matched
          -- patterns, defaults to the length of the matched pattern.
          cloak_length = nil, -- Provide a number if you want to hide the true length of the value.
          -- Whether it should try every pattern to find the best fit or stop after the first.
          try_all_patterns = true,
          patterns = {
            {
              -- Match any file starting with '.env'.
              -- This can be a table to match multiple file patterns.
              file_pattern = { ".env*", ".npmrc*", "local.cjs*", "credentials*" },
              -- Match an equals sign and any character after it.
              -- This can also be a table of patterns to cloak,
              -- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
              cloak_pattern = { "=.+", ":.+" },
              -- A function, table or strcng to generate the replacement.
              -- The actual replacement will contain the 'cloak_character'
              -- where it doesn't cover the original text.
              -- If left empty the legacy behavior of keeping the first character is retained.
              replace = nil,
            },
          },
        }
      end,
    },
  },
  opts = {},
  keys = {
    { "<leader>to", "<cmd>OmniPreview toggle<CR>", desc = "OmniPreview" },
    { "<leader>te", "<cmd>OmniPreview start<CR>",  desc = "OmniPreview" },
    { "<leader>td", "<cmd>OmniPreview stop<CR>",   desc = "OmniPreview" },
  }
}
