#!/usr/bin/env bash

THEME_DIR="$HOME/.config/kitty/themes"
STATE_FILE="$HOME/.config/theme/current_theme"

echo "Available themes:"
ls "$THEME_DIR" | nl

echo ""
read -p "Enter theme number: " choice

THEME=$(ls "$THEME_DIR" | sed -n "${choice}p")

if [ -z "$THEME" ]; then
  echo "Invalid choice"
  exit 1
fi

echo "Switching to: $THEME"

# Apply to Kitty
kitty @ set-colors -a "$THEME_DIR/$THEME"

# Save current theme (remove .conf)
THEME_NAME=$(basename "$THEME" .conf)
echo "$THEME_NAME" > "$STATE_FILE"

# Persist in kitty.conf
sed -i "s|^include .*|include themes/$THEME|" ~/.config/kitty/kitty.conf

echo "Theme synced!"
