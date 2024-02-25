-- Setup everything required for lsp
return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"tsserver",
				"jsonls",
				"bashls",
				"html",
				"cssls",
				"sqlls",
				"gopls",
			},
		},
	},
	-- neodev for vim hints and completion and avoiding global "vim" being undifined
	{ "folke/neodev.nvim", opts = {} },
	{
		"neovim/nvim-lspconfig",
		config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

			local lspconfig = require("lspconfig")
			-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
			require("neodev").setup()
			-- Setup all the servers, match ensure installed in mason-lspconfig setup
			lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
			lspconfig.tsserver.setup({
        capabilities = capabilities
      })
			lspconfig.jsonls.setup({
        capabilities = capabilities
      })
			lspconfig.bashls.setup({
        capabilities = capabilities
      })
			lspconfig.html.setup({
        capabilities = capabilities
      })
			lspconfig.cssls.setup({
        capabilities = capabilities
      })
			lspconfig.sqlls.setup({
        capabilities = capabilities
      })
			lspconfig.gopls.setup({
        capabilities = capabilities
      })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- !!!!!WHY is rename action running on every file and not local to buffer?
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>lf", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})
		end,
	},
}
