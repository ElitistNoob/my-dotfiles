#!/bin/bash
# deploy.sh
CONFIGS=("hypr" "waybar" "swaync" "btop" "ghostty" "lazygit" "neofetch" "nvim" "rofi")

for config in "${CONFIGS[@]}"; do
  rm -rf ~/.config/$config
  ln -sf ~/my-dotfiles/$config ~/.config/$config
  echo "Linked: $config"
done
