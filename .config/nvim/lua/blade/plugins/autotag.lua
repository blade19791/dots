-- Automatically add and close HTML/JSX tags. Mirrors omarchy (LazyVim).
return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPost", "BufNewFile" },
	opts = {},
}