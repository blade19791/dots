return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
        "moll/vim-bbye",
        "echasnovski/mini.icons",
    },
    keys = {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
        { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
        { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete Buffers to the Right" },
        { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to the Left" },
        { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
        { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
        { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
        { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
        { "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer prev" },
        { "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer next" },
        { "<leader>bj", "<cmd>BufferLinePick<cr>",                 desc = "Pick Buffer" },
    },
    init = function()
        -- omarchy (LazyVim) serves nvim-web-devicons from mini.icons, which is
        -- where the filetype icons in the bufferline come from.
        package.preload["nvim-web-devicons"] = function()
            require("mini.icons").mock_nvim_web_devicons()
            return package.loaded["nvim-web-devicons"]
        end
    end,
    opts = {
        options = {
            mode = "buffers", -- buffers, not tabpages: renders even with a single tabpage
            -- omarchy closes the buffer but keeps the window (Snacks.bufdelete);
            -- vim-bbye's :Bdelete does the same thing here.
            -- stylua: ignore
            close_command = function(n)
                vim.cmd.Bdelete(n)
            end,
            -- stylua: ignore
            right_mouse_command = function(n)
                vim.cmd.Bdelete(n)
            end,
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
            diagnostics_indicator = function(_, _, diag)
                local icons = {
                    Error = "",
                    Warn = "",
                    Hint = "",
                    Info = "",
                }
                local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                    .. (diag.warning and icons.Warn .. diag.warning or "")
                return vim.trim(ret)
            end,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo-tree",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
            -- Same small per-filetype overrides as LazyVim.config.icons.ft;
            -- returning nil lets bufferline fall back to the icon provider.
            get_element_icon = function(opts)
                local icons_ft = {
                    octo = "",
                    gh = "",
                    ["markdown.gh"] = "",
                }
                return icons_ft[opts.filetype]
            end,
        },
    },
    config = function(_, opts)
        require("bufferline").setup(opts)
        -- Fix bufferline when restoring a session
        vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
            callback = function()
                vim.schedule(function()
                    pcall(nvim_bufferline)
                end)
            end,
        })
    end,
}
