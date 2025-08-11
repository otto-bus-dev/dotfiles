#!/usr/bin/env  bash
source ~/dotfiles/install/utils/common.sh
PACKAGES=(
  scratch
)

echo "install unity packages :"
install_packages "${PACKAGES[@]}"
