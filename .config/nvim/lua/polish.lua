-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

-- Autocommands
vim.api.nvim_create_augroup("spellcheck", { clear = true })
vim.api.nvim_create_autocmd("BufRead", {
  desc = "Turn spell and wrap on for certain files",
  pattern = { "*.txt", "*.md" },
  group = "spellcheck",
  callback = function()
    local current_file = vim.fn.expand "%:p"

    -- Exclude files in nvim/runtime/doc with a .txt extension
    if current_file:match "/nvim/runtime/doc/.*%.txt$" then return end

    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    require "notify" "spell and wrap on"
  end,
})
