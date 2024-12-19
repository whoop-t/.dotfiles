return {
	-- "folke/tokyonight.nvim",
	-- USING fork until blink color fixes are merged
  "whoop-t/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "night",
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
		transparent = true,
	},
}
