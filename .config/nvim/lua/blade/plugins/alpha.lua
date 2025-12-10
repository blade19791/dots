return {
    "goolord/alpha-nvim",
    dependencies = {"echasnovski/mini.icons"},
    config = function()
        local dashboard = require("alpha.themes.dashboard")

        -- Your ASCII header
        dashboard.section.header.val = {"                    ⢀⣀⣤⣤⣤⣤⣄⡀⠀⠀⠀ ",
                                        "                ⠀⢀⣤⣾⣿⣾⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀",
                                        "                ⢠⣾⣿⢛⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀",
                                        "                ⣾⣯⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧",
                                        "                ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                                        "                ⣿⡿⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠻⢿⡵",
                                        "                ⢸⡇⠀⠀⠉⠛⠛⣿⣿⠛⠛⠉⠀⠀⣿⡇",
                                        "                ⢸⣿⣀⠀⢀⣠⣴⡇⠹⣦⣄⡀⠀⣠⣿⡇",
                                        "                ⠈⠻⠿⠿⣟⣿⣿⣦⣤⣼⣿⣿⠿⠿⠟⠀",
                                        "                ⠀⠀⠀⠀⠸⡿⣿⣿⢿⡿⢿⠇⠀⠀⠀⠀",
                                        "                ⠀⠀⠀⠀⠀⠀⠈⠁⠈⠁⠀⠀⠀⠀⠀⠀",
                                        "                                                  ",
                                        "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
                                        "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
                                        "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
                                        "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
                                        "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
                                        "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
                                        "                                                  ",
                                        "      Welcome to Neovim, by Ciech M. Makuei   "}

        -- Buttons with nice icons
        dashboard.section.buttons.val = {dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
                                         dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
                                         dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
                                         dashboard.button("t", "󱎸  Find text", ":Telescope live_grep <CR>"),
                                         dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
                                         dashboard.button("q", "󰈆  Quit Neovim", ":qa<CR>")}

        -- Optional footer
        dashboard.section.footer.val = {"Neovim v" .. vim.version().major .. "." .. vim.version().minor .. "." ..
            vim.version().patch}

        require("alpha").setup(dashboard.config)
    end
}
