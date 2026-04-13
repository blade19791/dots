local M = {}

local state_file = vim.fn.expand("~/.config/theme/current_theme")
local DEFAULT_THEME = "catppuccin-frappe"

local theme_map = {
	["rose-pine"] = "rose-pine-main.conf",
	["rose-pine-dawn"] = "rose-pine-dawn.conf",
	["tokyonight-day"] = "tokyonight-day.conf",
	["tokyonight-night"] = "tokyonight-night.conf",
	["catppuccin-latte"] = "catppuccin-latte.conf",
	["catppuccin-frappe"] = "catppuccin-frappe.conf",
	["catppuccin-macchiato"] = "catppuccin-macchiato.conf",
	["catppuccin-mocha"] = "catppuccin-mocha.conf",
}

local function read_theme()
	local f = io.open(state_file, "r")
	if f then
		local content = f:read("*l")
		f:close()
		return content
	end
	return nil
end

local function sync_to_kitty(theme_name)
	local kitty_conf = theme_map[theme_name]
	if not kitty_conf then
		return
	end

	-- 1. Apply dynamically to current running kitty Window
	local kitty_theme_dir = vim.fn.expand("~/.config/kitty/themes")
	os.execute(string.format("kitty @ set-colors -a %s/%s", kitty_theme_dir, kitty_conf))

	-- 2. Persist to kitty.conf for future kitty loads
	local conf_path = vim.fn.expand("~/.config/kitty/kitty.conf")
	os.execute(string.format("sed -i 's|^include .*|include themes/%s|' %s", kitty_conf, conf_path))
end

local function apply_file_theme()
	local theme = read_theme() or DEFAULT_THEME

	-- Skip if already applied
	if theme == vim.g.colors_name then
		return
	end

	-- Try applying the theme safely, fallback if missing
	local ok = pcall(vim.cmd, "colorscheme " .. theme)
	if not ok then
		pcall(vim.cmd, "colorscheme " .. DEFAULT_THEME)
	end
end

M.setup = function()
	-- 1. Load theme on startup
	apply_file_theme()

	-- 2. Check for theme changes when regaining focus (much lighter than a real-time fs watcher)
	vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
		callback = apply_file_theme,
	})

	-- 3. Write to state file when theme is changed locally inside Nvim (e.g. Telescope)
	-- and also push updates to Kitty
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			local current = vim.g.colors_name
			if current and current ~= read_theme() then
				-- Write state
				local f = io.open(state_file, "w")
				if f then
					f:write(current .. "\n")
					f:close()
				end

				-- Sync to kitty instantaneously + persistently
				sync_to_kitty(current)
			end
		end,
	})
end

return M
