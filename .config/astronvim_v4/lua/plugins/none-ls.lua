if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      null_ls.builtins.formatting.stylua,
      -- Check if .prettierrc, if true, use prettierd, else use eslint
      -- This is for working on multiple projects where one uses prettier and the other just has eslint
      null_ls.builtins.formatting.prettierd.with {
        condition = function(utils)
          local file_check_result = utils.has_file(".prettierrc", ".prettierrc.js", ".prettierrc.json", ".prettierrc.yaml")
          return file_check_result and nil
        end,
      },
      null_ls.builtins.formatting.eslint.with {
        condition = function(utils)
          local file_check_result = utils.has_file(".prettierrc", ".prettierrc.js", ".prettierrc.json", ".prettierrc.yaml")
          return not file_check_result
        end,
      },
      -- Set a linter
      null_ls.builtins.diagnostics.eslint,
      -- Set code actions
      null_ls.builtins.code_actions.eslint

    }
    return config -- return final config table
  end,
}
