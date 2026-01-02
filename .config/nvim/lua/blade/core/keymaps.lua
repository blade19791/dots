-- Create shorter alias
local map = vim.keymap.set

-- Define common options
local opts = { noremap = true, silent = true }

-- WINDOW NAVIGATION
map("n", "<C-l>", "<C-w>l", {
	desc = "Move to right window",
})
map("n", "<C-h>", "<C-w>h", {
	desc = "Move to left window",
})
map("n", "<C-k>", "<C-w>k", {
	desc = "Move to up window",
})
map("n", "<C-j>", "<C-w>j", {
	desc = "Move to down window",
})

-- INSERT MODE EXIT
map("i", "jk", "<Esc>", {
	desc = "Exit insert mode",
})
map("i", "kj", "<Esc>", {
	desc = "Exit insert mode",
})

-- QUALITY OF LIFE
-- Save and quit
map("n", "<leader>w", ":w<CR>", {
	desc = "Save file",
})
map("n", "<leader>q", ":q<CR>", {
	desc = "Quit window",
})
map("n", "<leader>Q", ":q!<CR>", {
	desc = "Force quit",
})

-- Buffer navigation
map("n", "<S-l>", ":bnext<CR>", {
	desc = "Next buffer",
})
map("n", "<S-h>", ":bprevious<CR>", {
	desc = "Previous buffer",
})
map("n", "<leader>bb", ":bdelete<CR>", { desc = "Close current buffer" })

-- Clear search highlight
map("n", "<leader>nh", ":nohlsearch<CR>", {
	desc = "Clear search highlights",
})

-- Better indent in visual mode
map("v", "<", "<gv", {
	desc = "Indent left and keep selection",
})
map("v", ">", ">gv", {
	desc = "Indent right and keep selection",
})

-- Close current buffer
map("n", "<leader>x", ":bd<CR>", {
	desc = "Close buffer",
})

-- Move lines up/down in normal & visual mode
map("n", "<A-j>", ":m .+1<CR>==", {
	desc = "Move line down",
})
map("n", "<A-k>", ":m .-2<CR>==", {
	desc = "Move line up",
})
map("v", "<A-j>", ":m '>+1<CR>gv=gv", {
	desc = "Move selection down",
})
map("v", "<A-k>", ":m '<-2<CR>gv=gv", {
	desc = "Move selection up",
})

-- Keep cursor centered when jumping
map("n", "n", "nzzzv", {
	desc = "Next search result centered",
})
map("n", "N", "Nzzzv", {
	desc = "Prev search result centered",
})
vim.keymap.set("n", "J", "mzJ`z", {
	desc = "Join lines and keep cursor",
})

-- Window management
map("n", "<leader>v", "<C-w>v", opts) -- split window vertically
map("n", "<leader>h", "<C-w>s", opts) -- split window horizontally
map("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
map("n", "<leader>xs", ":close<CR>", opts) -- close current split window

-- Tabs
map("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
map("n", "<leader>tc", ":tabclose<CR>", opts) -- close current tab
map("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
map("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab

-- Toggle line wrapping
map("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Resize with arrows
map("n", "<Up>", ":resize -2<CR>", opts)
map("n", "<Down>", ":resize +2<CR>", opts)
map("n", "<Left>", ":vertical resize -2<CR>", opts)
map("n", "<Right>", ":vertical resize +2<CR>", opts)

local terminal_buf = nil

local function toggle_terminal()
	if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
		-- If terminal buffer exists and is valid, delete it
		vim.cmd("bdelete! " .. terminal_buf)
		terminal_buf = nil
	else
		-- Open a new terminal in a horizontal split and store its buffer ID
		vim.cmd("split | terminal")
		terminal_buf = vim.api.nvim_get_current_buf()
	end
end

map("n", "<leader>t", toggle_terminal, opts)

-- Exit terminal mode with jk
vim.api.nvim_set_keymap("t", "jk", "<C-\\><C-n>", {
	noremap = true,
	silent = true,
})

-- Reload Neovim config without restarting
map("n", "<leader>cr", function()
	for name, _ in pairs(package.loaded) do
		if name:match("^user") or name:match("^plugins") then
			package.loaded[name] = nil
		end
	end
	dofile(vim.fn.stdpath("config") .. "/init.lua")
	print("Config reloaded!")
end, {
	desc = "Reload Neovim config",
})

-- -- Toggle next theme
-- vim.keymap.set("n", "<leader>tt", function()
-- 	require("core.themes").next()
-- end, { desc = "Toggle themes" })
--
-- -- Pick theme via Telescope
-- vim.keymap.set("n", "<leader>ft", function()
-- 	require("core.themes").pick()
-- end, { desc = "Pick theme (Telescope)" })

-- telescope theme keymaps
vim.keymap.set("n", "<leader>ft", function()
	local telescope = require("telescope.builtin")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local theme = require("blade.core.theme")

	telescope.colorscheme({
		enable_preview = true,
		attach_mappings = function(_, map)
			map("i", "<CR>", function(bufnr)
				local selection = action_state.get_selected_entry()
				actions.close(bufnr)
				theme.set(selection.value)
			end)

			map("n", "<CR>", function(bufnr)
				local selection = action_state.get_selected_entry()
				actions.close(bufnr)
				theme.set(selection.value)
			end)

			return true
		end,
	})
end, { desc = "Select & save colorscheme" })
