return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim", 
        "MunifTanjim/nui.nvim", 
        "nvim-tree/nvim-web-devicons" -- optional, but recommended
    },
    config = function()
        -- Setup Neo-tree with some basic configuration
        require("neo-tree").setup({
            close_if_last_window = true, -- Close Neo-tree if it's the last window left
            filesystem = {
                follow_current_file = {
                    enabled = true, -- This will focus the file in the tree when switching buffers
                },
            } 
        })
        
        -- Toggle Neo-tree with leader + e
        vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', {
            desc = 'Toggle Neo-tree file explorer'
        })
    end,
    lazy = false  
}
