local M = {}

-- Omarchy stages the active theme here. `theme.name` holds the theme name
-- (e.g. "catppuccin-latte"), and `theme/colors.toml` holds the palette used
-- by Omarchy 4's generic themes (aether). Never edit these files; run
-- `omarchy theme set <name>` instead.
local state_dir = vim.fn.expand("~/.local/state/omarchy/current")
local theme_file = state_dir .. "/theme.name"
local colors_file = state_dir .. "/theme/colors.toml"

local DEFAULT_THEME = "catppuccin"

-- Map Omarchy theme name -> Neovim colorscheme. Mirrors the per-theme
-- `neovim.lua` specs shipped in /usr/share/omarchy/themes/<name>/.
local theme_map = {
  ["catppuccin"] = "catppuccin",
  ["catppuccin-latte"] = "catppuccin-latte",
  ["everforest"] = "everforest",
  ["flexoki-light"] = "flexoki-light",
  ["gruvbox"] = "gruvbox",
  ["hackerman"] = "hackerman",
  ["kanagawa"] = "kanagawa",
  ["lumon"] = "lumon",
  ["matte-black"] = "matteblack",
  ["nord"] = "nordfox",
  ["osaka-jade"] = "bamboo",
  ["retro-82"] = "retro-82",
  ["rose-pine"] = "rose-pine-dawn",
  ["solitude"] = "ashen",
  ["tokyo-night"] = "tokyonight-night",
  -- Omarchy 4 generic themes are rendered through aether with the palette
  -- injected from colors.toml (see default/themed/neovim.lua.tpl).
  -- ethereal = "aether", last-horizon = "aether", lupine = "aether",
  -- miasma = "aether", ristretto = "aether", vantablack = "aether", white = "aether",
}

-- colors.toml key -> aether colors key (from default/themed/neovim.lua.tpl)
local aether_map = {
  bg = "background",
  dark_bg = "dark_background",
  darker_bg = "darker_background",
  lighter_bg = "lighter_background",
  fg = "foreground",
  dark_fg = "dark_foreground",
  light_fg = "light_foreground",
  bright_fg = "bright_foreground",
  muted = "muted",
  red = "red",
  yellow = "yellow",
  orange = "orange",
  green = "green",
  cyan = "cyan",
  blue = "blue",
  magenta = "magenta",
  brown = "brown",
  bright_red = "bright_red",
  bright_yellow = "bright_yellow",
  bright_green = "bright_green",
  bright_cyan = "bright_cyan",
  bright_blue = "bright_blue",
  bright_magenta = "bright_magenta",
  accent = "accent",
  cursor = "bright_foreground",
  foreground = "foreground",
  background = "background",
  selection = "selection",
  selection_foreground = "selection_foreground",
  selection_background = "selection_background",
}

-- The Omarchy 4 generic themes (aether)
local aether_themes = {
  "ethereal",
  "last-horizon",
  "lupine",
  "miasma",
  "ristretto",
  "vantablack",
  "white",
}

local function read_theme()
  local f = io.open(theme_file, "r")
  if f then
    local content = f:read("*l")
    f:close()
    return content
  end
  return nil
end

local function read_toml(path)
  local values = {}
  local f = io.open(path, "r")
  if not f then
    return values
  end
  for line in f:lines() do
    local key, value = line:match("^%s*(%S+)%s*=%s*\"?([^\"\n]+)\"?%s*$")
    if key and value then
      values[key] = value
    end
  end
  f:close()
  return values
end

-- Ensure lazy.nvim loads the plugin that provides `colorscheme`, then apply it.
local function load_colorscheme(name)
  local ok, loader = pcall(require, "lazy.core.loader")
  if ok and loader and loader.colorscheme then
    pcall(loader.colorscheme, name)
  end
end

local function apply_colorscheme(name)
  load_colorscheme(name)
  pcall(vim.cmd, "colorscheme " .. name)
  return true
end

-- Apply an Omarchy 4 generic theme: build aether colors opts from the staged
-- colors.toml and reload aether with them.
local function apply_aether()
  local values = read_toml(colors_file)
  local colors = {}
  for aether_key, colors_key in pairs(aether_map) do
    if values[colors_key] then
      colors[aether_key] = values[colors_key]
    end
  end
  load_colorscheme("aether")
  local ok, aether = pcall(require, "aether")
  if ok and aether then
    if aether.setup then
      pcall(aether.setup, colors)
    end
    pcall(vim.cmd, "colorscheme aether")
  end
end

local function apply_theme()
  local theme = read_theme()
  if not theme then
    return
  end

  local colorscheme = theme_map[theme]
  if colorscheme then
    if colorscheme ~= vim.g.colors_name then
      apply_colorscheme(colorscheme)
    end
  else
    local is_aether = false
    for _, name in ipairs(aether_themes) do
      if name == theme then
        is_aether = true
        break
      end
    end
    if is_aether and vim.g.colors_name ~= "aether" then
      apply_aether()
    end
  end
end

-- Curated, clickable list of Omarchy themes for the in-editor picker.
-- Returns a sorted array of { name, colorscheme }.
function M.list_themes()
  local items = {}
  for name, colorscheme in pairs(theme_map) do
    table.insert(items, { name, colorscheme })
  end
  for _, name in ipairs(aether_themes) do
    table.insert(items, { name, "aether" })
  end
  table.sort(items, function(a, b)
    return a[1] < b[1]
  end)
  return items
end

-- Change the desktop theme from inside Neovim. This drives `omarchy theme
-- set`, so the desktop (Hyprland, kitty, shell...) and every open editor
-- follow — and Neovim's watcher picks the new theme up in a few seconds.
function M.set_desktop_theme(name)
  vim.fn.jobstart({ "omarchy", "theme", "set", name }, { detach = true })
  vim.notify("Setting theme '" .. name .. "'...", vim.log.levels.INFO, {
    title = "Omarchy",
  })
end

M.setup = function()
  apply_theme()

  -- Re-sync when Omarchy changes the theme (e.g. `omarchy theme set` from
  -- the launcher) while Neovim keeps running.
  vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    callback = apply_theme,
  })

  local timer = vim.uv.new_timer()
  timer:start(0, 3000, function()
    vim.schedule(apply_theme)
  end)
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      timer:stop()
      timer:close()
    end,
  })
end

return M