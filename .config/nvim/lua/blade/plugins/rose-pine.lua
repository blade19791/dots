return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      variant = "main", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for bad syntax combinations
        migrations = true, -- Handle deprecated options automatically
      },

      styles = {
        bold = true,
        italic = true,
        transparency = true,
        comment = { italic = true },
        keyword = { italic = true },
        -- Change specific highlight groups
        -- HighlightGroup = { fg = "pine", bg = "love" },
      },

      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        warn = "gold",

        git_add = "foam",
        git_change = "gold",
        git_delete = "love",
        git_ignore = "muted",
        git_rename = "iris",
        git_stage = "iris",

        diag_error = "love",
        diag_hint = "iris",
        diag_info = "foam",
        diag_warn = "gold",
      },

      -- HL groups to change (using a function is recommended)
      before_highlight = function(group, highlight, palette)
        -- Disable background for LspInfo
        if group == "LspInfo" then
          highlight.bg = "none"
        end
      end,
    })
    vim.cmd([[colorscheme rose-pine]])
  end,
}