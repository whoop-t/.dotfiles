-- MD preview in browser
-- INFO: requires deno: https://deno.com/
return {
  "toppair/peek.nvim",
  event = { "VeryLazy" },
  build = "deno task --quiet build:fast",
  config = function()
    require("peek").setup {
      app = "browser",
    }
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

    vim.keymap.set("n", "<leader>mo", function() require("peek").open() end, { desc = "OmniPreview" })
    vim.keymap.set("n", "<leader>mc", function() require("peek").close() end, { desc = "OmniPreview" })
  end,
}
