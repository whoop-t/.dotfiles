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

return M
