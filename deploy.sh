#!/bin/bash
# deploy.sh - Idiot-proof symlink creator
CONFIGS=("hyprland" "waybar" "swaync" "btop" "ghostty" "lazygit" "neofetch" "nvim" "rofi")
DOTFILES_DIR="$HOME/my-dotfiles"

if [[ $1 == "--dry-run" ]]; then
  echo "DRY RUN MODE:"
  for config in "${CONFIGS[@]}"; do
    LINK="$HOME/.config/$config"
    if [ -e "$LINK" ]; then
      if [ -L "$LINK" ]; then
        echo "⚠ Would remove symlink: $config"
      else
        echo "⚠ Would backup: $config → $config.bak-$(date +%s)"
      fi
    fi
    echo "🔗 Would create: $config → $DOTFILES_DIR/$config"
  done
  exit 0
fi

for config in "${CONFIGS[@]}"; do
  TARGET="$DOTFILES_DIR/$config"
  LINK="$HOME/.config/$config"
  
  # Skip if correct symlink exists
  if [ -L "$LINK" ] && [ "$(readlink -f "$LINK")" = "$(realpath "$TARGET")" ]; then
    echo "✓ Already correctly linked: $config"
    continue
  fi

  # Handle existing items
  if [ -e "$LINK" ]; then
    if [ -L "$LINK" ]; then
      echo "⚠ Removing invalid symlink: $config"
      rm -f "$LINK"
    else
      BACKUP="$LINK.bak-$(date +%s)"
      echo "⚠ Backing up existing $config to $BACKUP"
      mv "$LINK" "$BACKUP"
    fi
  fi

  # Create parent directory if needed
  mkdir -p "$(dirname "$LINK")"

  # Create symlink
  ln -sf "$TARGET" "$LINK"
  echo "🔗 Created new symlink: $config → $TARGET"
done

echo "✅ All dotfiles deployed"
