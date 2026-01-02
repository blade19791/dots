local M = {}

M.set = function(name)
	vim.g.colors_name = name
	vim.cmd("colorscheme " .. name)

	-- persist theme
	vim.fn.writefile({ name }, vim.fn.stdpath("config") .. "/.colorscheme")
end

M.load = function()
	local path = vim.fn.stdpath("config") .. "/.colorscheme"
	if vim.fn.filereadable(path) == 1 then
		local theme = vim.fn.readfile(path)[1]
		pcall(vim.cmd, "colorscheme " .. theme)
	end
end

return M
