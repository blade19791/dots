return {
	{
		"kylechui/nvim-surround",
		version = "*", -- stable release
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			npairs.setup({
				check_ts = true, -- enable treesitter integration
				ts_config = {
					lua = { "string" }, -- don't add pairs inside lua string
					javascript = { "template_string" },
				},
				disable_filetype = { "TelescopePrompt", "spectre_panel" },
			})

			-- Custom rules
			local Rule = require("nvim-autopairs.rule")

			-- Add /* */ pair for all languages
			npairs.add_rules({
				Rule("/*", "*/", "-vim"), -- -vim disables it in vim filetype
			})

			-- LaTeX example: \begin{ -> \end{}
			npairs.add_rules({
				Rule("\\begin{", "\\end{", "tex"),
			})

			-- If you’re using nvim-cmp, connect autopairs with it
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}
