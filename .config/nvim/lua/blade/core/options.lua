local opt = vim.opt

----------------------------------------------------------
-- UI & Editing Behavior
----------------------------------------------------------
opt.number = true                -- Show line numbers
opt.relativenumber = true        -- Relative numbers
opt.wrap = true                  -- Line wrapping enabled
opt.linebreak = true             -- Wrap at word boundaries
opt.scrolloff = 8                -- Keep 8 lines when scrolling
opt.sidescrolloff = 8            -- Keep 8 columns side scrolling
opt.signcolumn = "yes"           -- Always show sign column
opt.splitright = true            -- Vertical splits open right
opt.splitbelow = true            -- Horizontal splits open below
opt.mouse = "a"                  -- Enable mouse
opt.termguicolors = true         -- Enable true color support
vim.cmd("syntax on")             -- Syntax highlighting

----------------------------------------------------------
-- Tabs & Indentation
----------------------------------------------------------
opt.tabstop = 4                  -- Tab width
opt.shiftwidth = 4               -- Indentation width
opt.softtabstop = 4              -- Tab in insert mode
opt.expandtab = true			 -- Converts tabs → spaces
opt.autoindent = true			 -- Indent level follows previous line

----------------------------------------------------------
-- Search Behavior
----------------------------------------------------------
opt.ignorecase = true            -- Ignore case when searching
opt.smartcase = true             -- If uppercase used, search becomes sensitive
opt.incsearch = true             -- Incremental search
opt.hlsearch = true              -- Highlight search results
opt.cursorline = true            -- Easy to see where your cursor is in large files
opt.cursorlineopt = "both"		 -- Highlight number + full line

----------------------------------------------------------
-- Performance & Timings
----------------------------------------------------------
opt.updatetime = 300             -- Faster UI response
opt.timeoutlen = 500             -- Faster mapped sequence recognition

----------------------------------------------------------
-- Completion Menu
----------------------------------------------------------
opt.completeopt = { "menuone", "noselect" }

----------------------------------------------------------
-- System Clipboard
----------------------------------------------------------
opt.clipboard:append("unnamedplus")  -- Use system clipboard with + register

----------------------------------------------------------
-- Undo History
----------------------------------------------------------
opt.undofile = true              -- Enable persistent undo

----------------------------------------------------------
-- Leader Key
----------------------------------------------------------
vim.g.mapleader = " "            -- Space as leader
