local M = {}

M.git = {
  Git = "󰊢 ",
  GitAdd = " ",
  GitBranch = "",
  GitChange = " ",
  GitConflict = " ",
  GitDelete = " ",
  GitIgnored = "◌",
  GitRenamed = "➜",
  GitSign = "▎",
  GitStaged = "✓",
  GitUnstaged = "✗",
  GitUntracked = "★",
}

-- Icons for lsp errors
M.diagnostics = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
  Modified = "●",
  Readonly = " ",
}

-- Define all the diagnostic icons
for type, icon in pairs(M.diagnostics) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

return M
