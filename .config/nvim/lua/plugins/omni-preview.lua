return {
  -- manage previews/opens
  -- plugins are still defined in their own files
  -- current used with:
  -- render markdown
  -- peek
  -- csvview
  -- cloak
  -- dir = '~/dev/omni-preview.nvim', -- for local dev
  "sylvanfranklin/omni-preview.nvim",
  opts = {},
  keys = {
    { "<leader>te", "<cmd>OmniPreview start<CR>", desc = "OmniPreview" },
    { "<leader>td", "<cmd>OmniPreview stop<CR>", desc = "OmniPreview" },
  },
}
