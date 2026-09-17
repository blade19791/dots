local M = {}

-- Make highlight groups transparent while preserving their other attributes.
-- Based on omarchy's plugin/after/transparency.lua.
local function make_transparent(name)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
	if ok then
		hl.bg = nil
		vim.api.nvim_set_hl(0, name, hl)
	end
end

local groups = {
	-- transparent background
	"Normal",
	"NormalFloat",
	"FloatBorder",
	"Pmenu",
	"Terminal",
	"EndOfBuffer",
	"FoldColumn",
	"Folded",
	"SignColumn",
	"LineNr",
	"CursorLineNr",
	"NormalNC",
	"WhichKeyFloat",
	"TelescopeBorder",
	"TelescopeNormal",
	"TelescopePromptBorder",
	"TelescopePromptTitle",
	-- neotree
	"NeoTreeNormal",
	"NeoTreeNormalNC",
	"NeoTreeVertSplit",
	"NeoTreeWinSeparator",
	"NeoTreeEndOfBuffer",
	-- nvim-tree
	"NvimTreeNormal",
	"NvimTreeVertSplit",
	"NvimTreeEndOfBuffer",
	-- bufferline / tabline
	"BufferLineFill",
	"BufferLineBackground",
	"BufferLineBuffer",
	"BufferLineBufferSelected",
	"BufferLineBufferVisible",
	"BufferLineTab",
	"BufferLineTabSelected",
	"TabLine",
	"TabLineFill",
	"TabLineSel",
	-- notify
	"NotifyINFOBody",
	"NotifyERRORBody",
	"NotifyWARNBody",
	"NotifyTRACEBody",
	"NotifyDEBUGBody",
	"NotifyINFOTitle",
	"NotifyERRORTitle",
	"NotifyWARNTitle",
	"NotifyTRACETitle",
	"NotifyDEBUGTitle",
	"NotifyINFOBorder",
	"NotifyERRORBorder",
	"NotifyWARNBorder",
	"NotifyTRACEBorder",
	"NotifyDEBUGBorder",
}

for _, name in ipairs(groups) do
	make_transparent(name)
end

function M.apply()
	for _, name in ipairs(groups) do
		make_transparent(name)
	end
end

function M.setup()
	vim.api.nvim_create_autocmd({ "ColorScheme" }, {
		callback = M.apply,
	})
	M.apply()
end

return M
