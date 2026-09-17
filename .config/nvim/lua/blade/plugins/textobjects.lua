-- Select and move between syntax-tree objects (functions, classes,
-- parameters...). Mirrors omarchy (LazyVim).
--
-- Move to object boundaries:
--   ]f / [f  next/prev function start     ]F / [F  function end
--   ]c / [c  next/prev class start        ]C / [C  class end
--   ]a / [a  next/prev parameter start    ]A / [A  parameter end
return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	event = "VeryLazy",
	opts = {
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
				["]a"] = "@parameter.inner",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
				["]A"] = "@parameter.inner",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
				["[a"] = "@parameter.inner",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
				["[A"] = "@parameter.inner",
			},
		},
	},
	config = function(_, opts)
		local TS = require("nvim-treesitter-textobjects")
		if TS.setup then
			TS.setup(opts)
		end
	end,
}