# Blade's Dotfiles

Welcome to my dotfiles repository! This project houses my personal configuration files for various tools and applications I use on a daily basis.

## Overview

Included in this repository:
- **Neovim** (`.config/nvim`): A custom Lua-based Neovim configuration featuring extensive plugins, LSP integrations, and a centralized theme manager.
- **Kitty Terminal** (`.config/kitty`): A fast, feature-rich, GPU-based terminal emulator configuration with multiple themes.
- **Starship Prompt** (`.config/starship`): A blazing-fast cross-shell prompt configuration.
- **Zsh** (`.zshrc`): My personal zsh configuration.
- **Theme Synchronization Mechanism**: A seamless, automated theme synchronization tool tightly coupling Kitty and Neovim.

### Noteworthy Features

**Neovim & Kitty Theme Synchronization:**
Changing a colorscheme inside Neovim instantly and persistently propagates the specific theme to your Kitty terminal instance!
- When you select a new colorscheme via Telescope or standard `::colorscheme <theme>` commands, Neovim automatically saves the state to `~/.config/theme/current_theme`.
- It executes real-time terminal escape sequence updates to currently running Kitty windows.
- It updates `kitty.conf` seamlessly so new windows spawn with the new theme intact.
- Upon focus, if the state file changes, Neovim automatically switches to the correct active theme so multiple instances stay perfectly in sync.

## Installation Instructions

We use [GNU Stow](https://www.gnu.org/software/stow/) to securely manage dotfile symlinks directly from this repository into your `$HOME` directory. This means you can freely modify `~/Desktop/dots` files and the changes instantly apply system-wide without manually copying files around.

1. **Prerequisites**
   Ensure you have GNU stow installed:
   - On Debian/Ubuntu: `sudo apt install stow`
   - On Arch Linux: `sudo pacman -S stow`
   - On macOS: `brew install stow`

2. **Clone the repository** (if you haven't already):
   ```bash
   git clone https://github.com/blade/dots.git ~/Desktop/dots
   ```

3. **Install the dotfiles**
   Navigate to the repository and run the quickstart installation script:
   ```bash
   cd ~/Desktop/dots
   ./install.sh
   ```

Now, any changes made to `~/.config/nvim` or other stowed applications will identically reflect in this `~/Desktop/dots` folder, giving you full Git-control directly where you need it!
