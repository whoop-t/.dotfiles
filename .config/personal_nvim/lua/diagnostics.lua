-- Icons for lsp errors
local signs = {
  Error = "", -- Icon for errors
  Warn = "", -- Icon for warnings
  Hint = "", -- Icon for hints
  Info = "", -- Icon for information
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
