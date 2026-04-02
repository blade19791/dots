return {
	"joelflaig/colorify.nvim",
	config = function()
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
			callback = function()
				require("colorify").attach(0) -- 👈 attach to current buffer
			end,
		})
	end,
}
