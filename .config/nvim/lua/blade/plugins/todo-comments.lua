-- Finds and lists all of the TODO, HACK, BUG, etc comments in your project.
-- Mirrors omarchy (LazyVim), minus the Trouble-only keymaps.
return {
	"folke/todo-comments.nvim",
	cmd = { "TodoTelescope" },
	event = { "BufReadPost", "BufNewFile" },
	opts = {},
	keys = {
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next Todo Comment",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Previous Todo Comment",
		},
		{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
		{
			"<leader>sT",
			"<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",
			desc = "Todo/Fix/Fixme",
		},
	},
}