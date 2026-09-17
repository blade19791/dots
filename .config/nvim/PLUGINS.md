# Blade — Neovim plugin & keymap reference

The active `~/.config/nvim` is a hand-ported copy of **omarchy**'s Neovim
setup. omarchy itself is built on **LazyVim** (Lazy.nvim + the LazyVim plugin
set); blade took the **plugin list** (same repos, same LazyVim specs) but
replaced LazyVim's bundled config/LazyVim-flavored helpers with plain
equivalents so it runs standalone.

This file documents **every plugin** in the config: what it is, how it works,
how it's used, and its keymaps. Plugin specs live in
`lua/blade/plugins/*.lua`, core logic in `lua/blade/core/*.lua`.

Legend used below: `<leader>` = `Space`, `<S-…>` = shift key.

---

## Core modules (not plugins — blade's own code)

### `lua/blade/core/transparency.lua`
Mirrors omarchy's `plugin/after/transparency.lua`: makes the listed highlight
groups **background-transparent** while preserving all their other attributes.
It re-applies on every `ColorScheme` change, so switching desktop themes keeps
the transparent look.

Groups made transparent: `Normal`, `NormalFloat`, `FloatBorder`, `Pmenu`,
`Terminal`, `EndOfBuffer`, `FoldColumn`, `Folded`, `SignColumn`, `LineNr`,
`CursorLineNr`, `NormalNC`, `WhichKeyFloat`, `TelescopeBorder/Normal/Prompt*`,
`NeoTree*`/`NvimTree*` (normal/vert-split/end-of-buffer), `BufferLine*`,
`TabLine*`, and the `Notify*` body/title/border groups.

On top of that, the **window separators are removed entirely** the easy way —
`options.lua` sets `fillchars = { vert = " ", eob = " " }`. So the dividers
between neo-tree / terminal / buffers / code space are just empty space, on
any theme.

### `lua/blade/core/theme.lua`
Syncs Neovim's colorscheme to the **desktop (omarchy) theme** automatically.

- Reads the active theme from `~/.local/state/omarchy/current/theme.name`
  (e.g. `gruvbox`, `catppuccin-latte`).
- Maps it to a matching Neovim colorscheme (`gruvbox → gruvbox`,
  `catppuccin-latte → catppuccin`, `tokyo-night → tokyonight-night`, …).
- Watches for changes: on `FocusGained`, `BufEnter`, and every 3 s it
  re-reads the file and applies the theme if it changed. Apply the desktop
  theme from within the editor:
- `<leader>ft` opens the **Omarchy theme picker** — pick a theme and Neovim
  *and the whole desktop* change together.
- `theme.set_desktop_theme(name)` drives `omarchy theme set <name>` so the
  shell/GTK/Hyprland/kitty all follow, and Neovim follows them right back.

### `lua/blade/core/remote_clipboard.lua`
Clipboard that reaches **remote/other attached clients**: copies are emitted as
OSC 52 (inside tmux they become a rebroadcast tmux buffer), pastes prefer the
local Wayland clipboard via `wl-copy`/`wl-paste`, and fall back to OSC 52
queries when headless/over SSH. Copied from omarchy's `remote_clipboard.lua`.

---

## Plugins by category

### Bufferline — `akinsho/bufferline.nvim`
Buffer "tabs" with filetype icons, close buttons, and per-tab diagnostics.
Depends on `vim-bbye` (buffer delete without breaking the layout) and
`mini.icons`. It mirrors omarchy/LazyVim's spec exactly, including the
`close_command = Bdelete` behavior.

| Key | Action |
| --- | --- |
| `<S-h>` / `<S-l>` | Go to previous / next buffer |
| `[b` / `]b` | Prev / next buffer (alternate) |
| `[B` / `]B` | Move buffer left / right |
| `<leader>bp` | Toggle pin |
| `<leader>bP` | Delete non-pinned buffers |
| `<leader>br` | Close buffers to the right |
| `<leader>bl` | Close buffers to the left |
| `<leader>bj` | Pick a buffer (menu) |

### Neo-tree — `nvim-neo-tree/neo-tree.nvim`
File explorer. Tree, filesystem, git_status and buffer sources.

| Key | Action |
| --- | --- |
| `<leader>e` | Toggle the file tree |

Icons/transparency handled by the core modules above; follows `cwd`, shows
hidden files, highlights git status.

### Smear Cursor — `sphamba/smear-cursor.nvim`
Draws a smooth animated "cursor smear" when the cursor moves across the
screen (omarchy's visual polish). No keymaps.

### Alpha dashboard — `goolord/alpha-nvim`
Startup dashboard with the omarchy banner and quick actions.

| Key | Action |
| --- | --- |
| `e` | New file |
| `f` | Find file (`Telescope find_files`) |
| `r` | Recently used files (`Telescope oldfiles`) |
| `t` | Find text (`Telescope live_grep`) |
| `c` | Edit config (`~/.config/nvim/init.lua`) |
| `q` | Quit |

### Which-key — `folke/which-key.nvim`
Popup that shows available leader keymaps as you type a prefix.

| Key | Action |
| --- | --- |
| `<leader>?` | Show all buffer/local keymaps |

Groups set for the leader key `Space` (code, diagnostics, file, git, session,
search, …).

### Flash — `folke/flash.nvim`
Enhanced search jumps with matched-labels (LazyVim's `flash`).

| Key | Mode | Action |
| --- | --- | --- |
| `s` | n/x/o | Flash jump |
| `S` | n/x/o | Flash treesitter |
| `r` | o | Remote flash |
| `R` | o/x | Treesitter search |
| `<C-s>` | c | Toggle flash in cmdline |

### Autotag — `windwp/nvim-ts-autotag`
Automatically close and rename HTML/JSX/TSX tags via treesitter. No keymaps.

### Auto pairs — `windwp/nvim-autopairs` + `windwp/nvim-ts-autotag` + `kylechui/nvim-surround`
- `nvim-autopairs`: auto-closes quotes/brackets everywhere; adds custom rules
  for `/* */` pairs and LaTeX `\begin{}`/`\end{}`.
- `nvim-ts-autotag`: HTML/JSX tag autoclose.
- `nvim-surround`: surround/delete/change with `ys`, `ds`, `cs` (omarchy style).

### Treesitter — `nvim-treesitter/nvim-treesitter`
Grammar-aware highlighting (auto-installs parsers for lua, vim, js/ts/jsx/tsx,
json, html, css, python, rust, go, java, c/cpp, php, sql, bash), indenting,
and **incremental selection**.

| Key | Action |
| --- | --- |
| `gnn` | Init selection |
| `grn` / `grc` / `grm` | Node / scope / select bigger node |
| `]f`/`[f` … textobjects | Move between functions/classes/params (see textobjects) |

### Textobjects — `nvim-treesitter/nvim-treesitter-textobjects`
Move/select on syntax objects.

| Key | Action |
| --- | --- |
| `]f` `[f` `]c` `[c` `]a` `[a` | Next/prev function / class / parameter |
| `]F` `[F` `]C` `[C` `]A` `[A` | Same, at object end |
| `a`/`i` + object (op mode) | Select / inside object (text objects) |

### Telescope — `nvim-telescope/telescope.nvim`
Fuzzy finder.

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files (hidden shown, rg) |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>ps` | Live grep for word under cursor |
| `<C-j>` / `<C-k>` | Next / prev in insert picker |

### Formatting — `stevearc/conform.nvim`
Format on save via Prettier / Stylua / isort+black / sql-formatter, with LSP
fallback.

| Key | Action |
| --- | --- |
| `<leader>mp` | Format file (or range in visual) |

### Noice — `folke/noice.nvim`
Modern UI for messages, cmdline and popup menus; LSP progress + routing
(LazyVim preset). Uses `nui.nvim`.

| Key | Action |
| --- | --- |
| `<leader>snl` | Noice last message |
| `<leader>snh` | Noice history |
| `<leader>sna` | All noice messages |
| `<leader>snd` | Dismiss all |
| `<leader>snt` | Noice picker |
| `<S-Enter>` | Redirect cmdline to current buffer |
| `<C-f>` / `<C-b>` | Scroll noice forward / backward |

### Grug-far (`MagicDuck/grug-far.nvim`)
Search-and-replace project-wide (LazyVim `grug-far`).

| Key | Action |
| --- | --- |
| `<leader>sr` | Open GrugFar (filetype filter prefilled) |

### Gitsigns — `lewis6991/gitsigns.nvim`
Inline git signs (`+ ~ _` glyphs, staged variants) in the sign column. No
custom keymaps beyond the defaults (hunks navigation with `[h`/`]h` comes
from LazyVim's gitsigns defaults).

### LSP — `nvim-lspconfig`, `mason.nvim`, `nvim-cmp` + `cmp-*` sources
- `mason.nvim`: install language servers/formatters/linters.
- `nvim-lspconfig`: inlay hints + `vim.lsp.buf.*` LSP actions.
- `nvim-cmp` + `LuaSnip`: completion popup with priority sorting.

| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `gr` | References (via Telescope) |
| `<leader>cd` | LSP diagnostics (line) |
| `<leader>ca` / `<leader>cw` | Code action / workspace action |
| `<leader>cl` | LSP logs |
| `<leader>cm` | Mason (install servers) |
| `<Tab>` / `<S-Tab>` | Complete / jump snippet |
| `<C-Space>` | Force completion |
| `<C-b>` / `<C-f>` | Scrub completion docs |
| `<CR>` | Confirm selection |

### Lualine — `nvim-lualine/lualine.nvim`
Statusline + tabline (mode, branch, diff, diagnostics, filename, encoding,
filetype, progress, location). Component/arrow separators for the omarchy
lookcars.

### Indent guides — `lukas-reineke/indent-blankline.nvim`
Indentation guides (`▏`); hidden in help/startify/dashboard/neotree/etc.

### Todo comments — `folke/todo-comments.nvim`
Highlight TODO/FIX/HACK/etc comments.

| Key | Action |
| --- | --- |
| `]t` / `[t` | Next / previous todo comment |
| `<leader>st` | List all (Telescope) |

### Textobjects / which-key / theme plugins…
`blade/plugins/textobjects.lua`, `theme.lua` (all theme colorschemes lazily
loaded, driven by the desktop theme), `formatting.lua` above.

---

## Omarchy-theme sync memory

- Desktop theme → Neovim: `~/.local/state/omarchy/current/theme.name`.
- Change theme from Neovim: `<leader>ft` (opens Omarchy theme picker).
- Themes are colorscheme plugins (catppuccin, gruvbox, kanagawa, rose-pine,
  tokyonight, …) lazy-loaded with `priority = 1000` so the active one applies
  first, exactly like omarchy.

## Where the config lives

- Active editor: `~/.config/nvim` → symlink to
  `~/Projects/dots/.config/nvim`.
- omarchy's original backup: `~/.config/nvim-omarchy.backup` (restore with
  `mv ~/.config/nvim-omarchy.backup ~/.config/nvim` + `:Lazy sync`).
