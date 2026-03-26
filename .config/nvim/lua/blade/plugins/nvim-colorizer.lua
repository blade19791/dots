return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			"*", -- all filetypes
		}, {
			RGB = true, -- rgb(255, 0, 0)
			RRGGBB = true, -- #RRGGBB
			names = true, -- "red", "blue"
			RRGGBBAA = true, -- #RRGGBBAA
			AARRGGBB = true, -- 0xAARRGGBB
			rgb_fn = true, -- rgb() functions
			hsl_fn = true, -- hsl() functions
			css = true, -- enable css features
			css_fn = true, -- rgba(), hsla()
			tailwind = true, -- 🔥 Tailwind colors (important)
			mode = "background", -- 🔥 THIS is NvChad style
		})
	end,
}
