#!/bin/bash

# Ensure we are in the dots directory before running stow
DOTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ensure stow is installed
if ! command -v stow >/dev/null 2>&1; then
    echo "Error: GNU stow is not installed."
    echo "Please install it using your package manager (e.g., 'sudo apt install stow' or 'pacman -S stow')."
    exit 1
fi

echo "Installing dotfiles using GNU Stow..."

# Use stow to symlink everything from this directory into the Home directory ($HOME).
# We ignore files that are specific to the repo and shouldn't be symlinked to ~.
cd "$DOTS_DIR"
stow -v --target="$HOME" \
    --ignore="^\.git$" \
    --ignore="^install.sh$" \
    --ignore="^README.md$" \
    .

echo ""
echo "Dotfiles successfully mirrored to $HOME!"
