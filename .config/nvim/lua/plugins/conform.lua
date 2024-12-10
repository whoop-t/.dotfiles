local eslint_configs = {
  ".eslintrc",
  ".eslintrc.json",
  ".eslintrc.js",
  ".eslintrc.yml",
  ".eslintrc.yaml",
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
}

local prettier_configs = {
  ".prettierrc",
  ".prettierrc.js",
  ".prettierrc.cjs",
  ".prettierrc.json",
  ".prettierrc.yaml",
  ".prettierrc.yml",
  ".prettierrc.toml",
  "prettier.config.cjs",
}

local biome_configs = { "biome.json" }

local function formatter_for_js()
  -- Get all files in the current directory
  local root_files = vim.fn.readdir(vim.fn.getcwd())

  -- Prettier check
  for _, config in ipairs(prettier_configs) do
    if vim.tbl_contains(root_files, config) then return { "prettierd" } end
  end

  -- Biome check
  for _, config in ipairs(biome_configs) do
    if vim.tbl_contains(root_files, config) then return { "biome" } end
  end

  -- ESLint check
  for _, config in ipairs(eslint_configs) do
    if vim.tbl_contains(root_files, config) then return { "eslint" } end
  end

  -- Fallback formatter
  return { "eslint" } -- This is just since at work this is currently the main formatter 12/2024
end

local js_formatter = formatter_for_js()

-- This is just for testing that the above method works correclty for finding the file
-- uncomment and then you can use :TestFormatter as a command to test
-- vim.api.nvim_create_user_command("TestFormatter", function() print(vim.inspect(formatter_for_js())) end, {})

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>lf",
      function() require("conform").format { async = true, lsp_fallback = true } end,
      mode = "",
      desc = "Format buffer",
    },
  },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      javascript = js_formatter,
      typescript = js_formatter,
      javascriptreact = js_formatter,
      typescriptreact = js_formatter,
      json = js_formatter,
      jsonc = js_formatter,
      svelte = { "prettierd" },
      css = { "prettierd" },
      html = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      graphql = { "prettierd" },
      lua = { "stylua" },
      python = { "isort", "black" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}
