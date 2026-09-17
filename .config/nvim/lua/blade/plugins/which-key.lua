-- Shows available keybindings when you press a prefix. Mirrors omarchy's
-- (LazyVim's) which-key config, scoped to this setup's leader keys.
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{
				mode = { "n", "x" },
				{ "<leader>c", group = "code" },
				{ "<leader>d", group = "diagnostics" },
				{ "<leader>f", group = "file/find" },
				{ "<leader>g", group = "git" },
				{ "<leader>q", group = "quit/session" },
				{ "<leader>s", group = "search" },
				{ "<leader>b", group = "buffer" },
				{
					"<leader>w",
					group = "windows",
					proxy = "<c-w>",
				},
				{
					"<leader>t",
					group = "theme/tab",
				},
				{ "[", group = "prev" },
				{ "]", group = "next" },
				{ "g", group = "goto" },
				{ "gs", group = "surround" },
				{ "z", group = "fold" },
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Keymaps (which-key)",
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
	end,
}