return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "night",
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
		transparent = true,
		on_highlights = function(hl)
			-- set telescope-bg transparent
			hl.TelescopeNormal = {
				fg = "#FFFFFF",
			}
			hl.TelescopeBorder = {
				bg = "NONE",
			}
		end,
	},
}
