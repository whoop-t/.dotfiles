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

-- NOTE: This doesnt work in monorepos
-- The lsps(eslint|biome) attach and format correctly due to interal logic from lsp-config
-- If you want more robust logic to attach the correct formatter in a monorepo based on current file in buffer
-- you will need to research that more
local function formatter_for_js()
  -- Get all files in the current directory
  local root_files = vim.fn.readdir(vim.fn.getcwd())

  -- Prettier check
  for _, config in ipairs(prettier_configs) do
    if vim.tbl_contains(root_files, config) then return { "prettierd" } end
  end

  -- Biome check
  for _, config in ipairs(biome_configs) do
    if vim.tbl_contains(root_files, config) then return { "biome", "biome-check" } end
  end

  -- ESLint check
  -- conform only has eslint_d
  -- NOTE: install with Mason
  -- NOTE: using eslint lsp, formatting is turned off for eslint to use eslint_d 
  -- see lsp.lua for more info
  for _, config in ipairs(eslint_configs) do
    if vim.tbl_contains(root_files, config) then return { "eslint_d" } end
  end

  -- Fallback formatter
  return {}
end

local js_formatter = formatter_for_js()
-- This is to test which formatter was selected on nvim open
-- print(js_formatter[1])

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
      json = { "prettierd" },
      jsonc = { "prettierd" },
      svelte = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      html = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      graphql = { "prettierd" },
      lua = { "stylua" },
      python = { "isort", "black" },
      go = { "gofmt" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}