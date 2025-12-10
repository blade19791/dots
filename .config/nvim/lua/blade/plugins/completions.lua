return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").load({
				paths = vim.fn.stdpath("config") .. "/snippets",
			})

			luasnip.filetype_extend("javascriptreact", { "javascript", "react" })
			luasnip.filetype_extend("typescript", { "javascript" })
			luasnip.filetype_extend("typescriptreact", { "javascript", "react" })

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							local entry = cmp.get_selected_entry()
							if entry then
								cmp.confirm({ select = true })
							else
								cmp.select_next_item()
							end
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				-- SNIPPETS FIRST, then LSP, then others
				sources = {
					{ name = "luasnip", priority = 1000, max_item_count = 8 }, -- Snippets first (highest priority)
					{ name = "nvim_lsp", priority = 900, max_item_count = 8 }, -- LSP second
					{
						name = "buffer",
						priority = 500,
						max_item_count = 3,
						option = {
							get_bufnrs = function()
								return { vim.api.nvim_get_current_buf() }
							end,
						},
					},
					{ name = "path", priority = 250, max_item_count = 3 },
				},

				completion = {
					keyword_length = 2, -- Wait for 2+ characters
					completeopt = "menu,menuone,noinsert,noselect",
				},

				sorting = {
					priority_weight = 2,
					comparators = {
						cmp.config.compare.exact, -- Exact matches first
						cmp.config.compare.score, -- Higher score first
						cmp.config.compare.recently_used, -- Recently used
						cmp.config.compare.locality, -- Local context
						cmp.config.compare.kind, -- By kind
						cmp.config.compare.length, -- Shorter first
						cmp.config.compare.order, -- Maintain order
					},
				},

				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(_, vim_item)
						local icons = {
							Text = "󰉿",
							Method = "󰆧",
							Function = "󰊕",
							Constructor = "",
							Field = "󰇽",
							Variable = "󰂡",
							Class = "󰠱",
							Interface = "",
							Module = "",
							Property = "󰜢",
							Unit = "󰑭",
							Value = "󰎠",
							Enum = "",
							Keyword = "󰌋",
							Snippet = "",
							Color = "󰏘",
							File = "󰈙",
							Reference = "󰈇",
							Folder = "󰉋",
							EnumMember = "",
							Constant = "󰏿",
							Struct = "󰙅",
							Event = "",
							Operator = "󰆕",
							TypeParameter = "󰅲",
						}

						vim_item.kind = string.format(" %s ", icons[vim_item.kind] or "󰃚")

						local sources = {
							nvim_lsp = "LSP",
							luasnip = "Snippet",
							buffer = "Buffer",
							path = "Path",
						}

						vim_item.menu = sources[_.source.name] or _.source.name
						return vim_item
					end,
				},

				window = {
					completion = {
						border = "single", -- Changed from "rounded" to "single" for thinner border
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
						scrollbar = false,
						side_padding = 0,
					},
					documentation = {
						border = "single", -- Changed from "rounded" to "single" for thinner border
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
						scrollbar = false,
					},
				},

				view = {
					entries = { name = "custom", selection_order = "near_cursor" },
				},
			})

			-- ... your existing cmdline configurations ...
			-- Set configuration for specific filetypes (optional)
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "buffer" },
				}),
			})

			-- Use buffer source for `/` and `?` (if you enabled `cmp-cmdline` earlier)
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `cmp-cmdline` earlier)
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}
