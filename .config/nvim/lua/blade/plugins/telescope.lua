return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x", -- use the stable branch
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<Leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<Leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

			require("telescope").setup({
				defaults = {
					-- Default configuration for telescope goes here:
					mappings = {
						i = {
							-- Map <C-j> and <C-k> to move in insert mode as well
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-k>"] = require("telescope.actions").move_selection_previous,
						},
					},
				},
				pickers = {
					-- Configuration for specific pickers goes here
					find_files = {
						theme = "dropdown", -- use a dropdown theme
						hidden = true, -- show hidden files (starting with .)
						-- don't show these files
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
					live_grep = {
						theme = "dropdown",
					},
				},
				extensions = {
					-- Extension configuration goes here:
					-- fzf, emoji, etc.
				},
			})

			-- This is a great advanced keymap: it lets you search for the word under your cursor.
			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string({
					search = vim.fn.input("Grep > "),
				})
			end)
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			require("telescope").load_extension("ui-select")
		end,
	},
}
