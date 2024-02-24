return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "tokyonight",
  -- colorscheme = "astrodark",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "tsserver"
      },
      -- This is needed to force formatting to use eslint, MAKE SURE PRETTIERD IS REMOVED
      -- filter = function(client)
      --   -- only enable null-ls for javascript files
      --   if vim.bo.filetype == "javascript" then
      --     return client.name == "null-ls"
      --   end
      --
      --   -- enable all other clients
      --   return true
      -- end,
      -- timeout_ms = 5000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
      timeout_ms = 5000, -- default format timeout
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Disable any keystroke on search diabling highlight(I like to do it manually)
    vim.on_key(function() end, vim.api.nvim_create_namespace "auto_hlsearch")
    -- Spellcheck and wrap on certain files
    vim.api.nvim_create_augroup("spellcheck", { clear = true })
    vim.api.nvim_create_autocmd("BufRead", {
      desc = "Turn spell and wrap on for certain files",
      pattern = { "*.txt", "*.md" },
      group = "spellcheck",
      callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
        require "notify" "spell and wrap on"
      end,
    })
  end,
}
