return {
	-- "folke/tokyonight.nvim",
	-- lazy = false,    -- load during startup
	-- priority = 1000, -- load before other UI plugins
	-- config = function()
	--   require("tokyonight").setup({
	--     style = "storm", -- storm | night | moon | day
	--     transparent = false,
	--     terminal_colors = true,
	--     styles = {
	--       comments = { italic = true },
	--       keywords = { italic = true },
	--       functions = {},
	--       variables = {},
	--     },
	--     sidebars = { "qf", "help", "terminal", "lazy" },
	--   })
	--
	--   vim.cmd("colorscheme tokyonight")
	-- end,

	-- nord theme
	"shaunsingh/nord.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.nord_contrast = true
		vim.g.nord_borders = true
		vim.g.nord_disable_background = false
		vim.g.nord_italic = true
		vim.g.nord_uniform_diff_background = true
		vim.g.nord_bold = true
		vim.g.nord_disable_background = true

		vim.cmd("colorscheme nord")
	end,
}
