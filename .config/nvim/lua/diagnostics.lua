-- Icons for lsp errors
local M = {}
M.signs = {
  Error = " ",
  Warn = " ",
  Hint = "󰌵",
  Info = " ",
  Modified = "●",
  Readonly = "",
}

for type, icon in pairs(M.signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Show diagnostics with lsp that outputted it
-- This opens a float with diag info
vim.keymap.set("n", "<leader>ld", function()
  vim.diagnostic.open_float(nil, {
    border = "rounded",
    -- Customize how each diagnostic is formatted
    format = function(diagnostic)
      if diagnostic.source then
        return string.format("[%s] %s", diagnostic.source, diagnostic.message)
      else
        return diagnostic.message
      end
    end,
    prefix = "", -- Remove prefix aka numbered list
    header = "", -- Remove the title
  })
end, { desc = "Show diagnostics with source" })

return M
