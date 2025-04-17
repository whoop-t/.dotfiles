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

-- set global diag icons
vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = M.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = M.diagnostics.Warn,
      [vim.diagnostic.severity.HINT] = M.diagnostics.Hint,
      [vim.diagnostic.severity.INFO] = M.diagnostics.Info,
    },
  },
  linehl = {
    [vim.diagnostic.severity.ERROR] = "ErrorMsg",
  },
  numhl = {
    [vim.diagnostic.severity.WARN] = "WarningMsg",
  },
}

return M
