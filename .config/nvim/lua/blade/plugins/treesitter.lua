return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            -- Configuration options
            -- Install parsers synchronously
            sync_install = false,

            -- Automatically install missing parsers
            auto_install = true,

            -- List of parsers to install
            ensure_installed = {"lua", "vim", "vimdoc", "query", "javascript", "typescript", "tsx", -- JS/TS ecosystem
            "json", "html", "css", -- web technologies
            "python", "rust", "go", "java", "c", "cpp", "php" -- other languages
            },

            -- Enable highlighting
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            },
            -- Enable incremental selection
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm"
                }
            }
        })
    end
}
