return {
	-- Dracula
	{ "Mofiqul/dracula.nvim", lazy = false },

	-- Tokyo Night
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },

	-- Nord
	{ "shaunsingh/nord.nvim", lazy = false },

	-- Rose Pine
	{ "rose-pine/neovim", name = "rose-pine", lazy = false },

	-- Catppuccin
	{ "catppuccin/nvim", name = "catppuccin", lazy = false },
	-- gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		lazy = false,
		config = function()
			require("gruvbox").setup({
				transparent_mode = false,
			})
		end,
	},
}
