#!/usr/bin/env  bash
yay -Syu
source ~/dotfiles/install/utils/common.sh
PACKAGES=(
  unityhub
  mono
)

echo "install unity packages :"
install_packages "${PACKAGES[@]}"
