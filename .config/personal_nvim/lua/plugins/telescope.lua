return {
	-- UI for actions like code actions
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			-- This is your opts table
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = function()
			local builtin = require("telescope.builtin")
			return {
				{ "<leader>ff", builtin.find_files },
				{ "<leader>fw", builtin.live_grep },
			}
		end,
	},
}
