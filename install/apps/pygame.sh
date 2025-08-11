#!/usr/bin/env  bash
yay -Syu
source ~/dotfiles/install/utils/common.sh
PACKAGES=(
  python-pygame
)

echo "install rust packages :"
install_packages "${PACKAGES[@]}"
